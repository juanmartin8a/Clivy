import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
// import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [throw UnimplementedError()];
}

class CommentInitEvent extends CommentEvent {}

class FetchCommentsEvent extends CommentEvent {
  final int postId;
  final int limit;
  final bool isFetchMore;
  final QueryResult? queryResult;
  final String uuid;
  FetchCommentsEvent({
    required this.postId,
    required this.limit,
    // this.cursor,
    required this.isFetchMore,
    this.queryResult,
    required this.uuid
  });

  @override
  List<Object?> get props => [postId, limit, isFetchMore, queryResult, uuid];
}

class CreateCommentEvent extends CommentEvent {
  final int postId;
  final String comment;
  final Map<String, dynamic> userTagInput;
  final Comments$Query$CommentResponse? commentResponse;
  final QueryResult? queryResult;
  final String uuid;
  CreateCommentEvent({
    required this.postId,
    required this.comment,
    required this.userTagInput,
    this.commentResponse,
    this.queryResult,
    required this.uuid
  });

  @override
  List<Object?> get props => [postId, comment, userTagInput, commentResponse, queryResult, uuid];
}

class SetCommentsEvent extends CommentEvent {
  final Comments$Query$CommentResponse commentResponse;
  final QueryResult queryResult;
  final String uuid;
  SetCommentsEvent({
    required this.commentResponse,
    required this.queryResult,
    required this.uuid
  });

  @override
  List<Object?> get props => [commentResponse, queryResult, uuid];
}

class DeleteCommentEvent extends CommentEvent {
  final Comments$Query$CommentResponse comments;
  final QueryResult queryResult;
  final int deletedCommentId;
  final String uuid;
  final String missingKey;
  final bool isFetchMore;
  final int postId;
  DeleteCommentEvent({
    required this.comments,
    required this.queryResult,
    required this.deletedCommentId,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
    required this.postId
  });

  @override
  List<Object?> get props => [ uuid, comments, deletedCommentId, queryResult, missingKey, isFetchMore, postId ];
}

class ChangeCommentEvent extends CommentEvent {
  final Comments$Query$CommentResponse comments;
  final QueryResult queryResult;
  final int changeCommentId;
  final Map<String, dynamic> changeMap;
  final String uuid;
  final String missingKey;
  final bool isFetchMore;
  ChangeCommentEvent({
    required this.comments,
    required this.queryResult,
    required this.changeCommentId,
    required this.changeMap,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
  });

  @override
  List<Object?> get props => [ uuid, comments, changeCommentId, changeMap, queryResult, missingKey, isFetchMore ];
}