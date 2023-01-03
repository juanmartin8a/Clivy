import 'dart:io' show File, Platform;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/ui/screens/createPost/widgets/editVideo.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/playPauseWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PreviewFile extends StatefulWidget {
  // final String mediaUrl;
  final int fileHeight;
  final int fileWidth;
  final AssetEntity assetEntity;
  PreviewFile({
    // required this.mediaUrl,
    required this.fileHeight,
    required this.fileWidth,
    required this.assetEntity,
  });
  @override
  _PreviewFileState createState() => _PreviewFileState();
}

class _PreviewFileState extends State<PreviewFile> {
  
  VideoPlayerController? _videoController;

  int videoWidth = 0;
  int videoHeight = 0;

  File? prevFile;

  bool isPaused = false;
  bool isDetectorPaused = false;

  String? mediaUrl;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void didUpdateWidget(PreviewFile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_videoController == null || _videoController!.value.isInitialized) {
      initController();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_videoController != null) {
      _videoController!.dispose();
      _videoController = null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              child: AspectRatio(
                aspectRatio: widget.fileWidth / widget.fileHeight,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: widget.fileWidth.toDouble(),//_videoController!.value.size.width,
                                height: widget.fileHeight.toDouble(),//_videoController!.value.size.height,
                                child: Container(
                                  color: Colors.black38,
                                )
                              )
                            )
                          ),
                          _videoController != null && _videoController!.value.isInitialized
                          ? Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: _videoController!.value.size.width,
                                height: _videoController!.value.size.height,
                                child: VisibilityDetector(
                                  child: VideoPlayer(_videoController!),
                                  key: Key('videoVisibilityDetector_uploadPreview'),
                                  onVisibilityChanged: (visibilityInfo) {
                                    double visiblePercentage = visibilityInfo.visibleFraction * 100;
                                    if (_videoController != null && _videoController!.value.isInitialized) {
                                      if (visiblePercentage == 0) {
                                        _videoController!.pause().then((_) {
                                          isDetectorPaused = true;
                                        });
                                      } else if (visiblePercentage > 0) {
                                        if (isDetectorPaused && !isPaused) {
                                          _videoController!.play().then((_) {
                                            isDetectorPaused = false;
                                          });
                                        }
                                      }
                                    }
                                  },
                                )
                              )
                            ),
                          )
                          :
                          Center(
                            child: SizedBox(
                              height: 26,
                              width: 26,
                              child: CircularProgressIndicator(
                                color: Color(0xff00ff03),
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   height: double.infinity,
                          //   child: FittedBox(
                          //     fit: BoxFit.cover,
                          //     alignment: Alignment.center,
                          //     child: SizedBox(
                          //       width: widget.fileWidth.toDouble(),//_videoController!.value.size.width,
                          //       height: widget.fileHeight.toDouble(),//_videoController!.value.size.height,
                          //       child: Container(
                          //         color: Colors.black45,
                          //       )
                          //     )
                          //   )
                          // ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.black.withOpacity(0), Colors.black38]
                                )
                              )
                            )
                          ),
                          GestureDetector(
                            onTap: () {
                              playPause();
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Center(
                                child: PlayPauseWidget(
                                  isPaused: isPaused, 
                                  key: Key("playPauseUploadPreview")
                                )
                              )
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                if (prevFile == null) {
                                  getFilePath(mediaUrl!);
                                }
                                Get.to(
                                  EditVideo(
                                    file: prevFile!,
                                    height: widget.fileHeight,
                                    width: widget.fileWidth,
                                  ),
                                  preventDuplicates: false
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Color(0xff00ff03),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff00ff03).withOpacity(0.5),
                                      spreadRadius: .5,
                                      blurRadius: 6,
                                      offset: Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 30,
                                width: 55,
                                child: Center(
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      height: 1
                                    )
                                  )
                                )
                              )
                            )
                          )
                        ],
                      ),
                    )
                  ),
                ),
              )
            ),
          ),
        ],
      )
    );
  }

  void initController() {
    // assetEntity = widget.
    Future.delayed(Duration(milliseconds: 250), () async {

      mediaUrl = await widget.assetEntity.getMediaUrl();
      _videoController = VideoPlayerController.network(
        mediaUrl!,//widget.mediaUrl
      );
      _videoController!.initialize().then((value) async {
        setState(() {});
      });
      _videoController!.setLooping(true);
      _videoController!.play();
      getFilePath(mediaUrl!);
      videoWidth = _videoController!.value.size.width.toInt();
      videoHeight = _videoController!.value.size.height.toInt();
    });
  }

  void getFilePath(String mediaUrl) {
    if (Platform.isAndroid) {
      prevFile = File(mediaUrl.replaceAll('content://', ''));
    } else if (Platform.isIOS) {
      prevFile = File(mediaUrl.replaceAll('file://', ''));
    }
  }

  void playPause() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      if (_videoController!.value.isPlaying == true) {
        _videoController!.pause().then((_) {
          isPaused = true;
          setState(() {});
        });
      } else {
        _videoController!.play().then((_) {
          isPaused = false;
          setState(() {});
        });
      }
    }
  }
}