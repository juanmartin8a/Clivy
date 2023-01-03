import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitState extends SignUpState {}

class SignUpErrorState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpCompleteState extends SignUpState {
  final Register$Mutation$UserMutationResponse signUpResponse;
  SignUpCompleteState({
    required this.signUpResponse,
  });

  @override
  List<Object?> get props => [signUpResponse];
}

class SignUpFieldErrorState extends SignUpState {
  final List<Register$Mutation$UserMutationResponse$ErrorResponse> errors;
  SignUpFieldErrorState({
    required this.errors,
  });

  @override
  List<Object?> get props => [errors];
}

class SignUpNextState extends SignUpState {
  final int index;
  final String uuid;
  SignUpNextState({
    required this.index,
    required this.uuid
  });

  @override
  List<Object?> get props => [index, uuid];
}