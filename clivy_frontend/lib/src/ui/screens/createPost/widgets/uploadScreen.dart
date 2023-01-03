import 'dart:io';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersCubit.dart';
import 'package:untitled_client/src/bloc/flushBars/flushBarsCubit.dart';
import 'package:untitled_client/src/bloc/search/searchBloc.dart';
import 'package:untitled_client/src/bloc/search/searchEvent.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesCubit.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesState.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostBloc.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostEvent.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostState.dart';
import 'package:untitled_client/src/bloc/userTagAutocomplete/userTagAutocompleteCubit.dart';
import 'package:untitled_client/src/bloc/userTagAutocomplete/userTagAutocompleteState.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/ui/screens/createPost/widgets/uploadScreenSettings.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:untitled_client/src/ui/wrapper.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:video_trimmer/video_trimmer.dart';

class UploadScreen extends StatefulWidget {
  final File file;
  final double startValue;
  final double endValue;
  final Trimmer? trimmer;
  final int width;
  final int height;
  UploadScreen({
    required this.file,
    required this.startValue,
    required this.endValue,
    this.trimmer,
    required this.width,
    required this.height,
  });

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late RichTextController _captionController;

  Uint8List? thumbnailByteData;

  String id = Uuid().v4();

  Map<RegExp, TextStyle> taggedUsers = {};

  Map<String, String> taggedUsersInfo = {};

  Map<RegExp, TextStyle> defaultSetting = {
    RegExp(""): TextStyle(
      color: Color(0xff00ff03),
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.25
    )
  };

  late CommentsOrUsersCubit commentsOrUsersCubit;

  late UploadPostBloc uploadPostBloc;

  Future? thumbnailByteDataFuture;

  int? videogameId;
  List<int> videogameGenres = [];

