import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class CommentOrReplyState extends Equatable {
  const CommentOrReplyState();

  @override
  List<Object?> get props => [];
}

class CommentOrReplyInitState extends CommentOrReplyState {}

class IsCommentState extends CommentOrReplyState {
  final String id;
  IsCommentState({
    required this.id
  });

  @override
  List<Object?> get props => [id];
}

class IsReplyState extends CommentOrReplyState {
  final bool isReplyReply;
  final int replyCount;
  final String id;
  final int userId;
  final int commentId;
  final String replyUsername;
  final Replies$Query$ReplyResponse? repliesResponse;
  final QueryResult? queryResult;
  IsReplyState({
    required this.isReplyReply,
    required this.replyCount,
    required this.id,
    required this.userId,
    required this.commentId,
    required this.replyUsername,
    this.repliesResponse,
    this.queryResult
  });

  @override
  List<Object?> get props => [
    isReplyReply, id, userId, commentId, replyUsername, repliesResponse, queryResult
  ];
}