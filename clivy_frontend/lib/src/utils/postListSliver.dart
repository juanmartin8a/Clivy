import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:untitled_client/src/bloc/postsHelperBloc/postsHelperBloc.dart';
import 'package:untitled_client/src/bloc/postsHelperBloc/postsHelperState.dart';
import 'package:untitled_client/src/bloc/profilePostsHelperBloc/profilePostsHelperBloc.dart';
import 'package:untitled_client/src/bloc/profilePostsHelperBloc/profilePostsHelperState.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/postFeedTile.dart';

class PostListSliver extends StatefulWidget {
  final String id;
  final List<dynamic> itemsList;
  final dynamic posts;
  final bool isVisible;
  final int? tappedItemId;
  final int? tappedItemIndex;
  final GlobalKey? tappedItemGlobalKey;
  final bool isFetchMore;
  final int lastIndex;
  final bool? isFollowing;
  final bool isProfile;
  const PostListSliver({ 
    required this.id,
    required this.itemsList,
    required this.posts,
    required this.isVisible,
    this.tappedItemId,
    this.tappedItemIndex,
    this.tappedItemGlobalKey,
    required this.isFetchMore,
    required this.lastIndex,
    this.isFollowing,
    this.isProfile = false,
    required Key key 
  }) : super(key: key);

  @override
  _PostListSliverState createState() => _PostListSliverState();
}

class _PostListSliverState extends State<PostListSliver> {
  dynamic posts;
  List<dynamic> itemsList = [];
  QueryResult? queryResult;
  // PostsBloc? postsBloc;

  late PostsHelperCubit postsHelperCubit;

  late ProfilePostsHelperCubit profilePostsHelperCubit;

  @override
  void initState() {
    if (widget.isProfile) {
      // userPostsChangeNotifier = Provider.of<ProfilePostsChangeNotifier>(context, listen: false);
      profilePostsHelperCubit = BlocProvider.of<ProfilePostsHelperCubit>(context);
    } else {
      // postsChangeNotifier = Provider.of<PostsChangeNotifier>(context, listen: false);
      postsHelperCubit = BlocProvider.of<PostsHelperCubit>(context);

    }
    
    if (!widget.isProfile) {
      // postsChangeNotifier!.addListener(() {
      //   if (widget.isProfile == false) {
      //     if (postsChangeNotifier!.isFollowing && widget.isFollowing!) {
      //       posts = postsChangeNotifier!.posts;
      //       queryResult = postsChangeNotifier!.queryResult;
      //       itemsList = posts.posts.map((v) => "${widget.id}---${v.id}").toList();
      //       if (mounted) {
      //         setState(() {});
      //       }
      //     } else if (!postsChangeNotifier!.isFollowing && !widget.isFollowing!) {
      //       posts = postsChangeNotifier!.posts;
      //       queryResult = postsChangeNotifier!.queryResult;
      //       itemsList = posts.posts.map((v) => "${widget.id}---${v.id}").toList();
      //       if (mounted) {
      //         setState(() {});
      //       }
      //     }
      //   }
      // });
      postsHelperCubit.stream.listen((state) {
        if (state is PostsHelperPostsState) {
          bool canContinue = false;
          if (state.newIsFollowing && widget.isFollowing!) {
            canContinue = true;
          } else if (!state.newIsFollowing && !widget.isFollowing!) {
            canContinue = true;
          }
          if (canContinue == true) {
            posts = state.newPosts;
            queryResult = state.newQueryResult;
            itemsList = posts.posts.map((v) => "${widget.id}---${v.id}").toList();
            if (mounted) {
              setState(() {});
            }
          }
        }
      });
    } else {
      profilePostsHelperCubit.stream.listen((state) {
        if (state is ProfilePostsHelperPostsState) {
          if (widget.isProfile == true) {
            if (widget.id == state.uuid) {
              posts = state.newPosts;
              queryResult = state.newQueryResult;
              itemsList = posts.posts.map((v) => "${widget.id}---${v.id}").toList();
              if (mounted) {
                setState(() {});
              }
            }
          }
        }
      });
      // userPostsChangeNotifier!.addListener(() {
      //   if (widget.isProfile == true) {
      //     posts = userPostsChangeNotifier!.posts;
      //     queryResult = userPostsChangeNotifier!.queryResult;
      //     itemsList = posts.posts.map((v) => "${widget.id}---${v.id}").toList();
      //     if (mounted) {
      //       setState(() {});
      //     }
      //   }
      // });
    }
    posts = widget.posts;
    itemsList = widget.itemsList; 
    super.initState();
  }

  // @override
  // void dispose() {
  //   if (postsChangeNotifier != null) {
  //     postsChangeNotifier!.dispose();
  //   }
  //   if (userPostsChangeNotifier != null) {
  //     userPostsChangeNotifier!.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          String tileId = itemsList[index];
          var post = posts.posts[index];
          return InViewNotifierWidget(
            id: '$tileId',
            key: ValueKey("$tileId"),
            builder: (context, inView, child) {
              bool isInView = inView;
              if (widget.isVisible == false) {
                isInView = false;
              }
              return Container(
                key: widget.tappedItemId == post.id.toInt() ? widget.tappedItemGlobalKey : null,
                child: PostFeedTile(
                  isListVisible: widget.isVisible, 
                  isFetchMore: widget.isFetchMore,
                  startFromIndex: widget.isFetchMore
                    ? widget.lastIndex
                    : widget.tappedItemIndex!,
                  post: post,
                  id: tileId,
                  isVisible: isInView,
                  index: index,
                  key: ValueKey("$tileId")
                ),
              );
            }
          );
        },
        childCount: posts != null ? posts.posts.length : 0,
        findChildIndexCallback: (Key key) {
          final ValueKey valueKey = key as ValueKey;
          final data = valueKey.value;
          final index = itemsList.indexWhere((element) => element == data);

          if (index >= 0 ) return index;
          else return null;
        }
      )
    );
  }
}