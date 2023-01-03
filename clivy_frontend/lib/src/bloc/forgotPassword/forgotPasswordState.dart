import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitState extends ForgotPasswordState {}

class ForgotPasswordSendEmail extends ForgotPasswordState {
  final String uuid;
  final bool isPre;
  ForgotPasswordSendEmail({
    required this.uuid,
    this.isPre = false
  });

  @override
  List<Object?> get props => [uuid, isPre];
}

class ForgotPasswordVerifyCode extends ForgotPasswordState {
  final String uuid;
  final bool isValid;
  final String code;
  ForgotPasswordVerifyCode({
    required this.uuid,
    required this.isValid,
    required this.code
  });

   @override
  List<Object?> get props => [uuid, isValid, code];
}

class ForgotPasswordFieldErrorState extends ForgotPasswordState {
  final List<ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse> errors;
  ForgotPasswordFieldErrorState({
    required this.errors,
  });

  @override
  List<Object?> get props => [errors];
}