import 'package:equatable/equatable.dart';

abstract class CommentsOrUsersState extends Equatable {
  const CommentsOrUsersState();

  @override
  List<Object?> get props => [];
}

class CommentsOrUsersInitState extends CommentsOrUsersState {}

class SetCommentsState extends CommentsOrUsersState {
  final String id;

  SetCommentsState({
    required this.id
  });

  @override
  List<Object?> get props => [id];
}

class SetUsersState extends CommentsOrUsersState {
  final String id;

  SetUsersState({
    required this.id
  });

  @override
  List<Object?> get props => [id];
}