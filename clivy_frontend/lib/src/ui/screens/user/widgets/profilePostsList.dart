import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserPosts/loadingUserPostsCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserPosts/loadingUserPostsState.dart';
import 'package:untitled_client/src/bloc/profilePostsHelperBloc/profilePostsHelperBloc.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsBloc.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsEvent.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsState.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/utils/customAppBar.dart';
import 'package:untitled_client/src/utils/postListSliver.dart';
import 'package:untitled_client/src/utils/postListWidget.dart';
import 'package:uuid/uuid.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:provider/provider.dart';

class ProfilePostsList extends StatefulWidget {
  final int tappedPostId;
  final int userId;
  final String id;
  final String name;
  final UserPosts$Query$PaginatedPosts userPosts;
  final QueryResult queryResult;
  final Widget loadingWidget;
  final int index;
  const ProfilePostsList({
    required this.tappedPostId,
    required this.userId,
    required this.id,
    required this.name,
    required this.queryResult,
    required this.userPosts,
    required this.loadingWidget,
    required this.index,
    required Key key
  }) : super(key: key);

  @override
  _ProfilePostsListState createState() => _ProfilePostsListState();
}

class _ProfilePostsListState extends State<ProfilePostsList> {

  ScrollController _scrollController = ScrollController();

  // ItemScrollController _itemScrollController = ItemScrollController();
  ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  UserPosts$Query$PaginatedPosts? userPosts;
  QueryResult? queryResult;
  UserPostsBloc? userPostsBloc;

  bool loading = false;

  bool isFetchMore = false;

  bool somethingWasDeleted = false;

  int? prevIndex;

  Map<String, dynamic> maxSizeAndPostsLengthMap = {
    "maxSize": 0,
    "postsLength": 0,
  };

  bool isScrollSizeLoaded = false;

  final globalKey = GlobalKey();

  bool isVisible = true;


  late ProfilePostsHelperCubit profilePostsHelperCubit;

