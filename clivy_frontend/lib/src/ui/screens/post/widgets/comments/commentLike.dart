import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled_client/src/bloc/commentLike/commentLikeCubit.dart';
import 'package:untitled_client/src/bloc/commentLike/commentLikeState.dart';

class CommentLikeWidget extends StatefulWidget {
  final int id;
  final String uuid;
  final bool likeState;
  final int likeCount;
  final bool isReply;
  const CommentLikeWidget({
    required this.id,
    required this.uuid,
    required this.likeState,
    required this.likeCount,
    required this.isReply,
    required Key key,
  }) : super(key: key);
  // const Like({ Key? key }) : super(key: key);

  @override
  _CommentLikeWidgetState createState() => _CommentLikeWidgetState();
}

class _CommentLikeWidgetState extends State<CommentLikeWidget> with SingleTickerProviderStateMixin {
  String? clientId;

  bool? likeState;
  int? likeCount;

  CommentLikeCubit? likeCubit;

  AnimationController? _animController;
  Animation<double>? heartSize;

  bool isLoaded = true;

  @override
  void initState() {
    likeState = widget.likeState;
    likeCount = widget.likeCount;
    _animController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 400)
    )..addListener(() {
      setState(() {});
    });
    heartSize = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 16.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 15.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: 18.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 35.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 18.0, end: 14.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 25.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 14.0, end: 16.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 25.0,
        ),
      ]
    ).animate(_animController!);
    likeCubit = BlocProvider.of<CommentLikeCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isLoaded) {
          if (!widget.isReply) {
            await likeUnlikeComment(context, widget.id);
          } else {
            await likeUnlikeReply(context, widget.id);
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        width: 26,
        height: 40,
        child: BlocConsumer<CommentLikeCubit, CommentLikeState>(
          listener: (context, state) {
            if (state is LikeCommentState && !widget.isReply) {
              if (state.commentId == widget.id) {
                if (state.isPre) {
                  clientId = state.clientId;
                  isLoaded = false;
                  _animController!.forward().whenComplete(() {
                    _animController!.reset();
                    isLoaded = true;
                  });
                  if (state.clientId == clientId) {
                    likeState = true;
                    likeCount = likeCount! + 1;
                  }
                }
              }
            } else if (state is UnlikeCommentState && !widget.isReply) {
              if (state.commentId == widget.id) {
                if (state.isPre) {
                  clientId = state.clientId;
                  isLoaded = false;
                  Future.delayed(Duration(milliseconds: 400), () {
                    isLoaded = true;
                  });
                  if (state.clientId == clientId) {
                    likeState = false;
                    likeCount = likeCount! - 1;
                  }
                }
              }
            } else if (state is LikeReplyState && widget.isReply) {
              if (state.replyId == widget.id) {
                if (state.isPre) {
                  clientId = state.clientId;
                  isLoaded = false;
                  _animController!.forward().whenComplete(() {
                    _animController!.reset();
                    isLoaded = true;
                  });
                  if (state.clientId == clientId) {
                    likeState = true;
                    likeCount = likeCount! + 1;
                  }
                }
              }
            } else if (state is UnlikeReplyState && widget.isReply) {
              if (state.replyId == widget.id) {
                if (state.isPre) {
                  clientId = state.clientId;
                  isLoaded = false;
                  Future.delayed(Duration(milliseconds: 400), () {
                    isLoaded = true;
                  });
                  if (state.clientId == clientId) {
                    likeState = false;
                    likeCount = likeCount! - 1;
                  }
                }
              }
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 150),
                      transitionBuilder: (child, animation) {
                        if (likeState!) {
                          return FaIcon(
                            FontAwesomeIcons.solidHeart,
                            key: ValueKey<String>("comment_like_0${widget.uuid}"),
                            color: Colors.red,
                            size: heartSize!.value
                          );
                        }
                        return AnimatedSwitcher.defaultTransitionBuilder(child, animation);
                      },
                      child: likeState!
                      ? FaIcon(
                        FontAwesomeIcons.solidHeart,
                        key: ValueKey<String>("comment_like_0${widget.uuid}"),
                        color: Colors.red,
                        size: heartSize!.value
                      )
                      : FaIcon(
                        FontAwesomeIcons.heart,
                        key: ValueKey<String>("comment_like_1${widget.uuid}"),
                        color: Colors.grey,
                        size: heartSize!.value
                      ),
                    ),
                  )
                ),
                SizedBox(height: 2),
                Container(
                  child: Text(
                    likeCount.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1
                    ),
                  )
                ),
              ]
            );
          }
        )
      ),
    );
  }

  likeUnlikeComment(BuildContext context, commentId) async {
    likeCubit!.likeUnlikeComment(
      commentId: commentId,
      isLike: likeState! ? true : false
    );
  }

  likeUnlikeReply(BuildContext context, replyId) async {
    likeCubit!.likeUnlikeReply(
      replyId: replyId,
      isLike: likeState! ? true : false
    );
  }
}