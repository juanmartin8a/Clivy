import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.graphql.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitState extends SearchState {}

class SearchLoadedState extends SearchState {
  final SearchUsers$Query? search;
  // final bool isSearchResults;
  // final SearchedUsers$Query? searchedUsers;
  final String? id;
  SearchLoadedState({
    this.search,
    // required this.isSearchResults,
    // this.searchedUsers,
    this.id
  });

  @override
  List<Object?> get props => [search, id];
}

class SearchedLoadedState extends SearchState {
  final SearchedUsers$Query searchedUsers;
  final String id;
  SearchedLoadedState({
    required this.searchedUsers,
    required this.id
  });

  @override
  List<Object?> get props => [searchedUsers, id];
}
