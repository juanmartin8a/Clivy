import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class UserFollowState extends Equatable {
  const UserFollowState();

  @override
  List<Object?> get props => [];
}

class UserFollowInitState extends UserFollowState {}

class UserFollowersState extends UserFollowState {
  final UserFollowers$Query$PaginatedFollow paginatedUsers;
  final QueryResult queryResult;
  final String uuid;
  final int userId;
  const UserFollowersState({
    required this.paginatedUsers,
    required this.queryResult,
    required this.uuid,
    required this.userId
  });

  @override
  List<Object?> get props => [paginatedUsers, queryResult, uuid, userId];
}

class UserFollowingState extends UserFollowState {
  final UserFollowing$Query$PaginatedFollow paginatedUsers;
  final QueryResult queryResult;
  final String uuid;
  final int userId;
  const UserFollowingState({
    required this.paginatedUsers,
    required this.queryResult,
    required this.uuid,
    required this.userId
  });

  @override
  List<Object?> get props => [paginatedUsers, queryResult, uuid, userId];
}