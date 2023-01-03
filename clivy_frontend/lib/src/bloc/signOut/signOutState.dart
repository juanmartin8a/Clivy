
import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object?> get props => [];
}

class SignOutInitialState extends SignOutState {}

class SignOutLoadingState extends SignOutState {}

class SignOutSuccessState extends SignOutState {}

class SignOutFailedState extends SignOutState {}