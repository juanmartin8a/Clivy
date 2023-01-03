import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/commentLike/commentLikeCubit.dart';
import 'package:untitled_client/src/bloc/commentLike/commentLikeState.dart';
import 'package:untitled_client/src/bloc/comments/commentBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyEvent.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesBloc.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesEvent.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesState.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostCubit.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostState.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/comments/commentData.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/comments/replies/replies.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/deleteCommentDialog.dart';

class Comment extends StatefulWidget {
  final String id;
  final Comments$Query$CommentResponse$Comment comment;
  final Comments$Query$CommentResponse comments;
  final QueryResult commentsQueryResult;
  Comment({
    required this.id,
    required this.comment,
    required this.comments,
    required this.commentsQueryResult,
    required Key key
  }) : super(key: key);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> with SingleTickerProviderStateMixin {
  AnimationController? showHideReplies;
  Animation<double>? repliesHeightFraction;
  Animation<double>? repliesOpacity;

  late RepliesBloc repliesBloc;

  late CommentBloc commentBloc;

  late CommentOrReplyBloc commentOrReplyBloc;

  Replies$Query$ReplyResponse? replies;
  QueryResult? queryResult;
  bool hasMore = true;

  late int replyCount;

  List<int> addedRepliesIds = [];

  @override
  void initState() {
    repliesBloc = BlocProvider.of<RepliesBloc>(context);
    commentBloc = BlocProvider.of<CommentBloc>(context);
    commentOrReplyBloc = BlocProvider.of<CommentOrReplyBloc>(context);
    replyCount = widget.comment.replyCount;
    showHideReplies = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    )..addListener(() {
      setState(() {});
    });
    repliesHeightFraction = Tween<double>(
      begin: 1.0,
      end: 0.0
    ).animate(showHideReplies!);
    repliesOpacity = Tween<double>(
      begin: 1.0,
      end: 0.0
    ).animate(showHideReplies!);
    BlocProvider.of<DeleteCubit>(context).stream.listen((state) {
      if (state is DeleteCommentState) {
        if (state.isReply == true) {
          if (queryResult != null) {
            repliesBloc.add(DeleteReplyEvent(
              replies: replies!,
              queryResult: queryResult!,
              deletedReplyId: state.commentId,
              uuid: widget.id,
              missingKey: "commentReplies", 
              isFetchMore: replies!.hasMore,
            ));
          }
        }
      }
    });
    BlocProvider.of<CommentLikeCubit>(context).stream.listen((state) {
      if (state is LikeReplyState || state is UnlikeReplyState) {
        if (queryResult != null) {
          dynamic likePost;
          List<dynamic> idsRepliesList = replies!.replies.map((post) {
            if (state is LikeReplyState) {
              if (post.id.toInt() == state.replyId) {
                likePost = post;
              }
            } else if (state is UnlikeReplyState) {
              if (post.id.toInt() == state.replyId) {
                likePost = post;
              }
            }
            return post.id.toInt();
          }).toList();

          int? likeCubitReplyId;
          var isLike;

          if (state is LikeReplyState) {
            likeCubitReplyId = state.replyId;
            isLike = true;
          } else if (state is UnlikeReplyState) {
            likeCubitReplyId = state.replyId;
            isLike = false;
          }

          if (idsRepliesList.contains(likeCubitReplyId)) {
            repliesBloc.add(ChangeReplyEvent(
              replies: replies!,
              queryResult: queryResult!,
              changeReplyId: likeCubitReplyId!,
              changeMap: {
                "likeState": isLike,
                "likeCount": isLike ? likePost.likeCount + 1 : likePost.likeCount - 1
              },
              uuid: widget.id,
              missingKey: "commentReplies",
              isFetchMore: replies!.hasMore,
            ));
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    showHideReplies!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CommentOrReplyBloc  = BlocProvider.of<CommentOrReplyBloc>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: () {
                Get.generalDialog(
                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                  barrierColor: Colors.black.withOpacity(0.3),
                  transitionDuration: Duration(milliseconds: 300),
                  pageBuilder: (context, anim1, anim2) {
                    return DeleteDialog(
                      commentId: widget.comment.id.toInt(),
                      isReply: false,
                      key: Key("comment_${widget.comment.id}")
                    );
                  },
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(new CurvedAnimation(
                        parent: anim1,
                        curve: Curves.decelerate
                      )),
                      child: child,
                    );
                  },
                );
              },
              onTap: () {
                if (widget.comment.id.toInt() > 0) {
                  commentOrReplyBloc.add(SetReplyEvent(
                    replyCount: widget.comment.replyCount,
                    id: widget.id,//comment.postId.toInt(),
                    userId: widget.comment.userId.toInt(),
                    commentId: widget.comment.id.toInt(),
                    replyUsername: widget.comment.user.username,
                    repliesResponse: replies,
                    queryResult: queryResult,
                  ));
                }
              },
              child: CommentData(
                data: widget.comment,
                isReply: false,
                isPre: widget.comment.id.toInt() < 0,
                id: "commentData_${widget.comment.id}_${widget.id}",
                key: Key("commentData_${widget.comment.id}_${widget.id}")
              ), 
            ),
            BlocConsumer<RepliesBloc, RepliesState>(
              listener: (context, state) {
                if (state is RepliesShownState) {
                  if (state.replyResponse.commentId == widget.comment.id.toInt()) {
                    if (state.uuid == widget.id) {
                      if (state.changed == true) {
                        if (state.newReply) {
                          if ((replies?.replies.length ?? 0) < state.replyResponse.replies.length) {
                            replyCount = replyCount + 1;
                            addedRepliesIds.add(state.replyResponse.replies[state.replyResponse.replies.length - 1].id.toInt());
                          } else if ((replies?.replies.length ?? 0) > state.replyResponse.replies.length) {
                            replyCount = replyCount - 1;
                            addedRepliesIds.removeLast();
                          } else {
                            addedRepliesIds.removeLast();
                            addedRepliesIds.add(state.replyResponse.replies[state.replyResponse.replies.length - 1].id.toInt());
                          }
                        } else {
                          replyCount = replyCount - 1;
                        }
                      }
                      replies = state.replyResponse;
                      queryResult = state.queryResult;
                      hasMore = state.replyResponse.hasMore;
                    }
                  }
                }
              },
              builder: (context, state) {
                // print(replyCount);
                // print(replies);
                return Replies(
                  addedRepliesIds: addedRepliesIds,
                  id: widget.id,//comment.postId.toInt(),
                  commentId: widget.comment.id.toInt(),
                  postId: widget.comments.postId.toInt(),
                  showHideReplies: showHideReplies!,
                  controllerForward: controllerForward,
                  controllerReverseAndReset: controllerReverseAndReset,
                  repliesHeightFraction: repliesHeightFraction,
                  repliesOpacity: repliesOpacity,
                  replyCount: replyCount,
                  hasMore: hasMore,
                  replies: replies,
                  queryResult: queryResult,
                  key: Key('commentReplies_${widget.comment.id}')
                );
              }
            )
          ],
        )
      )
    );
  }

  void controllerForward() {
    showHideReplies!.forward();
  }

  void controllerReverseAndReset() {
    showHideReplies!.reverse().whenComplete(() {
      showHideReplies!.reset();
    });
  }
}