  @override
  void initState() {
    prevIndex = widget.index;
    userPosts = widget.userPosts;
    queryResult = widget.queryResult;
    userPostsBloc = BlocProvider.of<UserPostsBloc>(context);
    profilePostsHelperCubit = BlocProvider.of<ProfilePostsHelperCubit>(context);
    _scrollController.addListener(() {
      scrollListener(context);
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      userPostsBloc!.stream.listen((state) {
        if (state is UserPostsLoadedState) {
          bool isPostsNull = false;
          if (userPosts == null && queryResult == null) {
            isPostsNull = true;
          }
          if (state.id == widget.id) {
            somethingWasDeleted = false;
            if (userPosts != null) {
              if (userPosts!.posts.length > state.userPosts.posts.length) {
                somethingWasDeleted = true;
              }
            }
            queryResult = state.queryResult;
            userPosts = state.userPosts;
            isFetchMore = state.isMore;
          }
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            // maxSizeAndPostsLengthMap["maxSize"] = _scrollController.position.maxScrollExtent;
            maxSizeAndPostsLengthMap["postsLength"] = userPosts!.posts.length - 1;
          });
          if (somethingWasDeleted == true) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
                _scrollController.animateTo(_scrollController.position.pixels + 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
              } else {
                _scrollController.animateTo(_scrollController.position.pixels - 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
              }
            });
          }
          // postsChangeNotifier.refresh(Uuid().v4(), userPosts, queryResult);
          profilePostsHelperCubit.posts(widget.id, userPosts!, queryResult!);
          if (isPostsNull == true) {
            if (mounted) {
              setState(() {});
            }
          }
        }
      });
    });
    _itemPositionsListener.itemPositions.addListener(() {
      if (userPosts != null) {
        // _itemPositionsListener.itemPositions.addListener(() { })
        final visiblePosts = _itemPositionsListener.itemPositions.value.map((item) => item.index);
        final allPosts = userPosts!.posts.asMap().keys.toList();//.map((index, post) {}).toList();
        if (
          visiblePosts.contains(allPosts[(allPosts.length - 1) - 3]) ||
          visiblePosts.contains(allPosts[(allPosts.length - 1) - 2]) ||
          visiblePosts.contains(allPosts[(allPosts.length - 1) - 1]) ||
          visiblePosts.contains(allPosts[(allPosts.length - 1)])
        ) {
          if (userPosts!.hasMore && loading == false) {
            loading = true;
            userPostsBloc!.add(FetchUserPostsEvent(
              userId: widget.userId,
              id: widget.id,
              limit: 5,
              cursor: userPosts!.posts[userPosts!.posts.length - 1].createdAt,
              isFetchMore: true,
              queryResult: queryResult
            ));
          }
        }
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Scrollable.ensureVisible(globalKey.currentContext!);
      // maxSizeAndPostsLengthMap["maxSize"] = _scrollController.position.maxScrollExtent;
      maxSizeAndPostsLengthMap["postsLength"] = userPosts!.posts.length - 1;
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SingleChildScrollView(
            //   child: 
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: statusBar + 45,
                color: Colors.black,
                child: CustomAppBar(
                  statusBar: statusBar,
                  title: "Clips",//"${widget.name} Posts",
                  key: Key('userProfileAppBar_${widget.id}')
                )
              )
            ),
            Expanded(
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
                child: InViewNotifierCustomScrollView(
                  controller: _scrollController,
                  key: PageStorageKey<String>(widget.id),
                  physics: AlwaysScrollableScrollPhysics(),
                  initialInViewIds: userPosts != null && userPosts!.posts.length > 0 ? ["${widget.id}---${userPosts!.posts[0].id}"] : [],
                  contextCacheCount: 200,
                  slivers: [
                    PostListSliver(
                      id: widget.id,
                      isFetchMore: isFetchMore,
                      tappedItemId: widget.tappedPostId,
                      tappedItemIndex: widget.index,
                      tappedItemGlobalKey: globalKey,
                      itemsList: userPosts!.posts.map((v) => "${widget.id}---${v.id}").toList(),
                      posts: userPosts,
                      isVisible: isVisible,
                      lastIndex: prevIndex!,
                      // isFetchMore: true,
                      isProfile: true,
                      // isFollowing: widget.isFollowing,
                      key: Key('${widget.id}'),
                    ),
                    SliverToBoxAdapter(
                      child: InViewNotifierWidget(
                        id: "${widget.id}---loading",
                        key: ValueKey("${widget.id}---loading"),
                        builder: (context, inView, child) {
                          return BlocConsumer<LoadingUserPostsCubit, MoreUserPostsLoadingState>(
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
            )
            // Expanded(
            //   child: BlocConsumer<UserPostsBloc, UserPostsState>(
            //     listener: (context, state) {
            //       if (state is UserPostsLoadedState) {
            //         if (state.id == widget.id) {
            //           somethingWasDeleted = false;
            //           if (userPosts != null) {
            //             if (userPosts!.posts.length > state.userPosts.posts.length) {
            //               somethingWasDeleted = true;
            //             }
            //           }
            //           queryResult = state.queryResult;
            //           userPosts = state.userPosts;
            //           isFetchMore = state.isMore;
            //         }
            //       }
            //     },
            //     builder: (context, state) {
            //       WidgetsBinding.instance!.addPostFrameCallback((_) {
            //         maxSizeAndPostsLengthMap["maxSize"] = _scrollController.position.maxScrollExtent;
            //         maxSizeAndPostsLengthMap["postsLength"] = userPosts!.posts.length - 1;
            //       });
            //       // print(somethingWasDeleted);
            //       if (somethingWasDeleted == true) {
            //         WidgetsBinding.instance!.addPostFrameCallback((_) {
            //           if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
            //             _scrollController.animateTo(_scrollController.position.pixels + 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
            //           } else {
            //             _scrollController.animateTo(_scrollController.position.pixels - 1, duration: Duration(milliseconds: 50), curve: Curves.ease);
            //           }
            //         });
            //       }
            //       return PostListWidget(
            //         lastIndex: prevIndex!,
            //         isFetchMore: isFetchMore,
            //         tappedItemId: widget.tappedPostId,
            //         tappedItemIndex: widget.index,
            //         tappedItemGlobalKey: globalKey,
            //         posts: userPosts,
            //         id: widget.id,
            //         loadingWidget: BlocConsumer<LoadingUserPostsCubit, MoreUserPostsLoadingState>(
            //           listener: (context, state) {
            //             if (state is LoadingMoreUserPostsState) {
            //               loading = true;
            //             } else if (state is MoreUserPostsLoadedState) {
            //               loading = false;
            //             }
            //           },
            //           builder: (context, state) {
            //             if (state is LoadingMoreUserPostsState) {
            //               return Container(
            //                 child: Loader()
            //               );
            //             }
            //             return Container();
            //           }
            //         ),
            //         isProfileList: true,
            //         scrollController: _scrollController,//_itemScrollController,//_scrollController,
            //         key: Key("userPostsList_${widget.id}"),
            //       );
            //     }
            //   ),
            // ),
            // ),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: statusBar + 50,
            //     color: Colors.black,
            //     child: CustomAppBar(
            //       statusBar: statusBar,
            //       title: "Clips",//"${widget.name} Posts",
            //       key: Key('userProfileAppBar_${widget.id}')
            //     )
            //   )
            // ),
          ],
        )
      )
    );
  }

  scrollListener(context) {
    if (userPosts != null && queryResult != null) {
      // postsBloc = BlocProvider.of<PostsBloc>(context);
      if (userPosts!.posts.length > 0) {
        double currentPosition = _scrollController.position.pixels;
        double maxPosition = _scrollController.position.maxScrollExtent;
        double threshold = MediaQuery.of(context).size.height * 1.5;
        if ((maxPosition - currentPosition) <= threshold) {
          if (
            // maxSizeAndPostsLengthMap["maxSize"] == maxPosition && 
            maxSizeAndPostsLengthMap["postsLength"] == userPosts!.posts.length - 1  
            // == false
          ) {
            if (userPosts!.hasMore && loading == false) {
              loading = true;
              prevIndex = userPosts!.posts.length - 1;
              // value range is empty error
              userPostsBloc!.add(FetchUserPostsEvent(
                userId: widget.userId,
                id: widget.id,
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
  }
}