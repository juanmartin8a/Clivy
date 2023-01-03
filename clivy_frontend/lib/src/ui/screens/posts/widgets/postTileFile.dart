import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/like/likeBloc.dart';
import 'package:untitled_client/src/bloc/like/likeState.dart';
import 'package:untitled_client/src/client/client.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/playPauseWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostTileFile extends StatefulWidget {
  final String file;
  final int fileWidth;
  final int fileHeight;
  final String id;
  final int postId;
  final bool isVisible;
  final int index;
  final int startFromIndex;
  final bool isFetchMore;
  final bool isListVisible;
  final bool likeState;
  // final visibleI
  PostTileFile({
    required this.file,
    required this.fileWidth,
    required this.fileHeight,
    required this.id,
    required this.postId,
    required this.isVisible,
    required this.index,
    required this.startFromIndex,
    required this.isFetchMore,
    required this.isListVisible,
    required this.likeState,
    required Key key
  }) : super(key: key);
  @override
  _PostTileFileState createState() => _PostTileFileState();
}

class _PostTileFileState extends State<PostTileFile> {
  VideoPlayerController? _videoController;
  bool isInitialized = false;

  bool isPaused = false;

  bool isBufferPaused = false;

  bool isDetectorPaused = false;

  bool? isInitPaused;

  bool viewCounted = false;

  VoidCallback? listener;

  Duration? initBufferTime;

  bool isInit = true;

  late LikeCubit likeCubit;

  String? clientId;
  bool? likeState;

  bool isLoaded = true;

