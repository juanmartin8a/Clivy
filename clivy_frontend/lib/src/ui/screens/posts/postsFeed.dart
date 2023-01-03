import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/comments/commentBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentState.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesBloc.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesState.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostCubit.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostState.dart';
import 'package:untitled_client/src/bloc/forYouFollowing/forYouFollowingCubit.dart';
import 'package:untitled_client/src/bloc/like/likeBloc.dart';
import 'package:untitled_client/src/bloc/like/likeState.dart';
import 'package:untitled_client/src/bloc/loading/loadingBloc.dart';
import 'package:untitled_client/src/bloc/posts/postsBloc.dart';
import 'package:untitled_client/src/bloc/posts/postsEvent.dart';
import 'package:untitled_client/src/bloc/posts/postsState.dart';
import 'package:untitled_client/src/bloc/postsHelperBloc/postsHelperBloc.dart';
import 'package:untitled_client/src/bloc/queryVideogameCubit/queryVideogameCubit.dart';
import 'package:untitled_client/src/bloc/queryVideogameCubit/queryVideogameState.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesCubit.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/bloc/loading/loadingState.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/videogamesList.dart';
import 'package:untitled_client/src/utils/postListSliver.dart';
import 'package:untitled_client/src/utils/postListWidget.dart';
import 'package:uuid/uuid.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:provider/provider.dart';