  @override
  void initState() {
    // print(videogameId);
    uploadPostBloc = BlocProvider.of<UploadPostBloc>(context);
    commentsOrUsersCubit = BlocProvider.of<CommentsOrUsersCubit>(context);
    _captionController = RichTextController(
      patternMap: defaultSetting,
    );
    BlocProvider.of<SelectVideogamesCubit>(context).stream.listen((state) {
      if (state is VideogameSelectedState) {
        videogameId = state.id;
        videogameGenres = state.genreList;
      } else if (state is RemoveSelectedVideogameState) {
        videogameId = null;
        videogameGenres = [];
      } else if (state is GenreSelectedState) {
        videogameId = null;
        videogameGenres = state.genreList;
      } else if (state is RemoveSelectedGenreState) {
        videogameId = null;
        videogameGenres = state.genreList;
      }
      // print("videogame id is: $videogameId");
      // print("videogame genres are: $videogameGenres");
    });

    thumbnailByteDataFuture = loadThumbnail();
    super.initState();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            leading: GestureDetector(
              onTap: () {
                BlocProvider.of<SelectVideogamesCubit>(context).emit(SelectVideogameInitState());
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
                'Upload Clip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                )
              )
            ),
          ),
        ),
        body: FooterLayout(
          footer: KeyboardAttachable(
            // backgroundColor: Colors.black,
            // child: Container(
            //   // color: Colors.black,
            //   margin: EdgeInsets.only(bottom: 20),
            //   child: GestureDetector(
            //     onTap: () {
            //       uploadPost();
            //     },
            //     child: Container(
            //       width: MediaQuery.of(context).size.width * 0.5,
            //       height: 45,
            //       decoration: BoxDecoration(
            //         color: Colors.black,
            //         borderRadius: BorderRadius.circular(30),
            //         border: Border.all(
            //           color: Color(0xff00ff03),
            //           width: 2
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Color(0xff00ff03).withOpacity(0.5),
            //             spreadRadius: 2,
            //             blurRadius: 8,
            //             offset: Offset(0, 0), // changes position of shadow
            //           ),
            //         ],
            //       ),
            //       child: Center(
            //         child: Text(
            //           'Post',
            //           style: TextStyle(
            //             color: Color(0xff00ff03),
            //             fontSize: 17,
            //             fontWeight: FontWeight.w600
            //           )
            //         )
            //       )
            //     )
            //   ),
            // )
          ),
          child: Stack(
            children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.red,
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: widget.width / widget.height,
                                child: FutureBuilder(
                                  future: thumbnailByteDataFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(
                                              thumbnailByteData!,
                                            ),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ); //: Container();
                                    }
                                    return Container();
                                  }
                                )
                              ),
                            )
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 8),
                              child: BlocBuilder<UserTagAutocompleteCubit, UserTagAutocompleteState>(
                                builder: (context, state) {
                                  if (state is AutocompleteUserTagState) {
                                    if (state.id == id) {
                                      autocompleteUserTag(state.username, state.userId);
                                      BlocProvider.of<UserTagAutocompleteCubit>(context).emit(UserTagAutocompleteDefaultState());
                                    }
                                  }
                                  return TextField(
                                    textInputAction: TextInputAction.done,
                                    // focusNode: _focusNode,
                                    controller: _captionController,
                                    cursorColor: Color(0xff00ff03),
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardAppearance: Brightness.dark,
                                    minLines: 4,
                                    maxLines: 4,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 1.25
                                    ),
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      // contentPadding: EdgeInsets.only(right: 8, top: 9, bottom: 9),
                                      hintText: 'Add a caption',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      checkIfUserSearch(value);
                                    },
                                  );
                                }
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 1.5,
                      color: Colors.grey[700]
                    ),
                    Expanded(
                      child: UploadScreenSettings(
                        id: id,
                      ),
                    )
                  ],
                )
              ),
              Positioned(
                bottom: 20,
                right: MediaQuery.of(context).size.width * 0.25,
                child: Container(
                  // color: Colors.black,
                  // margin: EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      uploadPost();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color(0xff00ff03),
                          width: 2
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff00ff03).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: BlocBuilder<UploadPostBloc, UploadPostState>(
                          builder: (context, state) {
                            if (state is UploadPostUploadingState) {
                              return Loader();
                            }
                            return Text(
                              'Post',
                              style: TextStyle(
                                color: Color(0xff00ff03),
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                              )
                            );
                          }
                        )
                      )
                    )
                  ),
                )
              )
            ],
          ),
        )
      ),
    );
  }

  void uploadPost() async {
    if (videogameGenres.length > 0) {
      // print("hola");
      // Get.offAll(Wrapper());
      uploadPostBloc.add(UploadPostSubmitEvent(
        caption: _captionController.text,
        file: widget.file,
        fileHeight: widget.height,
        fileWidth: widget.width,
        startValue: widget.startValue,
        endValue: widget.endValue,
        userTagInput: taggedUsersInfo,
        videogameId: videogameId,
        genreList: videogameGenres,
      ));
      Flushbar(
        backgroundColor: Color(0xFF303030).withOpacity(0.98),
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        borderRadius: BorderRadius.circular(12),
        flushbarPosition: FlushbarPosition.TOP,
        messageText: Container(
          child: Row(
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff00ff03),
                  border: Border.all(
                    width: 2, 
                    color: Color(0xff00ff03) 
                  )
                ),
                child: Center(
                  child: Icon(
                    EvaIcons.checkmarkOutline,
                    color: Colors.black,
                    size: 20
                  )
                )
              ),
              SizedBox(
                width: 12
              ),
              Container(
                child: Text(
                  "Clip has been posted",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  )
                )
              )
            ]
          )
        ),
        duration: Duration(seconds: 7),
      )..show(context);
    }
  }

  Future<Uint8List> loadThumbnail() async {
    thumbnailByteData = await VideoThumbnail.thumbnailData(
      video: widget.file.path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 300,
      timeMs: widget.startValue.toInt(),
      quality: 60,
    );
    return thumbnailByteData!;
  }

  void autocompleteUserTag(String username, int id) {
    String newControllerText = "";
    List<String> controllerTextWords = _captionController.text.split(' ');
    String? wordToBeReplaced;
    for (int i = 0; i < controllerTextWords.length; i++) {
      if (i == (controllerTextWords.length - 1)) {
        wordToBeReplaced = controllerTextWords[i];
      }
    }
    int replaceEndInt = _captionController.text.length;
    int replaceStartInt = replaceEndInt - wordToBeReplaced!.length;
    newControllerText = _captionController.text.replaceRange(replaceStartInt, replaceEndInt, "@$username");
    taggedUsers[RegExp("@$username")] = TextStyle(
      color: Color(0xff00ff03),
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.25
    );
    taggedUsersInfo["$id"] = username;
    setControllerPattern(newControllerText + " ", taggedUsers);
    checkIfUserSearch(_captionController.text);
  }

  void checkIfUserSearch(value) {
    List<String> words = value.split(' ');
    String lastWord = words[words.length - 1];
    if (lastWord.startsWith("@") && value[value.length - 1] != ' ') {
      removeTaggedUsers(value, value, true);
      if (lastWord.length >= 2) { 
        String searchString = lastWord.replaceAll('@', '');
        commentsOrUsersCubit.setUsers(id);
        BlocProvider.of<SearchBloc>(context).add(
          SearchSubmitEvent(
            search: searchString,
            id: id
          )
        );
      }
    } else {
      commentsOrUsersCubit.setComments(id);
      removeTaggedUsers(value, value, true);
    }
  }

  void removeTaggedUsers(String value, String newValue, bool setController) {
    for (int i = 0; i < taggedUsersInfo.length; i++) {
      if (value.contains(taggedUsersInfo.values.toList()[i]) == false) {
        taggedUsers.removeWhere((key, keyValue) => key.pattern.replaceFirst("@", "") == taggedUsersInfo.values.toList()[i]);
        taggedUsersInfo.removeWhere((key, keyValue) => keyValue == taggedUsersInfo.values.toList()[i]);
        if (setController == true) {
          setControllerPattern(newValue, defaultSetting);
          BlocProvider.of<UserTagAutocompleteCubit>(context).emit(UserTagAutocompleteInitState());
        }
      }
    }
  }

  void setControllerPattern(String text, Map<RegExp, TextStyle> regStyleMap) {
    _captionController = RichTextController(
      text: text,
      patternMap: {
        ...regStyleMap
      },
    );
    _captionController.selection = TextSelection.fromPosition(TextPosition(offset: _captionController.text.length));
  }
}