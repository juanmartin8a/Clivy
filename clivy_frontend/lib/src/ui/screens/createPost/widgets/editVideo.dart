import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/ui/screens/createPost/widgets/uploadScreen.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/playPauseWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class EditVideo extends StatefulWidget {
  final File file;
  final int height;
  final int width;
  const EditVideo({ 
    required this.file,
    required this.height,
    required this.width,
    Key? key 
  }) : super(key: key);

  @override
  _EditVideoState createState() => _EditVideoState();
}

class _EditVideoState extends State<EditVideo> {
  Trimmer trimmer = Trimmer();
  double startValue = 0.0;
  double endValue = 0.0;

  bool isPaused = false;
  bool isDetectorPaused = false;

  @override
  void initState() {
    trimmer.loadVideo(videoFile: widget.file).whenComplete(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    // if (trimmer.videoPlayerController != null) {
    //   trimmer.videoPlayerController!.dispose();
    //   // trimmer.videoPlayerController = null;
    // }
    trimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                child: FloatingActions(
                  icon: EvaIcons.arrowBackOutline,
                  size: 36,
                  key: Key("goBack")
                ),
              ),
            ),
            title: Container(
              child: Text(
                'Edit Clip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                )
              )
            ),
            backgroundColor: Colors.black,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UploadScreen(
                        file: widget.file,
                        startValue: startValue, 
                        endValue: endValue, 
                        trimmer: trimmer,
                        width: widget.width,
                        height: widget.height,
                      )
                    )
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  // color: Colors.red,
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xff00ff03),
                        fontSize: 14.5,
                        fontWeight: FontWeight.w500
                      )
                    )
                  )
                )
              )
            ]
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Container(
                    // color: Colors.red,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: widget.width / widget.height,
                        child: ClipRRect(
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
                                    width: trimmer.videoPlayerController!.value.size.width,
                                    height: trimmer.videoPlayerController!.value.size.height,
                                    child: VisibilityDetector(
                                      child: VideoPlayer(
                                        trimmer.videoPlayerController!
                                      ),
                                      key: Key("playPauseEditClip"),
                                      onVisibilityChanged: (visibilityInfo) async {
                                        double visiblePercentage = visibilityInfo.visibleFraction * 100;
                                        if (trimmer.videoPlayerController!.value.isInitialized) {
                                          if (visiblePercentage == 0) {
                                            try {
                                              await trimmer.pauseVideo().then((_) {
                                                isDetectorPaused = true;
                                              });
                                            } catch(e) {}
                                          } else if (visiblePercentage > 0) {
                                            if (isDetectorPaused && !isPaused) {
                                              try {
                                                await trimmer.playVideo(
                                                  startValue: startValue, endValue: endValue
                                                ).then((_) {
                                                  isDetectorPaused = false;
                                                });
                                              } catch(e) {}
                                            }
                                          }
                                        }
                                      },
                                    )
                                  )
                                )
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (trimmer.videoPlayerController!.value.isInitialized) {
                                    if (trimmer.videoPlayerController!.value.isPlaying) {
                                      await trimmer.pauseVideo().then((_) {
                                        setState(() {
                                          isPaused = true; 
                                        });
                                      });
                                    } else {
                                      await trimmer.playVideo(startValue: startValue, endValue: endValue).then((_) {
                                        setState(() {
                                          isPaused = false;
                                        });
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: PlayPauseWidget(
                                      isPaused: isPaused,
                                      key: Key("playPauseEditClip")
                                    ),
                                  )
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30 + MediaQuery.of(context).viewInsets.bottom),
                child: Center(
                  child: TrimEditor(
                    trimmer: trimmer,
                    showDuration: true,
                    sideTapSize: 30,
                    scrubberWidth: 4,
                    maxVideoLength: Duration(seconds: 60),
                    durationTextStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                    viewerHeight: 62,
                    viewerWidth: MediaQuery.of(context).size.width * 0.85,
                    fit: BoxFit.cover, 
                    circlePaintColor:  Colors.grey[700]!,
                    borderPaintColor: Colors.grey[850]!,
                    thumbnailQuality: 60,
                    onChangeStart: (value) {
                      startValue = value;
                    },
                    onChangeEnd: (value) {
                      endValue = value;
                    },
                    onChangePlaybackState: (value) async {
                      // print(value);
                      if (value == true && isPaused == true) {
                        if (trimmer.videoPlayerController!.value.isPlaying) {
                          setState(() {
                            isPaused = false;
                          });
                        } else {
                          await trimmer.playVideo(startValue: startValue, endValue: endValue).then((_) {
                            setState(() {
                              isPaused = false;
                            });
                          });
                        }
                      }
                    },
                  )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}