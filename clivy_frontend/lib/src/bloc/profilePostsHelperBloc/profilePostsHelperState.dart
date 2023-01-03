import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

class ProfilePostsHelperState extends Equatable {
  const ProfilePostsHelperState();

  @override
  List<Object?> get props => [];
}

class ProfilePostsHelperInitState extends ProfilePostsHelperState {}

class ProfilePostsHelperPostsState extends ProfilePostsHelperState {
  final String? uuid;
  final UserPosts$Query$PaginatedPosts newPosts;
  final QueryResult? newQueryResult;
  ProfilePostsHelperPostsState({
    required this.uuid,
    required this.newPosts,
    required this.newQueryResult,
  });

  @override
  List<Object?> get props => [uuid, newPosts, newQueryResult];
}