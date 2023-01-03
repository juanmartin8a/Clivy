import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.graphql.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
  final dynamic posts; //Posts$Query$PaginatedPosts
  final QueryResult queryResult;
  final String? videogameName;
  final int? videogameId;
  final bool isMore;
  final bool isFirstFetch;
  PostsLoadedState({
    required this.posts,
    required this.queryResult,
    this.videogameId,
    this.videogameName,
    this.isFirstFetch = false,
    required this.isMore
  });
  @override
  List<Object?> get props => [posts, queryResult, videogameName, videogameId, isMore, isFirstFetch];
}

class FollowingPostsLoadedState extends PostsState {
  final FollowingPosts$Query$PaginatedPosts posts;
  final QueryResult queryResult;
  final bool isMore;
  final bool isFirstFetch;
  FollowingPostsLoadedState({
    required this.posts,
    required this.queryResult,
    required this.isMore, 
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [posts, queryResult, isMore, isFirstFetch];
}
 
class PostsErrorState extends PostsState {}