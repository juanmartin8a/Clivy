import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class CommentOrReplyEvent extends Equatable {
  const CommentOrReplyEvent();

  @override
  List<Object?> get props => [];
}

class CommentOrReplyInitEvent extends CommentOrReplyEvent {}

class SetCommentEvent extends CommentOrReplyEvent {
  final String id;
  SetCommentEvent({
    required this.id
  });

  @override
  List<Object?> get props => [id];
}

class SetReplyEvent extends CommentOrReplyEvent {
  final bool isReplyReply;
  final int replyCount;
  final String id;
  final int userId;
  final int commentId;
  final String replyUsername;
  final Replies$Query$ReplyResponse? repliesResponse;
  final QueryResult? queryResult;
  SetReplyEvent({
    this.isReplyReply = false,
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
    isReplyReply, replyCount, id, userId, commentId, replyUsername,  repliesResponse, queryResult
  ];
}