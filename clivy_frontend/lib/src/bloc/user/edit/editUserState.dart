import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.graphql.dart';

abstract class EditUserState extends Equatable {

  const EditUserState();

  @override
  List<Object?> get props => [];

}

class EditUserInitState extends EditUserState {}

class EditUserEditableState extends EditUserState {}

class EditUserLoadingState extends EditUserState {}

class EditUserErrorState extends EditUserState {
  final bool globalError;
  final List<EditProfile$Mutation$UserMutationResponse$ErrorResponse>? errors;
  EditUserErrorState({
    this.globalError = false,
    this.errors
  });

  @override
  List<Object?> get props => [globalError, errors];
}

class EditUserUpdatedState extends EditUserState {
  final User$Query$User user;
  final String uuid;
  EditUserUpdatedState({
    required this.user,
    required this.uuid,
  });

  @override
  List<Object?> get props => [user, uuid];
}