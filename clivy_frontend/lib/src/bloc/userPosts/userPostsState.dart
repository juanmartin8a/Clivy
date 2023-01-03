import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.graphql.dart';

abstract class UserPostsState extends Equatable {
  const UserPostsState();

  @override
  List<Object?> get props => [];
}

class UserPostsInitState extends UserPostsState {}

class UserPostsLoadedState extends UserPostsState {
  // final int userId;
  final String id;
  final UserPosts$Query$PaginatedPosts userPosts;
  final QueryResult? queryResult;
  final bool isMore;
  UserPostsLoadedState({
    required this.id,
    required this.userPosts,
    this.queryResult,
    required this.isMore,
  });
  @override
  List<Object?> get props => [id, userPosts, queryResult, isMore];
}

class UserPostsErrorState extends UserPostsState {}