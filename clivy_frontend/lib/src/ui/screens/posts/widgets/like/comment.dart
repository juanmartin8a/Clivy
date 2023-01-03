import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/comments/commentCounter/commentCounterCubit.dart';
import 'package:untitled_client/src/bloc/comments/commentCounter/commentCounterState.dart';

class CommentWidget extends StatefulWidget {
  final int postId;
  final int commentCount;
  const CommentWidget({ 
    required this.postId,
    required this.commentCount,
    required Key key 
  }) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  int? commentCount;

  void initState() {
    commentCount = widget.commentCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          BlocConsumer<CommentCounterCubit, CommentCounterState>(
            listener: (context, state) {
              if (state is CommentCounterNewCommentState) {
                if (state.postId == widget.postId) {
                  commentCount = commentCount! + 1;
                }
              } else if (state is CommentCounterDeleteCommentState) {
                if (state.postId == widget.postId) {
                  commentCount = commentCount! - state.toDeleteNum;
                }
              }
            },
            builder: (context, state) {
              return Container(
                child: Text(
                  commentCount.toString(),
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    // height: 1,
                  ),
                )
              );
            }
          ),
          Container(
            width: 32,
            height: 32,
            child: Center(
              child: 
              Icon(
                FluentIcons.comment_16_regular,
                color: Colors.grey[200],
                size: 26
              )
              // Icon(
              //   // CupertinoIcons.bubble_left,
              //   // EvaIcons.messageCircleOutline,
                
              //   color: Colors.white,
              //   size: 28
              // ),
            )
          ),
        ]
      )
    );
  }
}