import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/comments/commentCounter/commentCounterCubit.dart';
import 'package:untitled_client/src/bloc/comments/commentEvent.dart';
import 'package:untitled_client/src/bloc/comments/commentState.dart';
import 'package:untitled_client/src/bloc/loading/loadinComments/loadingCommentsCubit.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:untitled_client/src/utils/comments/commentUtils.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final PostRepository postRepo;
  final LoadingCommentsCubit loadingBloc;
  final CommentCounterCubit commentCounterBloc;
  CommentBloc({
    required this.postRepo,
    required this.loadingBloc,
    required this.commentCounterBloc
  }) : super(CommentInitState());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is FetchCommentsEvent) {
      loadingBloc.loader(true, event.postId, event.uuid);
      try {
        List<Comments$Query$CommentResponse$Comment> commentQueryPrevComments = 
          event.queryResult != null ? Comments$Query$CommentResponse.fromJson(
            (event.queryResult!.data as Map<String, dynamic>)["comments"]
          ).comments : [];
        List<int> idsList = commentQueryPrevComments
          .map((p) => p.id.toInt()).toList();
        final comments = await postRepo.postComments(
          event.postId, 
          event.limit, 
          event.isFetchMore,
          event.queryResult,
          idsList
        );
        loadingBloc.loader(false, event.postId, event.uuid);
        yield CommentsLoadedState(
          comments: comments.comments,
          queryResult: comments.queryResult,
          uuid: event.uuid
        );
      } catch (err) {
        loadingBloc.loader(false, event.postId, event.uuid);
        // print('err $err');
      }
    } else if (event is CreateCommentEvent) {
      yield* _mapCreateCommentEventToState(event);
    } else if (event is SetCommentsEvent) {
      yield* _mapSetCommentsEventToState(event);
    } else if (event is DeleteCommentEvent) {
      yield* _mapDeletePostEventToState(event);
    } else if (event is ChangeCommentEvent) {
      yield* _mapChangeCommentEventToState(event);
    }
  }

  Stream<CommentState> _mapCreateCommentEventToState(CreateCommentEvent event) async* {
    try {
      final taggedUsersList = await CommentUtils().getUserTagInputList(event.userTagInput);
      final comment = await CommentUtils().makeCommentResponseFromComment(
        event.postId,
        event.comment,
        event.userTagInput
      );
      final preCommentResponse = await CommentUtils().getUpdatedPostComments(
        event.commentResponse,
        event.postId,
        comment.toJson()
      );
      final newQueryResult = GlobalUtils().generateQueryResult(
        QueryResultSource.network, preCommentResponse.toJson(), 'comments'
      );
      // print(preCommentResponse.toJson());
      yield CommentsLoadedState(
        comments: preCommentResponse,
        queryResult: newQueryResult,
        uuid: event.uuid,
        isNew: true,
        isPre: true,
        changed: true
      );
      commentCounterBloc.commentDeleteComment(
        event.postId, 
        comment.id.toInt(),
        true,
        false,
        null
      );
      // print("tagged list $taggedUsersList");
      final newComment = await postRepo.createComment(event.postId, event.comment, taggedUsersList);
      // print("sapotoro $newComment");
      final commentResponse = await CommentUtils().getUpdatedPostComments(
        event.commentResponse,
        event.postId,
        newComment.comment!.toJson()
      );
      final newQueryResult2 = GlobalUtils().generateQueryResult(
        QueryResultSource.network, commentResponse.toJson(), 'comments'
      );
      yield CommentsLoadedState(
        comments: commentResponse,
        queryResult: newQueryResult2,
        uuid: event.uuid,
        changed: preCommentResponse.comments.length == commentResponse.comments.length ? true : false,
        isNew: true,
      );
      commentCounterBloc.commentDeleteComment(
        event.postId,
        comment.id.toInt(),
        false,
        preCommentResponse.comments.length == commentResponse.comments.length ? false : true,
        null
      );
    } catch(err) {
      print('error creating comment $err');
    }
  }

  Stream<CommentState> _mapSetCommentsEventToState(SetCommentsEvent event) async* {
    yield CommentsLoadedState(
      comments: event.commentResponse,
      queryResult: event.queryResult,
      uuid: event.uuid
    );
  }

  Stream<CommentState> _mapDeletePostEventToState(DeleteCommentEvent event) async* {

    Map<String, dynamic> comments = event.comments.toJson();
    int index = (comments["comments"] as List).indexWhere((comment) => comment["id"].toInt() == event.deletedCommentId);

    int replyCount = comments["comments"][index]["replyCount"];

    final deleteResponse = await CommentUtils().getUpdatedPaginatedCommentsDeleteAction(
      event.comments,
      event.deletedCommentId,
    );
    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, deleteResponse.toJson(), event.missingKey
    );
    if (deleteResponse.comments.length < event.comments.comments.length) {
      commentCounterBloc.commentDeleteComment(
        event.postId,
        event.deletedCommentId,
        false,
        true,
        replyCount > 0 ? replyCount + 1 : null
      );
    }
    yield CommentsLoadedState(
      comments: deleteResponse,
      queryResult: newQueryResult,
      uuid: event.uuid,
      changed: true,
      replyCount: replyCount
    ); 
  }

  Stream<CommentState> _mapChangeCommentEventToState(ChangeCommentEvent event) async* {

    Map<String, dynamic> comments = event.comments.toJson();

    int index = (comments["comments"] as List).indexWhere((post) => post["id"].toInt() == event.changeCommentId);

    for (int i = 0; i < event.changeMap.length; i++) {
      comments['comments'][index][event.changeMap.keys.toList()[i]] = event.changeMap.values.toList()[i];
    }

    final changedComments = Comments$Query$CommentResponse.fromJson(comments);
    
    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, changedComments.toJson(), event.missingKey // changeResponse.toJson()
    );

    yield CommentsLoadedState(
      comments: changedComments,
      queryResult: newQueryResult,
      uuid: event.uuid
    );
  }

}