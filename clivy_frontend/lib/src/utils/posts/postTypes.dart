import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gqlf;
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart';

// posts
@JsonSerializable(explicitToJson: true)
class PostsQueryResponse extends JsonSerializable with EquatableMixin {

  PostsQueryResponse();

  factory PostsQueryResponse.fromJson(Map<String, dynamic> json) =>
    _$PostsQueryResponseFromJson(json);

  late Posts$Query$PaginatedPosts posts;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [posts, queryResult];
  Map<String, dynamic> toJson() => 
    _$PostsQueryResponseToJson(this);
}

// following posts
@JsonSerializable(explicitToJson: true)
class FollowingPostsQueryResponse extends JsonSerializable with EquatableMixin {

  FollowingPostsQueryResponse();

  factory FollowingPostsQueryResponse.fromJson(Map<String, dynamic> json) =>
    _$FollowingPostsQueryResponseFromJson(json);

  late FollowingPosts$Query$PaginatedPosts posts;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [posts, queryResult];
  Map<String, dynamic> toJson() => 
    _$FollowingPostsQueryResponseToJson(this);
}

// videogame posts
@JsonSerializable(explicitToJson: true)
class VideogamePostsQueryResponse extends JsonSerializable with EquatableMixin {

  VideogamePostsQueryResponse();

  factory VideogamePostsQueryResponse.fromJson(Map<String, dynamic> json) =>
    _$VideogamePostsQueryResponseFromJson(json);

  late VideogamePosts$Query$PaginatedPosts posts;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [posts, queryResult];
  Map<String, dynamic> toJson() => 
    _$VideogamePostsQueryResponseToJson(this);
}

// comments
@JsonSerializable(explicitToJson: true)
class CommentsQueryResponse extends JsonSerializable with EquatableMixin {

  CommentsQueryResponse();

  factory CommentsQueryResponse.fromJson(Map<String, dynamic> json) =>
    _$CommentsQueryResponseFromJson(json);

  late Comments$Query$CommentResponse comments;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [comments, queryResult];
  Map<String, dynamic> toJson() => 
    _$CommentsQueryResponseToJson(this);
}

// replies
@JsonSerializable(explicitToJson: true)
class RepliesQueryResponse extends JsonSerializable with EquatableMixin {

  RepliesQueryResponse();

  factory RepliesQueryResponse.fromJson(Map<String, dynamic> json) =>
    _$RepliesQueryResponseFromJson(json);

  late Replies$Query$ReplyResponse replies;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [replies, queryResult];
  Map<String, dynamic> toJson() => 
    _$RepliesQueryResponseToJson(this);
}

// user posts

@JsonSerializable(explicitToJson: true)
class UserPostsQueryResponse extends JsonSerializable with EquatableMixin {

  UserPostsQueryResponse();

  factory UserPostsQueryResponse.fromJson(Map<String, dynamic> json) =>
    _$UserPostsQueryResponseFromJson(json);

  late UserPosts$Query$PaginatedPosts userPosts;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [userPosts, queryResult];
  Map<String, dynamic> toJson() => 
    _$UserPostsQueryResponseToJson(this);
}

// userFollow

@JsonSerializable(explicitToJson: true)
class UserFollowingResponse extends JsonSerializable with EquatableMixin {

  UserFollowingResponse();

  factory UserFollowingResponse.fromJson(Map<String, dynamic> json) =>
    _$UserFollowingResponseFromJson(json);

  late UserFollowing$Query$PaginatedFollow paginatedUsers;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [paginatedUsers, queryResult];
  Map<String, dynamic> toJson() => 
    _$UserFollowingResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowersResponse extends JsonSerializable with EquatableMixin {

  UserFollowersResponse();

  factory UserFollowersResponse.fromJson(Map<String, dynamic> json) =>
    _$UserFollowersResponseFromJson(json);

  late UserFollowers$Query$PaginatedFollow paginatedUsers;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [paginatedUsers, queryResult];
  Map<String, dynamic> toJson() => 
    _$UserFollowersResponseToJson(this);
}

// notifications
@JsonSerializable(explicitToJson: true)
class NotificationsResponse extends JsonSerializable with EquatableMixin {

  NotificationsResponse();

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
    _$NotificationsResponseFromJson(json);

  late Notifications$Query$PaginatedNotifications paginatedNotifications;

  @JsonKey(
      fromJson: fromGraphQLQueryResultToDartQueryResult,
      toJson: fromDartQueryResultToGraphQLQueryResult)
  late gqlf.QueryResult queryResult;

