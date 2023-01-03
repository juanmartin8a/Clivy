import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class RepliesState extends Equatable {
  const RepliesState();

  @override
  List<Object?> get props => [];
}

class RepliesInitState extends RepliesState {}

class RepliesShownState extends RepliesState {
  final Replies$Query$ReplyResponse replyResponse;
  final QueryResult? queryResult;
  final String uuid;
  final bool changed;
  final bool newReply;
  final bool isPre;
  RepliesShownState({
    required this.replyResponse,
    this.queryResult,
    required this.uuid,
    this.changed = false,
    this.newReply = false,
    this.isPre = false
  });

  @override
  List<Object?> get props => [replyResponse, queryResult, uuid, changed, newReply, isPre];
}

// class RepliesHiddenState extends RepliesState {}