import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class FetchMoreInitEvent extends PostsEvent {}

class FetchMoreEvent extends PostsEvent {
  final int limit;
  final String id;
  final bool isFetchMore;
  final bool isFollowing;
  final QueryResult? queryResult;
  FetchMoreEvent({
    required this.limit,
    required this.id,
    required this.isFetchMore,
    required this.isFollowing,
    this.queryResult
  });

  @override
  List<Object?> get props => [ limit, id, isFollowing, isFetchMore, queryResult ];
}

class FetchMoreVideogamePostsEvent extends PostsEvent {
  final int limit;
  final String id;
  final int videogameId;
  final String videogameName;
  final bool isFetchMore;
  final QueryResult? queryResult;
  FetchMoreVideogamePostsEvent({
    required this.limit,
    required this.id,
    required this.videogameId,
    required this.videogameName,
    required this.isFetchMore,
    this.queryResult
  });

  @override
  List<Object?> get props => [ limit, id, videogameId, videogameName, isFetchMore, queryResult ];
}

class DeletePostEvent extends PostsEvent {
  final dynamic posts;
  final QueryResult queryResult;
  final int deletedPostId;
  final String uuid;
  final String missingKey;
  final bool isFollowing;
  final bool isFetchMore;
  final int? videogameId;
  final String? videogameName;
  DeletePostEvent({
    required this.posts,
    required this.queryResult,
    required this.deletedPostId,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
    required this.isFollowing,
    this.videogameId,
    this.videogameName
  });

  @override
  List<Object?> get props => [ uuid, posts, deletedPostId, queryResult, missingKey, isFetchMore, isFollowing, videogameName, videogameId ];
}

class ChangePostEvent extends PostsEvent {
  final dynamic posts;
  final QueryResult queryResult;
  final int changePostId;
  final Map<String, dynamic> changeMap;
  // final String changeField;
  // final dynamic changeFieldVal;
  final String uuid;
  final String missingKey;
  final bool isFollowing;
  final bool isFetchMore;
  final int? videogameId;
  final String? videogameName;
  ChangePostEvent({
    required this.posts,
    required this.queryResult,
    required this.changePostId,
    required this.changeMap,
    // required this.changeFieldVal,
    required this.uuid,
    required this.missingKey,
    required this.isFetchMore,
    required this.isFollowing,
    this.videogameId,
    this.videogameName
  });

  @override
  List<Object?> get props => [ uuid, posts, changePostId, changeMap, queryResult, missingKey, isFetchMore, isFollowing, videogameName, videogameId ];
}