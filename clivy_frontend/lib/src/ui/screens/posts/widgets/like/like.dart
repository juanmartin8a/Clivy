import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/like/likeBloc.dart';
import 'package:untitled_client/src/bloc/like/likeState.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class LikeWidget extends StatefulWidget {
  final String uuid;
  final int postId;
  final bool likeState;
  final int likeCount;
  const LikeWidget({
    required this.uuid,
    required this.postId,
    required this.likeState,
    required this.likeCount,
    required Key key,
  }) : super(key: key);
  // const Like({ Key? key }) : super(key: key);

  @override
  _LikeWidgetState createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> with SingleTickerProviderStateMixin {
  String? clientId;

  bool? likeState;
  int? likeCount;

  late LikeCubit likeCubit;

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
          tween: Tween(begin: 28.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 28.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: 32.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 32.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 32.0, end: 25.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 25.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 25.0, end: 28.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 28.0,
        ),
      ]
    ).animate(_animController!);
    likeCubit = BlocProvider.of<LikeCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      // constraints: BoxConstraints(min),
      child: BlocConsumer<LikeCubit, LikeState>(
        listener: (context, state) {
          switch(state.runtimeType) {
            case LikePostState: 
              if ((state as LikePostState).postId == widget.postId) {
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
              break;
            case UnlikePostState: 
              if ((state as UnlikePostState).postId == widget.postId) {
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
              break;
            // BlocProvider.of(context).
          }
        },
        builder: (context, state) {
          return Container(
            // color: Colors.orange,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.red,
                  width: 50,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      likeCount.toString(),
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13.5, //final 
                        fontWeight: FontWeight.w500,
                        // height: 1,
                      ),
                    ),
                  )
                ),
                GestureDetector(
                  onTap: () async {
                    if (isLoaded) {
                      await likeUnlikePost(widget.postId);
                    }
                  },
                  child: Container(
                    
                    // margin: EdgeInsets.only(right: 8),
                    // color: Colors.yellow,
                    width: 32,
                    height: 32,
                    child: Center(
                      child: AnimatedSwitcher(
                        // key: ValueKey("${widget.uuid}"),
                        duration: Duration(milliseconds:150),
                        transitionBuilder: (child, animation) {
                          if (likeState!) {
                            return Icon(
                              FluentIcons.heart_24_filled,//Icons.favorite_rounded,//CupertinoIcons.heart_fill,
                              // key: ValueKey<String>("clip_like_0${widget.uuid}"),
                              color: Colors.red,
                              size: heartSize!.value
                            );
                          }
                          return AnimatedSwitcher.defaultTransitionBuilder(child, animation);
                        },
                        child: likeState!
                        ? Icon(
                          FluentIcons.heart_24_filled,//Icons.favorite_rounded,//CupertinoIcons.heart_fill,
                          key: ValueKey<String>("clip_like_0${widget.uuid}"),
                          color: Colors.red,
                          size: heartSize!.value
                        )
                        : Icon(
                          FluentIcons.heart_24_regular,//Icons.favorite_rounded,//CupertinoIcons.heart_fill,
                          key: ValueKey<String>("clip_like_1${widget.uuid}"),
                          color: Colors.grey[200],
                          size: heartSize!.value
                        )
                      )
                    )
                  ),
                ),
              ]
            ),
          );
        }
      )
    );
  }

  likeUnlikePost(postId) async {
    // var userId = await UserData().getUserId();
    likeCubit.likeUnlikePost(
      postId: postId,
      isLike: likeState! ? true : false
    );
  }
}