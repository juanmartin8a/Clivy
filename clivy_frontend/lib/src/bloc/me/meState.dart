import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class MeState extends Equatable {
  const MeState();

  @override
  List<Object?> get props => [];
}

class MeInitialState extends MeState {}

class MeLoadingState extends MeState {}

class MeIsAuthState extends MeState {
  final Me$Query$User user;

  MeIsAuthState({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class MeIsNotAuthState extends MeState {}

class MeErrorState extends MeState {
  final String error;

  MeErrorState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}