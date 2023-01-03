import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class UserPostsEvent extends Equatable {
  const UserPostsEvent();

  @override
  List<Object?> get props => [];
}

class UserPostsInitEvent extends UserPostsEvent {}

class FetchUserPostsEvent extends UserPostsEvent {
  final int userId;
  final String id;
  final int limit;
  final String? cursor;
  final bool isFetchMore;
  final QueryResult? queryResult;
  FetchUserPostsEvent({
    required this.userId,
    required this.id,
    required this.limit,
    this.cursor,
    required this.isFetchMore,
    this.queryResult
  });

  @override
  List<Object?> get props => [userId, id, limit, cursor, isFetchMore, queryResult];
}

class DeletePostEvent extends UserPostsEvent {
  final UserPosts$Query$PaginatedPosts posts;
  final QueryResult queryResult;
  final int deletedPostId;
  final String uuid;
  final String missingKey;
  final bool isFetchMore;
  DeletePostEvent({
    required this.posts,
    required this.queryResult,
    required this.deletedPostId,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
  });

  @override
  List<Object?> get props => [ uuid, posts, deletedPostId, queryResult, missingKey, isFetchMore ];
}

class AddPostEvent extends UserPostsEvent {
  final UserPosts$Query$PaginatedPosts$Post post;
  final UserPosts$Query$PaginatedPosts posts;
  final QueryResult queryResult;
  final String uuid;
  final String missingKey;
  final bool isFetchMore;
  AddPostEvent({
    required this.post,
    required this.posts,
    required this.queryResult,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
  });

  @override
  List<Object?> get props => [ uuid, post, posts, queryResult, missingKey, isFetchMore ];
}

class ChangePostEvent extends UserPostsEvent {
  final UserPosts$Query$PaginatedPosts posts;
  final QueryResult queryResult;
  final int changePostId;
  final Map<String, dynamic> changeMap;
  // final String changeField;
  // final dynamic changeFieldVal;
  final String uuid;
  final String missingKey;
  final bool isFetchMore;
  ChangePostEvent({
    required this.posts,
    required this.queryResult,
    required this.changePostId,
    required this.changeMap,
    // required this.changeField,
    // required this.changeFieldVal,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
  });

  @override
  List<Object?> get props => [ uuid, posts, changePostId, changeMap, queryResult, missingKey, isFetchMore ];
}