import 'package:equatable/equatable.dart';

abstract class SearchedOrSearchUsersState extends Equatable {
  const SearchedOrSearchUsersState();

  @override
  List<Object?> get props => [];
}

class SearchedOrSearchUsersInitState extends SearchedOrSearchUsersState {}

class SetSearchedUsersState extends SearchedOrSearchUsersInitState {}

class SetSearchUsersState extends SearchedOrSearchUsersInitState {}