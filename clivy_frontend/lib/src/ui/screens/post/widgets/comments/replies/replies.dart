import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyEvent.dart';
import 'package:untitled_client/src/bloc/loading/loadingReplies/loadingRepliesCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingReplies/loadingRepliesState.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/comments/commentData.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/comments/replies/showReplies.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/deleteCommentDialog.dart';

class Replies extends StatefulWidget {
  final String id;
  final int commentId;
  final int postId;
  final AnimationController showHideReplies;
  final Function controllerForward;
  final Function controllerReverseAndReset;
  final Animation<double>? repliesHeightFraction;
  final Animation<double>? repliesOpacity;
  final int replyCount;
  final bool hasMore;
  final Replies$Query$ReplyResponse? replies;
  final QueryResult? queryResult;
  final List addedRepliesIds;
  const Replies({
    required this.id,
    required this.commentId,
    required this.postId,
    required this.showHideReplies,
    required this.controllerForward,
    required this.controllerReverseAndReset,
    this.repliesHeightFraction,
    this.repliesOpacity,
    required this.replyCount,
    required this.hasMore,
    this.replies,
    this.queryResult,
    required this.addedRepliesIds,
    required Key key,
  }) : super(key: key);
  // const Replies({ Key? key }) : super(key: key);

  @override
  _RepliesState createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  bool loading = false;

  late CommentOrReplyBloc commentOrReplyBloc;

  @override
  void initState() {
    commentOrReplyBloc = BlocProvider.of<CommentOrReplyBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.replyCount <= 0) {
      return Container();
    }
    // print(repliesH eightFraction!.value);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topCenter,
          heightFactor: widget.repliesHeightFraction!.value,
          child: AnimatedSize(
            // vsync: this,
            alignment: Alignment.topCenter,
            duration: Duration(milliseconds: 200),
            child: Opacity(
              opacity: widget.repliesOpacity!.value,
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.replies != null) ...widget.replies!.replies.map((reply) {
                      return GestureDetector(
                        onTap: () {
                          commentOrReplyBloc.add(SetReplyEvent(
                            isReplyReply: true,
                            replyCount: widget.replyCount,
                            id: widget.id,
                            userId: reply.userId.toInt(),
                            commentId: widget.commentId,
                            replyUsername: reply.user.username,
                            repliesResponse: widget.replies,
                            queryResult: widget.queryResult,
                          ));
                        },
                        onLongPress: () {
                          Get.generalDialog(
                            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                            barrierColor: Colors.black.withOpacity(0.3),
                            transitionDuration: Duration(milliseconds: 300),
                            pageBuilder: (context, anim1, anim2) {
                              return DeleteDialog(
                                commentId: reply.id.toInt(),
                                isReply: true,
                                key: Key("comment_${reply.id}")
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
                        child: CommentData(
                          data: reply,
                          isReply: true,
                          id: "replyData_${reply.id}",
                          key: Key("replyData_${reply.id}")
                        )
                      );
                    }),
                    Container(
                      child: BlocConsumer<LoadingRepliesCubit, LoadingRepliesState>(
                        listener: (context, loadingState) {
                          if (
                            loadingState is GetRepliesLoadingState &&
                            loadingState.commentId == widget.commentId &&
                            loadingState.uuid == widget.id
                          ) {
                            loading = true;
                          } else if (
                            loadingState is GetRepliesLoadedState &&
                            loadingState.commentId == widget.commentId &&
                            loadingState.uuid == widget.id
                          ) {
                            loading = false;
                          }
                        },
                        builder: (context, loadingState) {
                          if (
                            loadingState is GetRepliesLoadingState &&
                            loadingState.commentId == widget.commentId &&
                            loadingState.uuid == widget.id
                          ) {
                            return Loader(radius: 12);
                          }
                          return Container();
                        }
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ShowReplies(
          addedRepliesIds: widget.addedRepliesIds,
          id: widget.id,
          replies: widget.replies != null ? widget.replies!.replies : [], 
          commentId: widget.commentId,
          postId: widget.postId,
          hasMore: widget.hasMore,
          replyCount: widget.replyCount,
          replyHeightFraction: widget.repliesHeightFraction!.value,
          showHideReplies: widget.showHideReplies,
          queryResult: widget.queryResult,
          controllerForward: widget.controllerForward,
          controllerReverseAndReset: widget.controllerReverseAndReset, 
          key: Key('showCommentReplies_${widget.commentId}')
        )
      ],
    );
  }
}