import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/ui/screens/post/post.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/like/comment.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/like/like.dart';

class LikeCommentWidget extends StatefulWidget {
  final String uuid;
  final int postId;
  final bool likeState;
  final int likeCount;
  final int commentCount;
  final dynamic post;
  const LikeCommentWidget({
    required this.uuid,
    required this.post,
    required this.postId,
    required this.likeState,
    required this.likeCount,
    required this.commentCount,
    required Key key,
  }) : super(key: key);

  @override
  _LikeCommentWidgetState createState() => _LikeCommentWidgetState();
}

class _LikeCommentWidgetState extends State<LikeCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      // color: Colors.yellow,
      child: Row(
        children: [
          // LikeWidget(
          //   postId: widget.postId,
          //   likeState: widget.likeState,
          //   likeCount: widget.likeCount,
          //   key: Key('PostLike_${widget.postId}')
          // ),
          GestureDetector(
            onTap: () {
              Get.to(
                Post(
                  post: widget.post, 
                  key: widget.key!
                ),
              );
            },
            child: CommentWidget(
              postId: widget.postId,
              commentCount: widget.commentCount,
              key: Key('PostComment_${widget.postId}'),
            ),
          ),
          SizedBox(width: 8),
          LikeWidget(
            uuid: widget.uuid,
            postId: widget.postId,
            likeState: widget.likeState,
            likeCount: widget.likeCount,
            key: Key('PostLike_${widget.postId}')
          ),
          // CommentWidget(
          //   postId: widget.postId,
          //   commentCount: widget.commentCount,
          //   key: Key('PostComment_${widget.postId}'),
          // ),
        ]
      )
    );
  }
}