class PostFeed extends StatefulWidget {
  final bool isFollowing;
  final String id;
  const PostFeed({
    required this.isFollowing,
    required this.id,
    required Key key
  }) : super(key: key);
  @override
  _PostFeedState createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> with AutomaticKeepAliveClientMixin {

  final ScrollController _postFeedScrollController = ScrollController();

  String uuid = Uuid().v4();

  dynamic posts; //Posts$Query$PaginatedPosts?
  int? videogameId;
  String? videogameName;
  QueryResult? queryResult;

  PostsBloc? postsBloc;

  VideogamesCubit? videogamesCubit;
  AllTapsVideogames$Query? videogames;

  bool loading = false;

  int prevIndex = 0;

  ForYouFollowingCubit? _forYouFollowingCubit;

  Map<String, dynamic> maxSizeAndPostsLengthMap = {
    "videogameId": -1,
    "maxSize": 0,
    "postsLength": 0,
  };

  bool somethingWasDeleted = false;

  double currentScrollControllerPosition = 0;

  bool isClamping = false;
  double prevControllerNum = 0.0;

  bool isVisible = true;

  late PostsHelperCubit postsHelperCubit;

  ValueNotifier<double> scrollValueNotifier = ValueNotifier<double>(0);

  // bool? postsRefreshChangeNotifierIsFollowing;

  @override
  void initState() {
    // print("ijsfnvalhbvkuaefbvkuqfevc");
    _forYouFollowingCubit = BlocProvider.of<ForYouFollowingCubit>(context);
    if (!widget.isFollowing) {
      videogamesCubit = BlocProvider.of<VideogamesCubit>(context);
      videogamesCubit!.fetchTapVideogames();
    }
    postsBloc = BlocProvider.of<PostsBloc>(context);
    postsHelperCubit = BlocProvider.of<PostsHelperCubit>(context);
    // scrollValueNotifier = 
    // postsRefreshChangeNotifier.addListener(() {
    //   // print("hey");
    //   // print(postsRefreshChangeNotifier.isFollowing);
    //   postsRefreshChangeNotifierIsFollowing = postsRefreshChangeNotifier.isFollowing;
    // });
    postsBloc!.add(FetchMoreEvent(
      limit: 1, 
      id: widget.id,
      isFetchMore: false,
      isFollowing: widget.isFollowing,
      queryResult: null
    ));
    WidgetsBinding.instance!.addPostFrameCallback((_) {

      postsBloc!.stream.listen((state) {
        // print("sapotoro");
        if (state is PostsLoadedState) {
          if (!widget.isFollowing) {
            bool isPostsNull = false;
            if (posts == null && queryResult == null) {
              isPostsNull = true;
            }
            somethingWasDeleted = false;
            if (posts != null) {
              if (state.isFirstFetch == false) {
                if (posts!.posts.length > state.posts.posts.length) {
                  if (videogameId == state.videogameId) {
                    somethingWasDeleted = true;
                  }
                }
              }
            }
            posts = state.posts;
            queryResult = state.queryResult;
            loading = false;
            if (state.videogameId != null && state.videogameName != null) {
              videogameId = state.videogameId;
              videogameName = state.videogameName;
            } else {
              // WidgetsFlutterBinding.ensureInitialized();
              if (mounted) {
                BlocProvider.of<QueryVideogameCubit>(context).selectQueryVideogame(null, null);
              }
              videogameId = null;
              videogameName = null;
            }
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              maxSizeAndPostsLengthMap["videogameId"] = videogameId != null ? videogameId : -1;
              // maxSizeAndPostsLengthMap["maxSize"] = _postFeedScrollController.position.maxScrollExtent;
              maxSizeAndPostsLengthMap["postsLength"] = posts!.posts.length - 1;
            });
            if (somethingWasDeleted == true) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (_postFeedScrollController.position.pixels >= _postFeedScrollController.position.maxScrollExtent) {
                  _postFeedScrollController.animateTo(_postFeedScrollController.position.pixels + 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
                } else {
                  _postFeedScrollController.animateTo(_postFeedScrollController.position.pixels - 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
                }
              });
            }
            // postsChangeNotifier.refresh(Uuid().v4(), posts, queryResult, widget.isFollowing);
            postsHelperCubit.posts(uuid, posts, queryResult!, widget.isFollowing);
            if (isPostsNull == true) {
              if (mounted) {
                setState(() {});
              }
            }
          }
        } else if (state is FollowingPostsLoadedState) {
          if (widget.isFollowing) {
            bool isPostsNull = false;
            if (posts == null && queryResult == null) {
              isPostsNull = true;
            }
            posts = state.posts;
            queryResult = state.queryResult;
            loading = false;
            print("length");
            print(posts.posts.length);
            BlocProvider.of<QueryVideogameCubit>(context)
              .selectQueryVideogame(null, null);
            videogameId = null;
            videogameName = null;
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              maxSizeAndPostsLengthMap["videogameId"] = videogameId != null ? videogameId : -1;
              // maxSizeAndPostsLengthMap["maxSize"] = _postFeedScrollController.position.maxScrollExtent;
              maxSizeAndPostsLengthMap["postsLength"] = posts!.posts.length - 1;
            });
            somethingWasDeleted = false;
            if (posts != null) {
              if (state.isFirstFetch == false) {
                if (posts!.posts.length > state.posts.posts.length) {
                  somethingWasDeleted = true;
                }
              }
            }
            if (somethingWasDeleted == true) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (_postFeedScrollController.position.pixels >= _postFeedScrollController.position.maxScrollExtent) {
                  _postFeedScrollController.animateTo(_postFeedScrollController.position.pixels + 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
                } else {
                  _postFeedScrollController.animateTo(_postFeedScrollController.position.pixels - 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
                }
              });
            }
            // postsChangeNotifier.refresh(Uuid().v4(), posts, queryResult, widget.isFollowing);
            postsHelperCubit.posts(uuid, posts, queryResult!, widget.isFollowing);
            if (isPostsNull == true) {
              if (mounted) {
                setState(() {});
              }
            }
          }
        }
      });
    });
    _postFeedScrollController.addListener(() { 
      // print("aaa--${_postFeedScrollController.position.pixels}");
    });
    BlocProvider.of<DeleteCubit>(context).stream.listen((state) {
      if (state is DeletePostState) {
        if (queryResult != null) {
          postsBloc!.add(DeletePostEvent(
            posts: posts,
            queryResult: queryResult!,
            deletedPostId: state.postId,
            uuid: uuid,
            missingKey: widget.isFollowing 
              ? "followingPosts" 
              : videogameId != null
                ? "videogamePosts"
                : "posts",
            isFollowing: widget.isFollowing,
            isFetchMore: posts.hasMore,
            videogameId: videogameId,
            videogameName:videogameName,
          ));
        }
      }
    });
    BlocProvider.of<LikeCubit>(context).stream.listen((state) {
      if (state is LikePostState || state is UnlikePostState) {
        if (queryResult != null) {
          dynamic likePost;
          List<dynamic> idsPostList = posts.posts.map((post) {
            if (state is LikePostState) {
              if (post.id.toInt() == state.postId) {
                likePost = post;
              }
            } else if (state is UnlikePostState) {
              if (post.id.toInt() == state.postId) {
                likePost = post;
              }
            }
            return post.id.toInt();
          }).toList();

          int? likeCubitPostId;
          var isLike;

          if (state is LikePostState) {
            likeCubitPostId = state.postId;
            isLike = true;
          } else if (state is UnlikePostState) {
            likeCubitPostId = state.postId;
            isLike = false;
          }

          if (idsPostList.contains(likeCubitPostId)) {
            postsBloc!.add(ChangePostEvent(
              posts: posts,
              queryResult: queryResult!,
              changePostId: likeCubitPostId!,
              changeMap: {
                "likeState": isLike,
                "likeCount": isLike ? likePost.likeCount + 1 : likePost.likeCount - 1
              },
              // "likeState", 
              // changeFieldVal: isLike,
              uuid: uuid,
              missingKey: widget.isFollowing
                ? "followingPosts"
                : videogameId != null
                  ? "videogamePosts"
                  : "posts",
              isFollowing: widget.isFollowing,
              isFetchMore: posts.hasMore,
              videogameId: videogameId,
              videogameName:videogameName,
            ));
          }
        }
      }
    });
    BlocProvider.of<CommentBloc>(context).stream.listen((state) {
      if (state is CommentsLoadedState) {
        if (queryResult != null) {
          dynamic postNewComment;
          List<dynamic> idsPostList = posts!.posts.map((post) {
            if (post.id.toInt() == state.comments.postId) {
              postNewComment = post;
            }
            return post.id.toInt();
          }).toList();

          if (idsPostList.contains(state.comments.postId)) {
            if (!state.isPre) {
              if (state.changed == true) {
                if (state.isNew) {
                  changeCommentCounter(postNewComment.commentCount + 1, state.comments.postId);
                } else {
                  changeCommentCounter(postNewComment.commentCount - (1 + state.replyCount!), state.comments.postId);
                }
              }
            }
          }
        }
      }
    });
    BlocProvider.of<RepliesBloc>(context).stream.listen((state) {
      if (state is RepliesShownState) {
        if (queryResult != null) {
          dynamic postNewReply;
          List<dynamic> idsPostList = posts!.posts.map((post) {
            if (post.id.toInt() == state.replyResponse.postId) {
              postNewReply = post;
            }
            return post.id.toInt();
          }).toList();

          if (idsPostList.contains(state.replyResponse.postId)) {
            if (!state.isPre) {
              if (state.changed == true) {
                if (state.newReply) {
                  changeCommentCounter(postNewReply.commentCount + 1, state.replyResponse.postId);
                } else {
                  changeCommentCounter(postNewReply.commentCount - 1, state.replyResponse.postId);
                }
              }
            }
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _postFeedScrollController.dispose();
    // postsChangeNotifier.dispose();
    scrollValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.black,
      child: VisibilityDetector(
        onVisibilityChanged: (visibilityInfo) {
          double visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage <= 0) {
            if (isVisible == true) {
              if (mounted) {
                setState(() {
                  isVisible = false;
                });
              }
            }
          } else {
            if (isVisible == false) {
              if (mounted) {
                setState(() {
                  isVisible = true;
                });
              }
            }
          }
        },
        key: Key("${widget.id}"),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            _scrollListener(scrollInfo);
            return true;
          },
          child: 
          posts != null ? 
          Container(
            key: Key(widget.isFollowing ? "postfeed_following" : "postFeed_forYou$videogameId"),
            child: CustomRefreshIndicator(
              onRefresh: () async {
                postsBloc!.add(FetchMoreEvent(
                  limit: 1,
                  id: widget.id,
                  isFetchMore: false,
                  isFollowing: widget.isFollowing,
                  queryResult: null
                ));
                await postsBloc!.stream.firstWhere((state) {
                  if (state is PostsLoadedState && widget.isFollowing == false) {
                    if (state.isMore == false) {
                      return true;
                    }
                  } else if (state is FollowingPostsLoadedState && widget.isFollowing == true) {
                    if (state.isMore == false) {
                      return true;
                    }
                  }
                  return false;
                });// (state is PostsLoadedState || state is FollowingPostsLoadedState) && ((state as PostsLoadedState).isMore == false || (state as FollowingPostsLoadedState).isMore == false));
                // return Future.delayed(const Duration(seconds: 3));
              },
              loadingToIdleDuration: Duration(milliseconds: 150),
              offsetToArmed: 50,
              onStateChanged: (val) {
                print(val);
              },
              builder: (
                BuildContext context,
                Widget child,
                IndicatorController controller,
              ) {
                return AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, _) {
                    // print(controller.value);
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        if (!controller.isIdle)
                        Positioned(
                          top: 50 + (8 * controller.value),
                          child: SizedBox(
                            height: 26,
                            width: 26,
                            child: CircularProgressIndicator(
                              color: Color(0xff00ff03),
                              strokeWidth: 3,
                              value: !controller.isLoading
                                ? controller.value.clamp(0.0, 1.0)
                                : null,
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: scrollValueNotifier,
                          builder: (context, _) {
                            double yOffset = 0;
                            // if (postsRefreshChangeNotifierIsFollowing != null) {

                              // if (widget.isFollowing == false) {
                                if (controller.isLoading == true || controller.isHiding == true) {
                                  if (
                                    currentScrollControllerPosition >= -50 &&
                                    currentScrollControllerPosition <= 0
                                  ) {
                                    yOffset = 50 - currentScrollControllerPosition.abs();
                                  }
                                }
                                return Transform.translate(
                                  offset: Offset(0, yOffset * controller.value.clamp(0, 1)),
                                  child: child,
                                );
                              // }
                            // } 
                            // return child;
                          }
                        ),
                      ],
                    );
                  },
                );
              },
              child: InViewNotifierCustomScrollView(
                controller: _postFeedScrollController,
                // key: PageStorageKey<String>(widget.isFollowing ? "postfeed_following" : "postFeed_forYou$videogameId" ),
                initialInViewIds: posts != null && posts.posts.length > 0 ? ["${widget.isFollowing ? "postfeed_following" : "postFeed_forYou$videogameId"}---${posts.posts[0].id}"] : [],
                physics: AlwaysScrollableScrollPhysics(),
                contextCacheCount: 200,
                slivers: [
                  SliverToBoxAdapter(
                    key: Key('videogamesList'),
                    child: Container(
                      margin: EdgeInsets.only(top: 43),
                      child: !widget.isFollowing ? VideogamesList(
                        id: widget.id,
                        key: Key('videogamesList'),
                      ) : Container(height: 8),
                    )
                  ),
                  PostListSliver(
                    id: widget.isFollowing ? "postfeed_following" : "postFeed_forYou$videogameId",
                    itemsList: posts.posts.map((v) => "${widget.isFollowing ? "postfeed_following" : "postFeed_forYou$videogameId"}---${v.id}").toList(),
                    posts: posts,
                    isVisible: isVisible,
                    lastIndex: prevIndex,
                    isFetchMore: true,
                    isFollowing: widget.isFollowing,
                    key: widget.isFollowing ? Key('postFeed_following') : Key('postFeed_forYou$videogameId'),
                  ),
                  SliverToBoxAdapter(
                    child: InViewNotifierWidget(
                      id: "${widget.id}---loading",
                      key: ValueKey("${widget.id}---loading"),
                      builder: (context, inView, child) {
                        return BlocBuilder<FetchPostsLoadingCubit, MorePostsLoadingState>(
                          builder: (context, loadingState) {
                            if (loadingState is LoadingMorePostsState) {
                              if (loadingState.id == widget.id) {
                                return Loader();
                              }
                              return Container();
                            }
                            return Container();
                          }
                        );
                      }
                    )
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20 + 50
                    )
                  )
                ], 
                isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
                  return deltaTop < (0.5 * viewPortDimension) &&
                    deltaBottom > (0.5 * viewPortDimension);
                },
              ),
            ),
          ) : Container()

          // NestedScrollView(
          //   controller: _postFeedScrollController,
            
          //   physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          //   // dragStartBehavior: DragStartBehavior.down,
          //   // clipBehavior: Clip.none,
          //   // scrollBehavior: ScrollBehavior,
          //   // floatHeaderSlivers: true,
          //   headerSliverBuilder: (context, _) {
          //     return [
          //       CupertinoSliverRefreshControl(
          //         // refreshIndicatorExtent: 100,
          //         // refreshTriggerPullDistance: 100,
          //         // onRefresh: () async {
          //         //   await Future<void>.delayed(
          //         //     const Duration(milliseconds: 1000),
          //         //   );
          //         // }
          //       ),
          //       SliverToBoxAdapter(
          //         child: Container(
          //           margin: EdgeInsets.only(top: 43),
          //           child: !widget.isFollowing ? VideogamesList(
          //             id: widget.id,
          //             key: Key('videogamesList'),
          //           ) : Container(height: 8),
          //         )
          //       ),
          //       // CupertinoSliverRefreshControl(onRefresh: () async {
          //       //   postsBloc!.add(FetchMoreEvent(
          //       //     limit: 1,
          //       //     id: widget.id,
          //       //     isFetchMore: false,
          //       //     isFollowing: widget.isFollowing,
          //       //     queryResult: null
          //       //   ));
          //       // }),
          //     ];
          //   },
          //   body: Builder(
          //     builder: (BuildContext context) {
          //       // final sapo = PrimaryScrollController.of(context);
          //       // // print("toroamx");
          //       // // print(sapo?.position.maxScrollExtent);
          //       // // print()
          //       // sapo?.addListener(() {
          //       //   print(sapo.position.pixels);
          //       // });
          //       return BlocBuilder<PostsBloc, PostsState>(
          //         builder: (context, state) {
          //           // if (state is PostsInitState || state is PostsLoadingState) {
          //           //   return Container(child: Text('loading...'));
          //           // }
          //           if (state is PostsLoadedState) {
          //             if (!widget.isFollowing) {
          //               somethingWasDeleted = false;
          //               if (posts != null) {
          //                 if (state.isFirstFetch == false) {
          //                   if (posts!.posts.length > state.posts.posts.length) {
          //                     if (videogameId == state.videogameId) {
          //                       somethingWasDeleted = true;
          //                     }
          //                   }
          //                 }
          //               }
          //               posts = state.posts;
          //               queryResult = state.queryResult;
          //               loading = false;
          //               // print(posts);
          //               if (state.videogameId != null && state.videogameName != null) {
          //                 videogameId = state.videogameId;
          //                 videogameName = state.videogameName;
          //               } else {
          //                 BlocProvider.of<QueryVideogameCubit>(context)
          //                   .selectQueryVideogame(null, null);
          //                 videogameId = null;
          //                 videogameName = null;
          //               }
          //               WidgetsBinding.instance!.addPostFrameCallback((_) {
          //                 maxSizeAndPostsLengthMap["videogameId"] = videogameId != null ? videogameId : -1;
          //                 maxSizeAndPostsLengthMap["maxSize"] = _postFeedScrollController.position.maxScrollExtent;
          //                 maxSizeAndPostsLengthMap["postsLength"] = posts!.posts.length - 1;
          //               });
          //               // somethingWasDeleted = false;
          //               // if (posts != null) {
          //               //   if (posts!.posts.length > state.posts.posts.length) {
          //               //     if (videogameId == state.videogameId) {
          //               //       somethingWasDeleted = true;
          //               //     }
          //               //   }
          //               // }
          //               if (somethingWasDeleted == true) {
          //                 WidgetsBinding.instance!.addPostFrameCallback((_) {
          //                   if (_postFeedScrollController.position.pixels >= _postFeedScrollController.position.maxScrollExtent) {
          //                     _postFeedScrollController.animateTo(_postFeedScrollController.position.pixels + 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
          //                   } else {
          //                     _postFeedScrollController.animateTo(_postFeedScrollController.position.pixels - 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
          //                   }
          //                 });
          //               }
          //             }

          //           } else if (state is FollowingPostsLoadedState) {
          //             if (widget.isFollowing) {
          //               posts = state.posts;
          //               queryResult = state.queryResult;
          //               loading = false;
          //               BlocProvider.of<QueryVideogameCubit>(context)
          //                 .selectQueryVideogame(null, null);
          //               videogameId = null;
          //               videogameName = null;
          //               WidgetsBinding.instance!.addPostFrameCallback((_) {
          //                 maxSizeAndPostsLengthMap["videogameId"] = videogameId != null ? videogameId : -1;
          //                 maxSizeAndPostsLengthMap["maxSize"] = _postFeedScrollController.position.maxScrollExtent;
          //                 maxSizeAndPostsLengthMap["postsLength"] = posts!.posts.length - 1;
          //               });
          //               somethingWasDeleted = false;
          //               if (posts != null) {
          //                 if (state.isFirstFetch == false) {
          //                   if (posts!.posts.length > state.posts.posts.length) {
          //                     somethingWasDeleted = true;
          //                   }
          //                 }
          //               }
          //               if (somethingWasDeleted == true) {
          //                 WidgetsBinding.instance!.addPostFrameCallback((_) {
          //                   if (_postFeedScrollController.position.pixels >= _postFeedScrollController.position.maxScrollExtent) {
          //                     _postFeedScrollController.animateTo(_postFeedScrollController.position.pixels + 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
          //                   } else {
          //                     _postFeedScrollController.animateTo(_postFeedScrollController.position.pixels - 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
          //                   }
          //                 });
          //               }
          //             }
          //           }
          //           // String text = "";
          //           // if (widget.isFollowing && posts != null && posts.posts.isEmpty) {
          //           //   text = "See the clips from the creators you follow here.";
          //           // } else if (posts != null && posts.posts.isEmpty && videogameId != null) {
          //           //   text = "See the clips from the creators you follow here.";
          //           // }

          //           return Container(
          //             child: widget.isFollowing && posts != null && posts.posts.isEmpty
          //             ? Container(
          //               margin: EdgeInsets.only(top: 120),
          //               // color: Colors.green,
          //               child: Align(
          //                 alignment: Alignment.topCenter,
          //                 child: Text(
          //                   "See the clips from the creators you follow here.",
          //                   style: TextStyle(
          //                     color: Colors.grey,
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w600,
          //                     height: 1
          //                   )
          //                 ),
          //               )
          //             )
          //             : 
          //             // CustomRefreshIndicator(
          //             //   onRefresh: () async {
          //             //     postsBloc!.add(FetchMoreEvent(
          //             //       limit: 1,
          //             //       id: widget.id,
          //             //       isFetchMore: false,
          //             //       isFollowing: widget.isFollowing,
          //             //       queryResult: null
          //             //     ));
          //             //     await postsBloc!.stream.firstWhere((state) => (state is PostsLoadedState || state is FollowingPostsLoadedState) && ((state as PostsLoadedState).isMore == false || (state as FollowingPostsLoadedState).isMore == false));
          //             //     // return Future.delayed(const Duration(seconds: 3));
          //             //   },
          //             //   loadingToIdleDuration: Duration(milliseconds: 150),
          //             //   offsetToArmed: 54,
          //             //   onStateChanged: (val) {
          //             //     print(val);
          //             //   },
          //             //   child: 
          //               PostListWidget(
          //                 posts: posts,
          //                 lastIndex: prevIndex,
          //                 id: widget.isFollowing ? "postfeed_following" : "postFeed_forYou$videogameId",
          //                 isFetchMore: true,
          //                 loadingWidget: BlocBuilder<FetchPostsLoadingCubit, MorePostsLoadingState>(
          //                   builder: (context, loadingState) {
          //                     if (loadingState is LoadingMorePostsState) {
          //                       if (loadingState.id == widget.id) {
          //                         return Loader();
          //                       }
          //                       return Container();
          //                     }
          //                     return Container();
          //                   }
          //                 ),
          //                 // scrollPhisics: isClamping ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
          //                 // scrollPhisics: NeverScrollableScrollPhysics(),
          //                 key: widget.isFollowing ? Key('postFeed_following') : Key('postFeed_forYou$videogameId'),
          //               ),
          //               // builder: (
          //               //   BuildContext context,
          //               //   Widget child,
          //               //   IndicatorController controller,
          //               // ) {
          //               //   return AnimatedBuilder(
          //               //     animation: controller,
          //               //     builder: (BuildContext context, _) {
          //               //       // print(controller.value);
          //               //       return Stack(
          //               //         alignment: Alignment.topCenter,
          //               //         children: <Widget>[
          //               //           if (!controller.isIdle)
          //               //           Positioned(
          //               //             top: 2 + (8 * controller.value),
          //               //             child: SizedBox(
          //               //               height: 26,
          //               //               width: 26,
          //               //               child: CircularProgressIndicator(
          //               //                 color: Color(0xff00ff03),
          //               //                 strokeWidth: 3,
          //               //                 value: !controller.isLoading
          //               //                   ? controller.value.clamp(0.0, 1.0)
          //               //                   : null,
          //               //               ),
          //               //             ),
          //               //           ),
          //               //           AnimatedBuilder(
          //               //             animation: postRefreshChangeNotifier,
          //               //             builder: (context, _) {
          //               //               double yOffset = 0;
          //               //               if (controller.isLoading == true || controller.isHiding == true) {
          //               //                 if (
          //               //                   currentScrollControllerPosition >= -54 &&
          //               //                   currentScrollControllerPosition <= 0
          //               //                 ) {
          //               //                   yOffset = 54 - currentScrollControllerPosition.abs();
          //               //                 }
          //               //               }
          //               //               return Transform.translate(
          //               //                 offset: Offset(0, yOffset * controller.value.clamp(0, 1)),
          //               //                 child: child,
          //               //               );
          //               //             }
          //               //           ),
          //               //           // Transform.translate(
          //               //           //   offset: Offset(0, 54 * controller.value),
          //               //           //   child: child,
          //               //           // )
          //               //         ],
          //               //       );
          //               //     },
          //               //   );
          //               // }
          //             // )
          //           );
          //         }
          //       );
          //     }
          //   ),
          // )
        )
        
      )
    );
  }

  void _scrollListener(ScrollNotification scrollInfo) {
    currentScrollControllerPosition = scrollInfo.metrics.pixels;
    // postsRefreshChangeNotifier.changeValue(currentScrollControllerPosition);
    scrollValueNotifier.value = currentScrollControllerPosition;
    // print(currentScrollControllerPosition);
    // print("$currentScrollControllerPosition -- ${scrollInfo.metrics.maxScrollExtent}");
    if (posts != null && queryResult != null) {
      if (posts.posts.length > 0) {
        double currentPosition = scrollInfo.metrics.pixels;
        double maxPosition = scrollInfo.metrics.maxScrollExtent;
        double threshold = MediaQuery.of(context).size.height * 1.5;
        showUnshow(scrollInfo);
        // print("toromax");
        if ((maxPosition - currentPosition) <= threshold) {
          // print("max");
          if (
            maxSizeAndPostsLengthMap["videogameId"] == (videogameId != null ? videogameId : -1) &&
            // maxSizeAndPostsLengthMap["maxSize"] == maxPosition && 
            maxSizeAndPostsLengthMap["postsLength"] == posts!.posts.length - 1
          ) {
            if (posts!.hasMore && loading == false) {
              loading = true;
              // print("hola");
              if (videogameId != null && videogameName != null) {
              print("sapo");
                prevIndex = posts!.posts.length - 1;
                postsBloc!.add(FetchMoreVideogamePostsEvent(
                  limit: 5,
                  id: widget.id,
                  isFetchMore: true,
                  videogameId: videogameId!,
                  videogameName: videogameName!,
                  queryResult: queryResult
                ));
              } else {
                prevIndex = posts!.posts.length - 1;
                postsBloc!.add(FetchMoreEvent(
                  limit: 5,
                  id: widget.id,
                  isFetchMore: true,
                  isFollowing: widget.isFollowing,
                  queryResult: queryResult
                ));
              }
            }
          }
        }
      }
    }
  }

  void showUnshow(ScrollNotification scrollInfo) {
    ScrollDirection scrollDirection = _postFeedScrollController.position.userScrollDirection;
    double position = scrollInfo.metrics.pixels;
    
    if (position <= 0) {
      _forYouFollowingCubit!.showUnshowForYouFollowingState(true);
    }
    if (scrollDirection == ScrollDirection.forward) {
      _forYouFollowingCubit!.showUnshowForYouFollowingState(true);
    } else if (scrollDirection == ScrollDirection.reverse) {
      if (position > 150) {
        _forYouFollowingCubit!.showUnshowForYouFollowingState(false);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  void changeCommentCounter(int newCount, int postId) {
    postsBloc!.add(ChangePostEvent(
      posts: posts,
      queryResult: queryResult!,
      changePostId: postId,
      changeMap: {
        "commentCount": newCount,
      },
      // "likeState", 
      // changeFieldVal: isLike,
      uuid: uuid,
      missingKey: widget.isFollowing
        ? "followingPosts"
        : videogameId != null
          ? "videogamePosts"
          : "posts",
      isFollowing: widget.isFollowing,
      isFetchMore: posts.hasMore,
      videogameId: videogameId,
      videogameName:videogameName,
    ));
  }
}