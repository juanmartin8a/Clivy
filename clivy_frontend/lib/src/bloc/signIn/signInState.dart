import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInCompleteState extends SignInState {
  final SignIn$Mutation$UserMutationResponse signInResponse;
  SignInCompleteState({
    required this.signInResponse,
  });

  @override
  List<Object?> get props => [signInResponse];
}

class SignInFieldErrorState extends SignInState {
  final List<SignIn$Mutation$UserMutationResponse$ErrorResponse> errors;
  SignInFieldErrorState({
    required this.errors,
  });

  @override
  List<Object?> get props => [errors];
}

class SignInErrorState extends SignInState {}