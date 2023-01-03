import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/comments/commentBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentState.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesBloc.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesState.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostCubit.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostState.dart';
import 'package:untitled_client/src/bloc/follow/followCubit.dart';
import 'package:untitled_client/src/bloc/follow/followState.dart';
import 'package:untitled_client/src/bloc/imgSize/imgSizeCubit.dart';
import 'package:untitled_client/src/bloc/imgSize/imgSizeState.dart';
import 'package:untitled_client/src/bloc/like/likeBloc.dart';
import 'package:untitled_client/src/bloc/like/likeState.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserPosts/loadingUserPostsCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserPosts/loadingUserPostsState.dart';
import 'package:untitled_client/src/bloc/profilePostsHelperBloc/profilePostsHelperBloc.dart';
import 'package:untitled_client/src/bloc/profilePostsHelperBloc/profilePostsHelperState.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostBloc.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostState.dart';
import 'package:untitled_client/src/bloc/user/userBloc.dart';
import 'package:untitled_client/src/bloc/user/userEvent.dart';
import 'package:untitled_client/src/bloc/user/userState.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsBloc.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsEvent.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsState.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/ui/helpers/profileImg.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:untitled_client/src/ui/screens/user/slivers/profileAppBar.dart';
import 'package:untitled_client/src/ui/screens/user/slivers/refreshAppBar.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/profileData.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/profilePostsGrid.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

// class Profile extends StatelessWidget {
//   final int userId;
//   final Key key;
//   const Profile({
//     required this.userId,
//     required this.key,
//     // Key mainKey = const Key("${key.toString()}0"),
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // ChangeNotifierProvider(
//         //   create: (context) => ProfileWidget(userId: userId, key: Key("${key.toString()}0"))
//         // ),
//         // ChangeNotifierProvider(
//         //   create: (context) => ProfilePostsChangeNotifier()
//         // ),
//         ChangeNotifierProvider<ProfileRefreshChangeNotifier>.value(
//           value: ProfileRefreshChangeNotifier()
//         ),
//       ],
//       child: ProfileWidget(userId: userId, key: Key("${key.toString()}0"))
//     );
//   }
// } 

class Profile extends StatefulWidget {
  final int userId;
  Profile({
    required this.userId,
    required Key key
  }) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  ValueNotifier<double> scrollValueNotifier = ValueNotifier<double>(0);

  // user
  User$Query$User? user;
  late UserBloc userBloc;

  bool? isMyProfile;

  // Uuid uuid = Uuid();
  String id = Uuid().v4();

  // posts
  QueryResult? queryResult;
  UserPosts$Query$PaginatedPosts? userPosts;
  late UserPostsBloc userPostsBloc;

  bool loading = false;

  // controller future listener
  ImgSizeCubit? imgSizeCubit;

  double currentScrollControllerPosition = 0;