  void initVideoController() async {

    _videoController = VideoPlayerController.network(
      widget.file,
    );
    _videoController!
    ..setLooping(true)
    ..addListener(listener!)
    ..initialize()
    .then((_) {
      
      if (widget.isVisible && isPaused == false) {
        _videoController!.play();
        isInitPaused = false;
      } else {
        stopVideo();
        isInitPaused = true;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  void stopVideo({VoidCallback? thenFunc}) {
    if (_videoController != null) {
      // _videoController!.removeListener(listener!);
      _videoController!.pause().then((_) {
        if (thenFunc != null) {
          thenFunc();
        }
      });
      _videoController!.seekTo(Duration(milliseconds: 0));
      // stop the buffering then
    }
  }

  void playVideo() {
    if (_videoController != null) {
      // _videoController!.addListener(listener!);
      if (isBufferPaused) {
        _videoController!.playBuffering().then((_) {
          isBufferPaused = false;
        });
      }
      if (isInitPaused == true) {
        isInitPaused = false;
      }
      _videoController!.play().then((_) {
        isPaused = false;
      });
    }
  }

  void countView() async {
    // if (widget.postId == 40) {
    //   print("${widget.postId} -- ${_videoController!.value.buffered}");
    //   // print();
    // }
    // print("${widget.id}");
    if (_videoController!.value.buffered.length > 0) {
      if (initBufferTime == null) {
        initBufferTime = _videoController!.value.buffered[0].end;
        // if (widget.index == 2) {
        //   print("$initBufferTime--${widget.id}");
        // }
        // print(widget.postId);
        // print(_videoController!.value.buffered[0].end);
      }
    }
    if (widget.isVisible) {
      isInit = false;
      // if (widget.postId == 40) {
      //   print("${widget.postId} -- ${_videoController!.value.buffered}");
      // }
      // print("${widget.postId} -- ${_videoController!.value.buffered}");
      if (viewCounted == false) {
        if (_videoController!.value.position > Duration(milliseconds: 600)) {
          viewCounted = true;
          try {
            await PostRepository(client: Client.client!).viewClip(widget.postId);
          } catch(e) {}
        }
      } else {
        if (_videoController!.value.position <= Duration(milliseconds: 600)) {
          viewCounted = false;
        }
      }
    } else {
      if (isInit == true) {
        if (isBufferPaused == false) {
          if (_videoController!.value.buffered.length > 0) {
            if (_videoController!.value.buffered[0].end >= Duration(milliseconds: 1500)) {
              if (
                initBufferTime != null &&
                initBufferTime != _videoController!.value.buffered[0].end
              ) {
                isInit = false;
                _videoController!.pauseBuffering().then((_) {
                  isBufferPaused = true;
                });
              }
            }
          }
        }
      }
    }
  }

  void startDelay() {
    // print("${widget.postId} -- ${widget.startFromIndex}");
    // print(widget.startFromIndex);
    int indexDistance = widget.startFromIndex - widget.index;
    indexDistance = indexDistance.abs();
    int startDelayTimeInt = widget.isFetchMore ? indexDistance * 220 : indexDistance * 220;
    // print(startDelayTimeInt);
    startDelayTimeInt = widget.isFetchMore ? startDelayTimeInt - 220 : startDelayTimeInt - 220;
    Duration? startDelayTime = indexDistance == 0 ? null : Duration(
      milliseconds: widget.isFetchMore ? startDelayTimeInt : 440 + startDelayTimeInt
    );
    // print(startDelayTime);
    if (startDelayTime != null) {
      Future.delayed(startDelayTime, () {
        if (mounted) {
          // print("aaaa");
          initVideoController();
        }
      });
    } else {
      if (mounted) {
        initVideoController();
      }
    }
  }

  @override
  void initState() {
    likeState = widget.likeState;
    listener = () {
      // if (widget.index == 2) {
      //   print("${_videoController!.value.buffered}     ${_videoController!.value.position}--${widget.id}");
      // }
      // print("${_videoContsroller!.value.buffered}--${widget.id}");
      if (mounted) {
        setState(() {});
        countView();
      }
    };
    startDelay();
    likeCubit = BlocProvider.of<LikeCubit>(context);
    likeCubit.stream.listen((state) {
      switch(state.runtimeType) {
        case LikePostState:
        
          if ((state as LikePostState).postId == widget.postId) {
            if (state.isPre) {
              clientId = state.clientId;
              isLoaded = false;
              // _animController!.forward().whenComplete(() {
              //   _animController!.reset();
              Future.delayed(Duration(milliseconds: 400), () {
                isLoaded = true;
              });
              clientId = state.clientId;
              if (state.clientId == clientId) {
                likeState = true;
              }
            }
          }
          break;
        case UnlikePostState: 
          if ((state as UnlikePostState).postId == widget.postId) {
            if (state.isPre) {
              isLoaded = false;
              Future.delayed(Duration(milliseconds: 400), () {
                isLoaded = true;
              });
              clientId = state.clientId;
              if (state.clientId == clientId) {
                likeState = false;
              }
            }
          }
          break;
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(PostTileFile oldWidget) {
    // WidgetsBinding.instance!.addPostFrameCallback((_) {

      if (!widget.isVisible) {
        if (widget.isListVisible) {
          isPaused = false;
        }
        isDetectorPaused = false;
      }
      if (_videoController != null) {
        if (widget.isVisible && isPaused == false) { //&& isDetectorPaused == false) {
          // print(widget.postId);
          // print("toro");
          playVideo();
        } else {
          // print(widget.postId);
          // print("sapo");
          // dont pause if widget is still visible
          // print(widget.isVisible);
          if (!widget.isVisible) {
            stopVideo(thenFunc: () {
              if (isInit == false) {
                if (isBufferPaused != true) {
                  _videoController!.pauseBuffering().then((_) {
                    isBufferPaused = true;
                  });
                }
              }
            });
          }
        }
      } else {
        if (isInitPaused != null) {
          initVideoController();
        }
      }
    // });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _videoController = null;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.fileWidth / widget.fileHeight,
      child: Container(
        child: _videoController != null && _videoController!.value.isInitialized
        ? 
        Stack(
          children: [
            Builder(
              builder: (context) {
                return FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  // color: Colors.red,
                  child: SizedBox(
                    width: widget.fileWidth.toDouble(),
                    height: widget.fileHeight.toDouble(),
                    child: VisibilityDetector(
                      child: VideoPlayer(_videoController!),
                      key: Key('videoVisibilityDetector_${widget.id}'),
                      onVisibilityChanged: (visibilityInfo) {
                        double visiblePercentage = visibilityInfo.visibleFraction * 100;
                        if (_videoController != null) {
                          if (visiblePercentage == 0) {
                            if (widget.isVisible) {
                              _videoController!.pause().then((_) {
                                isDetectorPaused = true;
                              });
                              _videoController!.pauseBuffering().then((_) {
                                isBufferPaused = true;
                              });
                              // _videoController!.seekTo(Duration(milliseconds: 0));
                            }
                          } else if (visiblePercentage > 0) {
                            if (widget.isVisible) {
                              if (isDetectorPaused && !isPaused) {
                                _videoController!.play().then((_) {
                                  isDetectorPaused = false;
                                });
                                _videoController!.playBuffering().then((_) {
                                  isBufferPaused = false;
                                });
                              }
                            }
                          }
                        }
                      },
                    )
                  )
                );
              }
            ),
            GestureDetector(
              onTap: () {
                if (widget.isVisible) {
                  // _videoController?.playBuffering();
                  print(_videoController!.value.isPlaying);
                  if (_videoController!.value.isPlaying == true) {
                    _videoController!.pause().then((_) {
                      isPaused = true;
                      setState(() {});
                    });
                    
                  } else {
                    // if (isBufferPaused) {
                    //   _videoController!.playBuffering().then((_) {
                    //     isBufferPaused = false;
                    //   });
                    // }
                    // _videoController!.play().then((_) {
                    //   isPaused = false;
                    //   setState(() {});
                    // });
                    playVideo();
                    setState(() {});
                  }
                }
              },
              onDoubleTap: () async {
                if (isLoaded) {
                  await likeUnlikePost(widget.postId);
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: PlayPauseWidget(
                    isPaused: isPaused, 
                    key: Key("playPause_${widget.id}")
                  )
                )
              )
            )
          ],
        ) 
        // Container(
        //   color: Colors.black,
        //   child: Center(
        //     child: Container(
        //       height: 25,
        //       width: 25,
        //       child: CircularProgressIndicator(
        //         color: Color(0xff00ff03),
        //         strokeWidth: 2.5,
        //       ),
        //     ),
        //   )
        // )
        : 
        Container(
          color: Colors.black,
          child: Center(
            child: Container(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Color(0xff00ff03), // Colors.grey[700],
                strokeWidth: 2.5,
              ),
            ),
          )
        )
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