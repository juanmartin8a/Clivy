import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/comments/commentBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentEvent.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyEvent.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyState.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesBloc.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesEvent.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersCubit.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/search/searchBloc.dart';
import 'package:untitled_client/src/bloc/search/searchEvent.dart';
import 'package:untitled_client/src/bloc/userTagAutocomplete/userTagAutocompleteCubit.dart';
import 'package:untitled_client/src/bloc/userTagAutocomplete/userTagAutocompleteState.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/helpers/profileImg.dart';

class CommentTextField extends StatefulWidget {
  final String id;
  final int postId;
  final Comments$Query$CommentResponse? comments;
  final QueryResult? queryResult;
  const CommentTextField({ 
    required this.id,
    required this.postId,
    this.comments,
    this.queryResult,
    required Key key 
  }) : super(key: key);

  @override
  _CommentTextFieldState createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  RichTextController? _commentController;

  bool isReply = false;

  Replies$Query$ReplyResponse? repliesResponse;
  QueryResult? repliesQueryResult;
  int? commentId;
  int? replyCount;
  int? replyUserId;
  String? replyUsername;
  bool? isReplyReply;

  MeBloc? meBloc;

  CommentsOrUsersCubit? commentsOrUsersCubit;

  Map<RegExp, TextStyle> taggedUsers = {};

  Map<String, String> taggedUsersInfo = {};

  CommentOrReplyBloc? commentOrReplyBloc;

  Map<RegExp, TextStyle> defaultSetting = {
    RegExp(""): TextStyle(
      color: Color(0xff00ff03),
      fontSize: 15,
      fontWeight: FontWeight.w500,
    )
  };

  @override
  void initState() {
    commentOrReplyBloc = BlocProvider.of<CommentOrReplyBloc>(context);
    commentsOrUsersCubit = BlocProvider.of<CommentsOrUsersCubit>(context);
    _commentController = RichTextController(
      patternMap: defaultSetting,
    );
    meBloc = BlocProvider.of<MeBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    if (_commentController != null) {
      _commentController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<CommentOrReplyBloc, CommentOrReplyState>(
        listener: (context, state) {
          if (state is IsCommentState) {
            if (state.id == widget.id) {
              isReply = false;
              // onReplyCommentChange();
            }
          } else if (state is IsReplyState) {
            if (state.id == widget.id) {
              isReply = true;
              repliesResponse = state.repliesResponse;
              repliesQueryResult = state.queryResult;
              commentId = state.commentId;
              replyCount = state.replyCount;
              replyUsername = state.replyUsername;
              replyUserId = state.userId;
              isReplyReply = state.isReplyReply;
              onReplyCommentChange();
            }
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(
              top: state is IsReplyState && state.id == widget.id ? 0 : 8,
              left: 8,
              right: 8,
              bottom: MediaQuery.of(context).padding.bottom > 0
              ? MediaQuery.of(context).padding.bottom : 8
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (
                  state is IsReplyState && 
                  state.id == widget.id
                ) Container(
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Reply to ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: '$replyUsername',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (commentOrReplyBloc != null) {
                            commentOrReplyBloc!.add(
                              SetCommentEvent(id: widget.id)
                            );
                          }
                        },
                        child: Container(
                          child: Center(
                            child: Icon(
                              EvaIcons.closeOutline,
                              size: 22,
                              color: Colors.white,
                            ),
                          )
                        ),
                      )
                    ]
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      // color: Colors.red,
                      child: ProfileImgLoader(
                        file: CurrentUser.user!.file.file!,
                        isMe: CurrentUser.user!.id == CurrentUser.userId,
                        key: Key("commentTextField_${widget.postId}")
                      )
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: Center(
                          child: BlocBuilder<UserTagAutocompleteCubit, UserTagAutocompleteState>(
                            builder: (context, state) {
                              if (state is AutocompleteUserTagState) {
                                if (state.id == widget.id) {
                                  autocompleteUserTag(state.username, state.userId);
                                  BlocProvider.of<UserTagAutocompleteCubit>(context).emit(UserTagAutocompleteDefaultState());
                                }
                              }
                              return TextField(
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.send,
                                controller: _commentController,
                                cursorColor: Color(0xff00ff03),
                                textAlignVertical: TextAlignVertical.center,
                                minLines: 1,
                                maxLines: 4,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25,
                                ),
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical:11.625),
                                  hintText: isReply == true ? 'Add a reply' : 'Add a comment',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onSubmitted: (_) {
                                  if (isReply) {
                                    createReply();
                                  } else {
                                    createComment();
                                  }
                                },
                                onChanged: (value) {
                                  // print(value);
                                  checkIfUserSearch(value);
                                },
                              );
                            },
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isReply) {
                          createReply();
                        } else {
                          createComment();
                        }
                      },
                      child: Container(
                        height: 42,
                        child: Center(
                          child: Icon(
                            EvaIcons.navigation2Outline,
                            color: Color(0xff00ff03),
                            size: 32,
                          ),
                        )
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
      )
    );
  }

