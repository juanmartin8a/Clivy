import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchInitEvent extends SearchEvent {}

class SearchSubmitEvent extends SearchEvent {
  final String search;
  final String id;
  SearchSubmitEvent({
    required this.search,
    required this.id,
  });

  @override
  List<Object?> get props => [ search, id ];
}

class SearchedUsersEvent extends SearchEvent {
  final String id;
  SearchedUsersEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [ id ];
}

class SearchedUserAddedEvent extends SearchEvent {
  final String id;
  final int userId;
  final String username;
  final String name;
  final String file;
  final SearchedUsers$Query searchedUsers;
  SearchedUserAddedEvent({
    required this.id,
    required this.userId,
    required this.file,
    required this.name,
    required this.username,
    required this.searchedUsers,
  });

  @override
  List<Object?> get props => [ id, userId, file, name, username, searchedUsers ];
}

class SearchedUserRemoveEvent extends SearchEvent {
  final String id;
  final int userId;
  final SearchedUsers$Query searchedUsers;
  SearchedUserRemoveEvent({
    required this.id,
    required this.userId,
    required this.searchedUsers,
  });

  @override
  List<Object?> get props => [ id, userId, searchedUsers ];
}

class SearchCancelEvent extends SearchEvent {}