  void getImgSize() {
    double? realShrinkOffset;
    double? shrinkPorcentage;
    double? stretchPorcentage;
    double? preImgSize;
    double? imgSize;
    double size = 136.0;
    double defaultImgSize = 112.0;
    double maxImgSize = 125.0;

    double currentPos = _scrollController.position.pixels;

    if (currentPos >= 0) {
      imgSizeCubit!.changeImgSize(id, defaultImgSize);
      return ;
    }

    double maxStretchSize = MediaQuery.of(context).size.height * 0.5;

    realShrinkOffset = currentPos.abs() + size;

    shrinkPorcentage = (realShrinkOffset * 1) / size;

    stretchPorcentage = ((realShrinkOffset - size) * 1) / (maxStretchSize - size);

    stretchPorcentage = ((stretchPorcentage - 0.0) * (maxImgSize - defaultImgSize)) / (1.0 - 0.0);

    preImgSize = defaultImgSize;
    if (shrinkPorcentage > 1.0) {
      preImgSize = defaultImgSize + stretchPorcentage;
    }

    if (preImgSize >= maxImgSize) {
      imgSize = maxImgSize;
    } else {
      imgSize = preImgSize;
    }

    imgSizeCubit!.changeImgSize(id, imgSize);
    return ;
  }

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FetchUserEvent(
      userId: widget.userId,
      id: id
    ));
    userPostsBloc = BlocProvider.of<UserPostsBloc>(context);
    userPostsBloc.add(FetchUserPostsEvent(
      userId: widget.userId,
      id: id,
      limit: 1,
      isFetchMore: false,
    ));
    imgSizeCubit = BlocProvider.of<ImgSizeCubit>(context);
    _scrollController.addListener(() {
      getImgSize();
      scrollListener(context);
    });
    // BlocProvider.of<UploadPostBloc>(context).stream.listen((state) {
    //   if (state is UploadPostUploadedState) {
    //     if (state.post.post!.user.id.toInt() == CurrentUser.userId) {
    //       if (queryResult != null) {
    //         userPostsBloc.add(AddPostEvent(
    //           post: UserPosts$Query$PaginatedPosts$Post.fromJson(state.post.post!.toJson()),
    //           posts: userPosts!,
    //           queryResult: queryResult!,
    //           // deletedPostId: state.postId,
    //           uuid: id,
    //           missingKey: "userPosts",
    //           isFetchMore: userPosts!.hasMore,
    //         ));
    //       }
    //     }
    //   }
    // });
    BlocProvider.of<DeleteCubit>(context).stream.listen((state) {
      if (state is DeletePostState) {
        if (queryResult != null) {
          userPostsBloc.add(DeletePostEvent(
            posts: userPosts!,
            queryResult: queryResult!,
            deletedPostId: state.postId,
            uuid: id,
            missingKey: "userPosts",
            isFetchMore: userPosts!.hasMore,
          ));
        }
      }
    });
    BlocProvider.of<FollowCubit>(context).stream.listen((state) {
      if (state is FollowUserState || state is UnfollowUserState) {
        if (user != null) {
          var isUser;
          var isFollow;
          var isMe = false;
          if (state is FollowUserState) {
            isUser = widget.userId == state.userId;
            isFollow = true;
          } else if (state is UnfollowUserState) {
            isUser = widget.userId == state.userId;
            isFollow = false;
          }

          if (CurrentUser.userId == widget.userId) {
            isMe = true;
          }

          if (isUser || isMe) {
            userBloc.add(ChangeUserEvent(
              user: user!,
              userId: widget.userId,
              changeMap: {
                "followState": isFollow,
                "followingCount": isFollow 
                  ? isMe ? user!.followingCount + 1 : user!.followingCount
                  : isMe ? user!.followingCount - 1 : user!.followingCount,
                "followersCount": isFollow 
                  ? isMe ? user!.followersCount : user!.followersCount + 1
                  : isMe ? user!.followersCount : user!.followersCount - 1,
              },
              uuid: id,
            ));
          }
        }
      }
    });
    BlocProvider.of<LikeCubit>(context).stream.listen((state) {
      if (state is LikePostState || state is UnlikePostState) {
        if (queryResult != null) {
          // List<int> idsPostList = userPosts!.posts.map((post) => post.id.toInt()).toList();

          dynamic likePost;
          List<dynamic> idsPostList = userPosts!.posts.map((post) {
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
            userPostsBloc.add(ChangePostEvent(
              posts: userPosts!,
              queryResult: queryResult!,
              changePostId: likeCubitPostId!,
              // changeField: "likeState",
              // changeFieldVal: isLike,
              changeMap: {
                "likeState": isLike,
                "likeCount": isLike ? likePost.likeCount + 1 : likePost.likeCount - 1
              },
              uuid: id,
              missingKey: "userPosts",
              isFetchMore: userPosts!.hasMore,
            ));
          }
        }
      }
    });
    BlocProvider.of<CommentBloc>(context).stream.listen((state) {
      if (state is CommentsLoadedState) {
        if (queryResult != null) {
          dynamic postNewComment;
          List<dynamic> idsPostList = userPosts!.posts.map((post) {
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
          List<dynamic> idsPostList = userPosts!.posts.map((post) {
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
    scrollValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        right: false,
        left: false,
        top: true,
        child: Container(
          color: Colors.black,
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserLoadedState) {
                if (state.isNotEdit) {
                  if (state.id == id) {
                    user = state.user;
                    isMyProfile = state.isMyProfile;
                  }
                } else {
                  if (state.user.id == widget.userId) {
                    user = state.user;
                    isMyProfile = state.isMyProfile;
                  }
                }
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 52,
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft, 
                          child: Container(
                            margin: EdgeInsets.only(left: 52), 
                            child: user != null ? Text(
                              user!.username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: user!.username.length <= 25 ? 18 : 18,
                                fontWeight: FontWeight.w700
                              )
                            ) : Container()
                          )
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              // color: Colors.red,
                              width: 52,
                              child: FloatingActions(
                                icon: EvaIcons.arrowBackOutline,
                                size: 34,
                                key: Key("goBack")
                              ),
                            ),
                          )
                        ),
                      ],
                    )
                  ),
                  Expanded(
                    child: CustomRefreshIndicator(
                      onRefresh: () async {
                        // postsBloc!.add(FetchMoreEvent(
                        //   limit: 1,
                        //   id: widget.id,
                        //   isFetchMore: false,
                        //   isFollowing: widget.isFollowing,
                        //   queryResult: null
                        // ));
                        userBloc.add(FetchUserEvent(
                          userId: widget.userId,
                          id: id
                        ));
                        userPostsBloc.add(FetchUserPostsEvent(
                          userId: widget.userId,
                          id: id,
                          limit: 1,
                          isFetchMore: false,
                        ));
                        try {
                          await Future.wait([
                            userBloc.stream.firstWhere((state) {
                              if (state is UserLoadedState) {
                                if (state.isNotEdit) {
                                  if (state.id == id) {
                                    return true;
                                  }
                                }
                              }
                              return false;
                            }),
                            userPostsBloc.stream.firstWhere((state) {
                              if (state is UserPostsLoadedState) {
                                if (state.id == id) {
                                  return true;
                                }
                              }
                              return false;
                            })
                          ]);
                        } catch (e) {
                          print("error");
                          print(e);
                        }
                        // (state is PostsLoadedState || state is FollowingPostsLoadedState) && ((state as PostsLoadedState).isMore == false || (state as FollowingPostsLoadedState).isMore == false));
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
                                  top: (8 * controller.value) + 12,
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
                      child: CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        
                        slivers: [
                          // SliverAppBar(),
                          // CupertinoSliverRefreshControl(),
                          // SliverPersistentHeader(
                          //   pinned: true,
                          //   floating: false,
                          //   delegate: ProfileAppBar(
                          //     userId: widget.userId,
                          //     user: user,
                          //   )
                          // ),
                          // SliverPersistentHeader(
                          //   // pinned: true,
                          //   floating: false,
                          //   delegate: RefreshAppBar(
                          //     // userId: widget.userId,
                          //     // user: user,
                          //   )
                          // ),
                          // SliverToBoxAdapter(
                          //   // hasScrollBody: false,
                          //   child: Expanded(
                          //     child: Container(
                          //       height: 50,
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // ),
                          SliverToBoxAdapter(
                            child: Container(
                              child: BlocBuilder<ImgSizeCubit, ImgSizeState>(
                                builder: (context, state) {
                                  double imgSize = 112.0;
                                  if (state is NewImgSizeState) {
                                    if (state.id == id) {
                                      imgSize = state.newImgSize;
                                    }
                                  }
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      // color: Colors.red,
                                      height: 136,
                                      child: Center(
                                        child: Container(
                                          height: imgSize,
                                          width: imgSize,
                                          child: user != null ? ProfileImgLoader(
                                            file: user!.file.file!,
                                            isMe: user!.id.toInt() == CurrentUser.userId,
                                            key: Key('profile_profileImg_${widget.userId}')
                                          ) : Container()
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            )
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: ProfileData(
                                  isMyProfile: isMyProfile,
                                  user: user,
                                  userId: widget.userId,
                                  key: Key("profileData_$id")
                                )
                              ),
                              Container(
                                // color: Colors.red,
                                child: BlocConsumer<UserPostsBloc, UserPostsState>(
                                  listener: (context, state) {
                                    if (state is UserPostsLoadedState) {
                                      if (state.id == id) {
                                        queryResult = state.queryResult;
                                        userPosts = state.userPosts;
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    if (user != null) {
                                      if (userPosts != null && userPosts!.posts.isEmpty) {
                                        return Container(
                                          margin: EdgeInsets.only(top: 120),
                                          // color: Colors.green,
                                          child: Center(
                                            child: Text(
                                              "No clips yet",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                height: 1
                                              )
                                            ),
                                          )
                                        );
                                      } else {
                                        return ProfilePostsGrid(
                                          userId: user!.id.toInt(),
                                          id: id,
                                          name: user!.name.split(" ")[0],
                                          queryResult: queryResult,
                                          userPosts: userPosts,
                                          loadingWidget: BlocConsumer<LoadingUserPostsCubit, MoreUserPostsLoadingState>(
                                            listener: (context, state) {
                                              if (state is LoadingMoreUserPostsState) {
                                                loading = true;
                                              } else if (state is MoreUserPostsLoadedState) {
                                                loading = false;
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state is LoadingMoreUserPostsState) {
                                                return Container(
                                                  child: Loader()
                                                );
                                              }
                                                return Container();
                                            }
                                          ),
                                          key: Key('profileGrid_$id!')
                                        );
                                      }
                                    }
                                    return Container();
                                  }
                                )
                                // : Container()
                              )
                            ])
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              );
            },
          )
        ),
      ),
    );
  }

  scrollListener(context) {
    currentScrollControllerPosition = _scrollController.position.pixels;
    // profileRefreshChangeNotifier.changeValue(currentScrollControllerPosition);
    scrollValueNotifier.value = currentScrollControllerPosition;
    // profilePostsHelperCubit.posts(uuid, newPosts, newQueryResult)
    if (userPosts != null && queryResult != null && user != null) {
      double currentPosition = _scrollController.position.pixels;
      double maxPosition = _scrollController.position.maxScrollExtent;
      double threshold = MediaQuery.of(context).size.height * 1.5;
      if ((maxPosition - currentPosition) <= threshold) {
        if (userPosts!.hasMore && loading == false) {
          if (userPosts!.posts.length > 0) {
            loading = true;
            userPostsBloc.add(FetchUserPostsEvent(
              userId: widget.userId,
              id: id,
              limit: 5,
              cursor: userPosts!.posts[userPosts!.posts.length - 1].createdAt,
              isFetchMore: true,
              queryResult: queryResult
            ));
          }
        }
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  void changeCommentCounter(int newCount, int postId) {
    userPostsBloc.add(ChangePostEvent(
      posts: userPosts!,
      queryResult: queryResult!,
      changePostId: postId,
      // changeField: "likeState",
      // changeFieldVal: isLike,
      changeMap: {
        "commentCount": newCount,
      },
      uuid: id,
      missingKey: "userPosts",
      isFetchMore: userPosts!.hasMore,
    ));
  }
}