  void onReplyCommentChange() {
    if (isReply == true) {
      if (isReplyReply == true) {
        removeTaggedUsers(_commentController!.text, "@${replyUsername!} ", false);
        taggedUsers[RegExp("@${replyUsername!}")] = TextStyle(
          color: Color(0xff00ff03),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        );
        taggedUsersInfo["$replyUserId"] = replyUsername!;
        _commentController!.clear();
        setControllerPattern("@${replyUsername!} ", taggedUsers);
      } else {
        _commentController!.text = "";
        removeTaggedUsers(_commentController!.text, "", true);
      }
    }
  }

  createComment() {
    if (_commentController!.text.length > 0) {
      CommentBloc commentBloc = BlocProvider.of<CommentBloc>(context);
      commentBloc..add(
        CreateCommentEvent(
          postId: widget.postId,
          comment: _commentController!.text,
          userTagInput: taggedUsersInfo,
          commentResponse: widget.comments,
          queryResult: widget.queryResult,
          uuid: widget.id
        )
      );
    }
  }

  createReply() {
    if (_commentController!.text.length > 0) {
      if (commentId != null) {
        print("aaaa");
        RepliesBloc repliesBloc = BlocProvider.of<RepliesBloc>(context);
        repliesBloc..add(
          CreateReplyEvent(
            postId: widget.postId,
            id: widget.id,
            replyCount: replyCount!,
            commentId: commentId!,
            reply: _commentController!.text,
            userTagInput: taggedUsersInfo,
            commentResponse: widget.comments!,
            queryResultComment: widget.queryResult!,
            repliesResponse: repliesResponse,
            queryResult: repliesQueryResult
          )
        );
      }
    }
  }

  void autocompleteUserTag(String username, int id) {
    String newControllerText = "";
    List<String> controllerTextWords = _commentController!.text.split(' ');
    String? wordToBeReplaced;
    for (int i = 0; i < controllerTextWords.length; i++) {
      if (i == (controllerTextWords.length - 1)) {
        wordToBeReplaced = controllerTextWords[i];
      }
    }
    int replaceEndInt = _commentController!.text.length;
    int replaceStartInt = replaceEndInt - wordToBeReplaced!.length;
    newControllerText = _commentController!.text.replaceRange(replaceStartInt, replaceEndInt, "@$username");
    taggedUsers[RegExp("@$username")] = TextStyle(
      color: Color(0xff00ff03),
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    taggedUsersInfo["$id"] = username;
    setControllerPattern(newControllerText + " ", taggedUsers);
    checkIfUserSearch(_commentController!.text);
  }

  void checkIfUserSearch(value) {
    List<String> words = value.split(' ');
    String lastWord = words[words.length - 1];
    if (lastWord.startsWith("@") && value[value.length - 1] != ' ') {
      removeTaggedUsers(value, value, true);
      if (lastWord.length >= 2) { 
        String searchString = lastWord.replaceAll('@', '');
        commentsOrUsersCubit!.setUsers(widget.id);
        BlocProvider.of<SearchBloc>(context).add(
          SearchSubmitEvent(
            search: searchString,
            id: widget.id
          )
        );
      }
    } else {
      commentsOrUsersCubit!.setComments(widget.id);
      removeTaggedUsers(value, value, true);
    }
  }

  void removeTaggedUsers(String value, String newValue, bool setController) {
    for (int i = 0; i < taggedUsersInfo.length; i++) {
      if (value.contains(taggedUsersInfo.values.toList()[i]) == false) {
        if (isReplyReply == true) {
          if (!value.startsWith("@$replyUsername")) {
            commentOrReplyBloc!.add(
              SetCommentEvent(id: widget.id)
            );
          }
        }
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
    _commentController = RichTextController(
      text: text,
      patternMap: {
        ...regStyleMap
      },
    );
    // print(_commentController!.text);
    _commentController!.selection = TextSelection.fromPosition(TextPosition(offset: _commentController!.text.length));
    // print(_commentController!.patternMap);
  }
}