import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

class VideogameOptions {

  QueryOptions allVideogamesQueryOptions() {
    QueryOptions queryOptions = QueryOptions(
      document: AllVideogamesQuery().document,
      fetchPolicy: FetchPolicy.noCache
    );
    return queryOptions;
  }

  QueryOptions allVideogameGenresQueryOptions() {
    QueryOptions queryOptions = QueryOptions(
      document: AllVideogameGenresQuery().document,
      fetchPolicy: FetchPolicy.noCache
    );
    return queryOptions;
  }

  QueryOptions allTapsVideogamesQueryOptions() {
    QueryOptions queryOptions = QueryOptions(
      document: AllTapsVideogamesQuery().document,
      fetchPolicy: FetchPolicy.noCache
    );
    return queryOptions;
  }

  // add user interests

  AddUserInterestsMutation addUserInterestsMutation(List<int> videogameGenreIds) {
    AddUserInterestsMutation addUserInterestsMutation = AddUserInterestsMutation(
      variables: AddUserInterestsArguments(
        videogameGenresIds: videogameGenreIds
      )
    );

    return addUserInterestsMutation;
  }

  MutationOptions addUserInterestsMutationOptions(List<int> videogameGenreIds) {
    MutationOptions mutationOptions = MutationOptions(
      document: addUserInterestsMutation(videogameGenreIds).document,
      variables: {
        "videogameGenresIds": videogameGenreIds
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }
}