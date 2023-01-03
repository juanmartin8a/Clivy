

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

class SearchOptions {

  // search User Query

  SearchUsersQuery searchUserQueryDocument(String search) {
    SearchUsersQuery searchUsersQuery = SearchUsersQuery(
      variables: SearchUsersArguments(
        search: search
      )
    );

    return searchUsersQuery;
  }

  QueryOptions searchQueryOptions(String search) {
    QueryOptions queryOptions = QueryOptions(
      document: searchUserQueryDocument(search).document,
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        "search": search,
      },
    );

    return queryOptions;
  } 

  // searched Users Query

  SearchedUsersQuery searchedUsersQueryDocument() {
    SearchedUsersQuery searchUsersQuery = SearchedUsersQuery();

    return searchUsersQuery;
  }

  QueryOptions searchedUsersOptions() {
    QueryOptions queryOptions = QueryOptions(
      document: searchedUsersQueryDocument().document,
      fetchPolicy: FetchPolicy.noCache,
    );

    return queryOptions;
  } 

  // user tapped mutation

  UserTappedMutation userTappedMutationDocument(int id) {
    UserTappedMutation userTappedMutation = UserTappedMutation(
      variables: UserTappedArguments(
        id: id
      )
    );

    return userTappedMutation;
  }

  MutationOptions userTappedOptions(int id) {
    MutationOptions mutationOptions = MutationOptions(
      document: userTappedMutationDocument(id).document,
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        "id": id,
      },
    );

    return mutationOptions;
  }

  // remove user search

  
  DeleteUserSearchMutation seleteUserSearchMutationDocument(int id) {
    DeleteUserSearchMutation userTappedMutation = DeleteUserSearchMutation(
      variables: DeleteUserSearchArguments(
        searchedUserId: id
      )
    );

    return userTappedMutation;
  }

  MutationOptions deleteUserSearchOptions(int id) {
    MutationOptions mutationOptions = MutationOptions(
      document: seleteUserSearchMutationDocument(id).document,
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        "searchedUserId": id,
      },
    );

    return mutationOptions;
  } 
}