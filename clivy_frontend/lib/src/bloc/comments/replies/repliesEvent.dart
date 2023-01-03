import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class RepliesEvent extends Equatable {
  const RepliesEvent();

  @override
  List<Object?> get props => [];
}

class RepliesInitEvent extends RepliesEvent {}

class FetchMoreRepliesEvent extends RepliesEvent {
  final int commentId;
  final int postId;
  final int limit;
  final String? cursor;
  final bool isFetchMore;
  final QueryResult? queryResult;
  final String uuid;
  final List<int> idsList;
  FetchMoreRepliesEvent({
    required this.commentId,
    required this.postId,
    required this.limit,
    required this.isFetchMore,
    this.cursor,
    this.queryResult,
    required this.uuid,
    required this.idsList
  });

  @override
  List<Object?> get props => [commentId, postId, limit, cursor, isFetchMore, queryResult, uuid, idsList];
}

class CreateReplyEvent extends RepliesEvent {
  final int postId;
  final String id;
  final int replyCount;
  final int commentId;
  final String reply;
  final Map<String, dynamic> userTagInput;
  final Comments$Query$CommentResponse commentResponse;
  final QueryResult queryResultComment;
  final Replies$Query$ReplyResponse? repliesResponse;
  final QueryResult? queryResult;
  CreateReplyEvent({
    required this.postId,
    required this.id,
    required this.replyCount,
    required this.commentId,
    required this.reply,
    required this.userTagInput,
    required this.commentResponse,
    required this.queryResultComment,
    this.repliesResponse,
    this.queryResult
  });

  @override
  List<Object?> get props => [
    postId, id, commentId, reply, replyCount, repliesResponse, queryResult, commentResponse, queryResultComment
  ];
}

class DeleteReplyEvent extends RepliesEvent {
  final Replies$Query$ReplyResponse replies;
  final QueryResult queryResult;
  final int deletedReplyId;
  final String uuid;
  final String missingKey;
  final bool isFetchMore;
  DeleteReplyEvent({
    required this.replies,
    required this.queryResult,
    required this.deletedReplyId,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
  });

  @override
  List<Object?> get props => [ uuid, replies, deletedReplyId, queryResult, missingKey, isFetchMore ];
}

class ChangeReplyEvent extends RepliesEvent {
  final Replies$Query$ReplyResponse replies;
  final QueryResult queryResult;
  final int changeReplyId;
  final Map<String, dynamic> changeMap;
  final String uuid;
  final String missingKey;
  final bool isFetchMore;
  ChangeReplyEvent({
    required this.replies,
    required this.queryResult,
    required this.changeReplyId,
    required this.changeMap,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
  });

  @override
  List<Object?> get props => [ uuid, replies, changeReplyId, changeMap, queryResult, missingKey, isFetchMore ];
}