  @override
  List<Object?> get props => [paginatedNotifications, queryResult];
  Map<String, dynamic> toJson() => 
    _$NotificationsResponseToJson(this);
}

// posts
PostsQueryResponse _$PostsQueryResponseFromJson(
    Map<String, dynamic> json) {
  return PostsQueryResponse()
    ..posts = json['posts'] as Posts$Query$PaginatedPosts
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$PostsQueryResponseToJson(
    PostsQueryResponse instance) =>
<String, dynamic>{
  'posts': instance.posts,
  'queryResult': instance.queryResult,
};

// following posts
FollowingPostsQueryResponse _$FollowingPostsQueryResponseFromJson(
    Map<String, dynamic> json) {
  return FollowingPostsQueryResponse()
    ..posts = json['posts'] as FollowingPosts$Query$PaginatedPosts
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$FollowingPostsQueryResponseToJson(
    FollowingPostsQueryResponse instance) =>
<String, dynamic>{
  'posts': instance.posts,
  'queryResult': instance.queryResult,
};

// videogame posts
VideogamePostsQueryResponse _$VideogamePostsQueryResponseFromJson(
    Map<String, dynamic> json) {
  return VideogamePostsQueryResponse()
    ..posts = json['posts'] as VideogamePosts$Query$PaginatedPosts
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$VideogamePostsQueryResponseToJson(
    VideogamePostsQueryResponse instance) =>
<String, dynamic>{
  'posts': instance.posts,
  'queryResult': instance.queryResult,
};

// comments
CommentsQueryResponse _$CommentsQueryResponseFromJson(
  Map<String, dynamic> json) {
  return CommentsQueryResponse()
    ..comments = json['comments'] as Comments$Query$CommentResponse
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$CommentsQueryResponseToJson(
    CommentsQueryResponse instance) =>
<String, dynamic>{
  'comments': instance.comments,
  'queryResult': instance.queryResult,
};

// replies
RepliesQueryResponse _$RepliesQueryResponseFromJson(
  Map<String, dynamic> json) {
  return RepliesQueryResponse()
    ..replies = json['replies'] as Replies$Query$ReplyResponse 
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$RepliesQueryResponseToJson(
    RepliesQueryResponse instance) =>
<String, dynamic>{
  'replies': instance.replies,
  'queryResult': instance.queryResult,
};

// user posts
UserPostsQueryResponse _$UserPostsQueryResponseFromJson(
    Map<String, dynamic> json) {
  return UserPostsQueryResponse()
    ..userPosts = json['userPosts'] as UserPosts$Query$PaginatedPosts
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$UserPostsQueryResponseToJson(
    UserPostsQueryResponse instance) =>
<String, dynamic>{
  'userPosts': instance.userPosts,
  'queryResult': instance.queryResult,
};

// userFollow

UserFollowingResponse _$UserFollowingResponseFromJson(
    Map<String, dynamic> json) {
  return UserFollowingResponse()
    ..paginatedUsers = json['paginatedUsers'] as UserFollowing$Query$PaginatedFollow
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$UserFollowingResponseToJson(
    UserFollowingResponse instance) =>
<String, dynamic>{
  'paginatedUsers': instance.paginatedUsers,
  'queryResult': instance.queryResult,
};

UserFollowersResponse _$UserFollowersResponseFromJson(
    Map<String, dynamic> json) {
  return UserFollowersResponse()
    ..paginatedUsers = json['paginatedUsers'] as UserFollowers$Query$PaginatedFollow
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$UserFollowersResponseToJson(
    UserFollowersResponse instance) =>
<String, dynamic>{
  'paginatedUsers': instance.paginatedUsers,
  'queryResult': instance.queryResult,
};

// notifications
NotificationsResponse _$NotificationsResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationsResponse()
    ..paginatedNotifications = json['paginatedNotifications'] as Notifications$Query$PaginatedNotifications
    ..queryResult = json['queryResult'] as gqlf.QueryResult;
}

Map<String, dynamic> _$NotificationsResponseToJson(
    NotificationsResponse instance) =>
<String, dynamic>{
  'paginatedNotifications': instance.paginatedNotifications,
  'queryResult': instance.queryResult,
};

gqlf.QueryResult fromGraphQLQueryResultToDartQueryResult(gqlf.QueryResult queryResult) => queryResult;
gqlf.QueryResult fromDartQueryResultToGraphQLQueryResult(gqlf.QueryResult queryResult) => queryResult;