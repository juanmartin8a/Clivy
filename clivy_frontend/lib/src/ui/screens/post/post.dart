import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/commentLike/commentLikeCubit.dart';
import 'package:untitled_client/src/bloc/commentLike/commentLikeState.dart';
import 'package:untitled_client/src/bloc/comments/commentBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentEvent.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyEvent.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentState.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesBloc.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesState.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersCubit.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersState.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostCubit.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostState.dart';
import 'package:untitled_client/src/bloc/loading/loadinComments/loadingCommentsCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadinComments/loadingCommentsState.dart';
import 'package:untitled_client/src/bloc/search/searchBloc.dart';
import 'package:untitled_client/src/bloc/search/searchState.dart';
import 'package:untitled_client/src/bloc/userTagAutocomplete/userTagAutocompleteCubit.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/ui/screens/discover/widgets/searchUserTile.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/comments/commentTextField.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/comments/commentTile.dart';
import 'package:untitled_client/src/utils/posts/postTypes.dart';
import 'package:uuid/uuid.dart';

class Post extends StatefulWidget {
  final dynamic post;//Posts$Query$PaginatedPosts$Post post;
  Post({
    required this.post,
    required Key key
  }) : super(key: key);
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with AutomaticKeepAliveClientMixin {

  ScrollController _scrollController = ScrollController();

  Comments$Query$CommentResponse? comments;
  QueryResult? queryResult;
  bool? hasMore;
  late CommentBloc commentBloc;

  bool loading = false;

  bool isUserTags = false;

  String id = Uuid().v4();

  SearchUsers$Query? searchUsers;

  _scrollListener(BuildContext context) {
    if (comments != null && comments!.comments.isNotEmpty) {
      // commentBloc = BlocProvider.of<CommentBloc>(context);
      double currentPosition = _scrollController.position.pixels;
      double maxPosition = _scrollController.position.maxScrollExtent;
      double threshold = MediaQuery.of(context).size.height * 1.5;
      if ((maxPosition - currentPosition) <= threshold) {
        if (hasMore == true && loading == false) {
          loading = true;
          commentBloc.add(FetchCommentsEvent(
            postId: widget.post.id.toInt(),
            limit: 20,
            isFetchMore: true,
            queryResult: queryResult,
            uuid: id
          ));
        }
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<CommentOrReplyBloc>(context)..add(SetCommentEvent(
      id: id,
    ));
    commentBloc = BlocProvider.of<CommentBloc>(context);
    commentBloc.add(FetchCommentsEvent(
      postId: widget.post.id.toInt(),
      limit: 2,
      isFetchMore: false,
      uuid: id
    ));
    _scrollController.addListener(() {
      _scrollListener(context);
    });
    BlocProvider.of<DeleteCubit>(context).stream.listen((state) {
      if (state is DeleteCommentState) {
        if (state.isReply == false) {
          if (queryResult != null) {
            commentBloc.add(DeleteCommentEvent(
              comments: comments!,
              queryResult: queryResult!,
              deletedCommentId: state.commentId,
              uuid: id,
              missingKey: "comments", 
              isFetchMore: comments!.hasMore,
              postId: widget.post.id.toInt(),
            ));
          }
        }
      }
    });
    BlocProvider.of<CommentLikeCubit>(context).stream.listen((state) {
      if (state is LikeCommentState || state is UnlikeCommentState) {
        if (queryResult != null) {
          dynamic likePost;
          List<dynamic> idsCommentList = comments!.comments.map((post) {
            if (state is LikeCommentState) {
              if (post.id.toInt() == state.commentId) {
                likePost = post;
              }
            } else if (state is UnlikeCommentState) {
              if (post.id.toInt() == state.commentId) {
                likePost = post;
              }
            }
            return post.id.toInt();
          }).toList();

          int? likeCubitCommentId;
          var isLike;

          if (state is LikeCommentState) {
            likeCubitCommentId = state.commentId;
            isLike = true;
          } else if (state is UnlikeCommentState) {
            likeCubitCommentId = state.commentId;
            isLike = false;
          }

          if (idsCommentList.contains(likeCubitCommentId)) {
            commentBloc.add(ChangeCommentEvent(
              comments: comments!,
              queryResult: queryResult!,
              changeCommentId: likeCubitCommentId!,
              changeMap: {
                "likeState": isLike,
                "likeCount": isLike ? likePost.likeCount + 1 : likePost.likeCount - 1
              },
              uuid: id,
              missingKey: "comments",
              isFetchMore: comments!.hasMore,
            ));
          }
        }
      }
    });
    BlocProvider.of<RepliesBloc>(context).stream.listen((state) {
      if (state is RepliesShownState) {
        if (queryResult != null) {
          dynamic commentNewReply;
          List<dynamic> idsCommentList = comments!.comments.map((comment) {
            if (comment.id.toInt() == state.replyResponse.commentId) {
              commentNewReply = comment;
            }
            return comment.id.toInt();
          }).toList();

          if (idsCommentList.contains(state.replyResponse.commentId)) {
            if (!state.isPre) {
              if (state.changed == true) {
                if (state.newReply) {
                  changeReplyCounter(commentNewReply.replyCount + 1, state.replyResponse.commentId);
                } else {
                  changeReplyCounter(commentNewReply.replyCount - 1, state.replyResponse.commentId);
                }
              }
            }
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            // brightness: Brightness.dark,
            leading: GestureDetector(
              onTap: () {
                Get.back(); 
              },
              child: Container(
                child: FloatingActions(
                  icon: EvaIcons.arrowBackOutline,
                  size: 34,
                  padding: EdgeInsets.zero,
                  key: Key("goBack")
                ),
              ),
            ),
            title: Container(
              child: Text(
                'Comments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  // height: 1
                )
              )
            )
          ),
        ), 
        body: FooterLayout(
          footer: KeyboardAttachable(
            child: Container(
              color: Colors.black,
              child: BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  return CommentTextField(
                    id: id,
                    postId: widget.post.id.toInt(),
                    comments: comments,
                    queryResult: queryResult,
                    key: Key("commentTextField_${widget.post.id}")
                  );
                }
              )
            )
          ),
          child: BlocConsumer<CommentsOrUsersCubit, CommentsOrUsersState>(
            listener: (context, state) {
              if (state is SetCommentsState) {
                if (state.id == id) {
                  isUserTags = false;
                }
              } else if (state is SetUsersState) {
                if (state.id == id) {
                  isUserTags = true;
                }
              }
            },
            builder: (context, state) {
              if (isUserTags) {
                return BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoadedState) {
                      if (state.id == id) {
                        if (
                          state.search != null
                        ) {
                          searchUsers = state.search;
                        }
                      }
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          if (
                            state is SearchLoadedState && 
                            state.id == id &&
                            state.search != null
                          ) 
                          ...searchUsers!.searchUsers.map((searchElement) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<UserTagAutocompleteCubit>(context)
                                  .autocompleteUserTag(id, searchElement.id.toInt(), searchElement.username);
                              },
                              child: SearchUserTile(
                                name: searchElement.name,
                                username: searchElement.username,
                                file: searchElement.smallFile.file!,
                                id: searchElement.id.toInt(),
                                key: Key("searchUserTagsTile_${searchElement.id}")
                              ),
                            );
                          })
                        ],
                      )
                    );
                  }
                );
              }
              return Container(
                child: BlocConsumer<CommentBloc, CommentState>(
                  listener: (context, state) {
                    if (state is CommentsLoadedState) {
                      if (state.comments.postId == widget.post.id) {
                        if (state.uuid == id) {
                          comments = state.comments;
                          hasMore = state.comments.hasMore;
                          queryResult = state.queryResult;
                        }
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is !CommentsLoadedState) {
                      return Container();
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        cacheExtent: 50,
                        controller: _scrollController,
                        children: [
                          if (comments != null) ...comments!.comments.map((comment) {
                            return Comment(
                              id: id,
                              comment: comment,
                              comments: comments!,
                              commentsQueryResult: queryResult!,
                              key: Key('${id}comment_${comment.id}')
                            );
                          }).toList(),
                          Container(
                            child: BlocConsumer<LoadingCommentsCubit, LoadingCommentsState>(
                              listener: (context, loadingState) {
                                if (
                                  loadingState is GetCommentsLoadingState &&
                                  loadingState.postId == widget.post.id &&
                                  loadingState.uuid == id
                                ) {
                                  loading = true;
                                } else if (
                                  loadingState is GetCommentsLoadedState &&
                                  loadingState.postId == widget.post.id &&
                                  loadingState.uuid == id
                                ) {
                                  loading = false;
                                }
                              },
                              builder: (context, loadingState) {
                                if (
                                  loadingState is GetCommentsLoadingState &&
                                  loadingState.postId == widget.post.id &&
                                  loadingState.uuid == id
                                ) {
                                  return Loader(radius: 12);
                                }
                                return Container();
                              }
                            )
                          ),
                          SizedBox(
                            height: 100 
                          )
                        ],
                      )
                    );
                  },
                )
              );
            }
          )
        )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void changeReplyCounter(int newCount, int commentId) {
    commentBloc.add(ChangeCommentEvent(
      comments: comments!,
      queryResult: queryResult!,
      changeCommentId: commentId,
      changeMap: {
        "replyCount": newCount
      },
      uuid: id,
      missingKey: "comments",
      isFetchMore: comments!.hasMore,
    ));
  }
}