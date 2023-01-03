import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];

}

class CommentInitState extends CommentState {}

class CommentsLoadedState extends CommentState {
  final Comments$Query$CommentResponse comments;
  final QueryResult? queryResult;
  final String uuid;
  final bool isNew;
  final bool isPre;
  final bool changed;
  final int? replyCount;
  CommentsLoadedState({
    required this.comments,
    this.queryResult,
    required this.uuid,
    this.isNew = false,
    this.isPre = false,
    this.changed = false,
    this.replyCount,
  });

  @override
  List<Object?> get props => [comments, queryResult, uuid, isNew, isPre, changed, replyCount];
}

class CommetsErrorState extends CommentState {}