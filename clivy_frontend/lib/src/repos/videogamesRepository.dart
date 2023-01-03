import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/utils/videogame/videogameOptions.dart';

class VideogamesRepository {
  final GraphQLClient client;

  const VideogamesRepository({
    required this.client
  });

  Future<AllVideogames$Query> getAllVideogames() async {
    QueryResult result = await client.query(
      VideogameOptions().allVideogamesQueryOptions()
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return AllVideogames$Query.fromJson((result.data as Map<String, dynamic>));
    }
  }

  Future<AllVideogameGenres$Query> getAllVideogameGenres() async {
    QueryResult result = await client.query(
      VideogameOptions().allVideogameGenresQueryOptions()
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return AllVideogameGenres$Query.fromJson((result.data as Map<String, dynamic>));
    }
  }

  Future<AllTapsVideogames$Query> getAllTapsVideogame() async {
    QueryResult result = await client.query(
      VideogameOptions().allTapsVideogamesQueryOptions()
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return AllTapsVideogames$Query.fromJson((result.data as Map<String, dynamic>));
    }
  }

  Future<AddUserInterests$Mutation> addUserInterests(List<int> videogameGenreIds) async {
    QueryResult result = await client.mutate(
      VideogameOptions().addUserInterestsMutationOptions(videogameGenreIds)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return AddUserInterests$Mutation.fromJson(result.data as Map<String, dynamic>);
    }
  }
}