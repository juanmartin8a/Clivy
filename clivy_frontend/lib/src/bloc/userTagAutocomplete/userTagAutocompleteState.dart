import 'package:equatable/equatable.dart';

class UserTagAutocompleteState extends Equatable {
  const UserTagAutocompleteState();

  @override
  List<Object?> get props => [];
}

class UserTagAutocompleteInitState extends UserTagAutocompleteState {}

class UserTagAutocompleteDefaultState extends UserTagAutocompleteState {}

class AutocompleteUserTagState extends UserTagAutocompleteState {
  final String id;
  final String username;
  final String randomId;
  final int userId;
  AutocompleteUserTagState({
    required this.id,
    required this.username,
    required this.randomId,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, username, randomId, userId];
}