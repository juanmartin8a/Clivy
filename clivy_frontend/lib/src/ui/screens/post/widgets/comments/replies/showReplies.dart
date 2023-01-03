import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesBloc.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesEvent.dart';

class ShowReplies extends StatelessWidget {
  final String id;
  final List<Replies$Query$ReplyResponse$Reply> replies;
  final int commentId;
  final int postId;
  final bool hasMore;
  final int replyCount;
  final double replyHeightFraction;
  final AnimationController showHideReplies;
  final QueryResult? queryResult;
  final Function controllerForward;
  final Function controllerReverseAndReset;
  final List addedRepliesIds;
  ShowReplies({
    required this.id,
    required this.replies,
    required this.commentId,
    required this.postId,
    required this.hasMore,
    required this.replyCount,
    required this.replyHeightFraction,
    required this.showHideReplies,
    this.queryResult,
    required this.controllerForward,
    required this.controllerReverseAndReset,
    required this.addedRepliesIds,
    required Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RepliesBloc repliesBloc = BlocProvider.of<RepliesBloc>(context);
    int repliesLeft = replyHeightFraction != 0 ? replyCount - replies.length : replyCount;
    // print("$replyCount -- ${replies.length}");
    // print("sapotoro $repliesLeft -- $replyHeightFraction");
    String? repliesLastItem;
    // List repliesIds = replies.map((v) => v.id.toInt()).toList();
    if (replies.length > 0) {
      if (addedRepliesIds.contains(replies[replies.length - 1].id)) {
        // take the last item in the list where
        List reversedReplies = List.from(replies.reversed);
        for (int i = 0; i < reversedReplies.length; i++) {
          if (addedRepliesIds.contains(reversedReplies[i].id) == false) {
            repliesLastItem = reversedReplies[i].createdAt;
            break;
          }
        }
      } else {
        repliesLastItem = replies[replies.length - 1].createdAt;
      }
    }
    // print("eeeeeeee");
    // print(hasMore);
    // print(replyHeightFraction);
    // print(showHideReplies.isCompleted);
    return Container(
      margin: EdgeInsets.only(left: 48, top: 12),
      // color: Colors.red,
      child: Row(
        children: [
          if (hasMore || replyHeightFraction == 0) GestureDetector( //(hasMore && replyHeightFraction >= 0) showHideReplies.isCompleted
            onTap: () {
              if (showHideReplies.isCompleted) {
                controllerReverseAndReset();
              }
              if (
                !showHideReplies.isAnimating &&
                hasMore == true
              ) {
                repliesBloc.add(
                  FetchMoreRepliesEvent(
                    uuid: id,
                    commentId: commentId,
                    postId: postId,
                    limit: 2,
                    cursor: repliesLastItem,
                    isFetchMore: replies.length > 0 ? true : false,//&& repliesLastItem != null
                    queryResult: queryResult,
                    idsList: replies.map((v) => v.id.toInt()).toList()
                  )
                );
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Text(
                    'Show $repliesLeft replies',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1
                    ),
                  ),
                  Icon(
                    EvaIcons.arrowIosDownwardOutline,
                    color: Colors.grey,
                    size: 20
                  )
                ],
              )
            ),
          ),
          if (hasMore && replyHeightFraction >= 0) //((hasMore || replyHeightFraction < 1.0) && replyHeightFraction >= 0)
          Spacer(),
          if (replies.length > 0 && replyHeightFraction > 0) GestureDetector(
            onTap: () {
              if (
                replies.length > 0 &&
                replyHeightFraction == 1.0 &&
                !showHideReplies.isAnimating
              ) {
                controllerForward();
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 4),
              color: Colors.transparent,
              child: Row(
                children: [
                  Text(
                    'Hide',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1
                    ),
                  ),
                  Icon(
                    EvaIcons.arrowIosUpwardOutline,
                    color: Colors.grey,
                    size: 20
                  )
                ],
              )
            ),
          )
        ],
      )
    );
  }
}