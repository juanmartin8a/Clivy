import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PostsHelperState extends Equatable {
  const PostsHelperState();

  @override
  List<Object?> get props => [];
}

class PostsHelperInitState extends PostsHelperState {}

class PostsHelperPostsState extends PostsHelperState {
  final String? uuid;
  final dynamic newPosts;
  final QueryResult? newQueryResult;
  final bool newIsFollowing;
  PostsHelperPostsState({
    required this.uuid,
    required this.newPosts,
    required this.newQueryResult,
    required this.newIsFollowing,
  });

  @override
  List<Object?> get props => [uuid, newPosts, newQueryResult, newIsFollowing];
}