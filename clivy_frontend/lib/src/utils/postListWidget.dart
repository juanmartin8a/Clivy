import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/postFeedTile.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostListWidget extends StatefulWidget {
  final dynamic posts;
  final String id;
  final Widget loadingWidget;
  final int? tappedItemId;
  final int? tappedItemIndex;
  final GlobalKey? tappedItemGlobalKey;
  final ScrollController? scrollController;
  final ScrollPhysics scrollPhisics;
  final bool isProfileList;
  final bool isFetchMore;
  final int lastIndex;
  const PostListWidget({
    this.posts,
    required this.id,
    required this.loadingWidget,
    this.tappedItemId,
    this.tappedItemIndex,
    this.tappedItemGlobalKey,
    this.scrollController,
    this.isProfileList = false,
    this.scrollPhisics = const ClampingScrollPhysics(),//const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    required this.isFetchMore, 
    required this.lastIndex,
    required Key key
  }) : super(key: key);

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {

  List itemsList = [];

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (widget.posts != null) {
      itemsList = widget.posts.posts.map((v) => "${widget.id}---${v.id}").toList();
      if (widget.posts != null) {
        itemsList.add("${widget.id}---loading");
      }
    }
    return VisibilityDetector(
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
      child: Container(
        child: widget.posts != null 
        ? InViewNotifierList(
          items: itemsList,
          padding: EdgeInsets.zero,
          // shrinkWrap: true,
          controller: widget.scrollController,
          key: PageStorageKey<String>(widget.id),
          contextCacheCount: 200,
          initialInViewIds: widget.posts.posts.length > 0 ? ["${widget.id}---${widget.posts.posts[0].id}"] : [],
          physics: widget.scrollPhisics,
          itemCount: (widget.posts != null ? widget.posts!.posts.length + 2 : 0),
          builder: (context, index) {
            
            if (index == (widget.posts!.posts.length + 1) - 1) {
              return InViewNotifierWidget(
                id: "${widget.id}---loading",
                key: ValueKey("${widget.id}---loading"),
                builder: (context, inView, child) {
                  return widget.loadingWidget;
                }
              );
            }
            if (index == (widget.posts!.posts.length + 2) - 1) {
              return SizedBox(
                height: 20 + 50
              );
            }
            int realIndex = index;
            var post = widget.posts.posts[realIndex];
            String tileId = "${widget.id}---${post.id}";
            return InViewNotifierWidget(
              id: '$tileId',
              key: ValueKey("$tileId"),
              builder: (context, inView, child) {
                bool isInView = inView;
                if (isVisible == false) {
                  isInView = false;
                }
                return Container(
                  key: widget.tappedItemId == post.id.toInt() ? widget.tappedItemGlobalKey : null,
                  child: PostFeedTile(
                    isListVisible: isVisible, 
                    isFetchMore: widget.isFetchMore,
                    startFromIndex: widget.isFetchMore
                      ? widget.lastIndex
                      : widget.tappedItemIndex!,
                    post: post,
                    id: tileId,
                    isVisible: isInView,
                    index: realIndex,
                    key: ValueKey("$tileId")
                  ),
                );
              }
            );
          },
          isInViewPortCondition:
          (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
              deltaBottom > (0.5 * viewPortDimension);
          },
        ) 
        : Container(),
      ),
    );
  }
}

// class PostListWidget extends StatelessWidget {
//   final dynamic posts;
//   final String id;
//   final Widget loadingWidget;
//   final int? tappedItemId;
//   final int? tappedItemIndex;
//   final GlobalKey? tappedItemGlobalKey;
//   final ScrollController? scrollController;
//   // final ItemScrollController? itemScrollController;// ScrollController? scrollController;
//   // final ItemPositionsListener? itemPositionsListener;
//   // final ItemScrollController ; // ScrollController? scrollController;
//   final ScrollPhysics scrollPhisics;
//   final bool isProfileList;
//   final bool isFetchMore;
//   final int lastIndex;
//   const PostListWidget({
//     this.posts,
//     required this.id,
//     required this.loadingWidget,
//     this.tappedItemId,
//     this.tappedItemIndex,
//     this.tappedItemGlobalKey,
//     this.scrollController,
//     // this.itemScrollController,
//     // this.itemPositionsListener,
//     this.isProfileList = false,
//     this.scrollPhisics = const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//     required this.isFetchMore,
//     required this.lastIndex,
//     required Key key
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Map<String, dynamic> postsMap = {};
//     // make widget stateful
//     // add visibily detector
//     // if not visible setState
//     // change variable isVisible to false
//     // and all isWidgetInView become false
//     // if isVisible again all become true
//     List itemsList = [];
//     if (posts != null) {
//       // postsMap = Map.fromIterable(
//       //   posts.posts,
//       //   key: (v) => "$id---${v.id}",
//       //   value: (v) => v
//       // );
//       itemsList = posts.posts.map((v) => "$id---${v.id}").toList();
//       if (posts != null) {
//         itemsList.add("$id---loading");
//       }
//       // print(postsMap.keys.toList());
//       // print("id: $id");
//       // print("posts posts: ${posts.posts}");
//       // print("postsMap: $postsMap");
//     }
//     // print
//     return Container(
//       child: posts != null 
//       ? InViewNotifierList(
//           items: itemsList,
//           padding: EdgeInsets.zero,
//           controller: scrollController,
//           key: PageStorageKey<String>(id),
//           contextCacheCount: 200,
//           initialInViewIds: posts.posts.length > 0 ? ["$id---${posts.posts[0].id}"] : [],
//           physics: scrollPhisics,
//           itemCount: (posts != null ? posts!.posts.length + 1 : 0),
//           builder: (context, index) {
//             // if (index == 0) {
//             //   return InViewNotifierWidget(
//             //     id: "$id---postList",
//             //     builder: (context, inView, child) {
//             //       return SizedBox(
//             //         height: isProfileList ? 50 + statusBar : 0
//             //       );
//             //     }
//             //   );
//             // }
//             if (index == (posts!.posts.length + 1) - 1) {
//               return InViewNotifierWidget(
//                 id: "$id---loading",
//                 key: ValueKey("$id---loading"),
//                 builder: (context, inView, child) {
//                   return loadingWidget;
//                 }
//               );
//             }
//             int realIndex = index;
//             var post = posts.posts[realIndex];
//             String tileId = "$id---${post.id}";
//             return InViewNotifierWidget(
//               id: '$tileId',
//               key: ValueKey("$tileId"),
//               builder: (context, inView, child) {
//                 // print(index);
//                 // print(inView);
//                 return Container(
//                   key: tappedItemId == post.id.toInt() ? tappedItemGlobalKey : null,
//                   child: PostFeedTile(
//                     isFetchMore: isFetchMore,
//                     startFromIndex: isFetchMore
//                       ? lastIndex
//                       : tappedItemIndex!,
//                     post: post,
//                     id: tileId,
//                     isVisible: inView,
//                     index: realIndex,
//                     key: ValueKey("$tileId")
//                   ),
//                 );
//               }
//             );
//           },
//           isInViewPortCondition:
//           (double deltaTop, double deltaBottom, double viewPortDimension) {
//             // print(deltaTop);
            
//             return deltaTop < (0.5 * viewPortDimension) &&
//               deltaBottom > (0.5 * viewPortDimension);
//           },
//         ) 
//       : Container(),
//     );
//   } 
// }