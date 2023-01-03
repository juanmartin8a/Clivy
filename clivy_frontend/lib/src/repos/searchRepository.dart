import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/utils/search/searchOptions.dart';

class SearchRepository {
  final GraphQLClient client;
  SearchRepository({
    required this.client
  });

  Future<SearchUsers$Query> searchUsers(String search) async {
    final result = await client.query(
      SearchOptions().searchQueryOptions(search)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SearchUsers$Query.fromJson(
        (result.data as Map<String, dynamic>)
      );
    }
  }

  Future<SearchedUsers$Query> searchedUsers() async {
    final result = await client.query(
      SearchOptions().searchedUsersOptions()
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SearchedUsers$Query.fromJson(
        (result.data as Map<String, dynamic>)
      );
    }
  }

  Future<UserTapped$Mutation> userTapped(int id) async {
    final result = await client.mutate(
      SearchOptions().userTappedOptions(id)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return UserTapped$Mutation.fromJson(
        (result.data as Map<String, dynamic>)
      );
    }
  }

  Future<DeleteUserSearch$Mutation> deleteUserSearch(int id) async {
    final result = await client.mutate(
      SearchOptions().deleteUserSearchOptions(id)
    );
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return DeleteUserSearch$Mutation.fromJson(
        (result.data as Map<String, dynamic>)
      );
    }
  }
}