import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object?> get props => [];
}

class DeleteUserInitState extends DeleteUserState {
  final String uuid;
  DeleteUserInitState({
    required this.uuid
  });

  @override
  List<Object?> get props => [uuid];
}

class DeleteUserLoadingState extends DeleteUserState {
  final String uuid;
  DeleteUserLoadingState({
    required this.uuid,
  });

  @override
  List<Object?> get props => [uuid];
}

class DeleteUserDeletedState extends DeleteUserState {
  final String uuid;
  DeleteUserDeletedState({
    required this.uuid
  });

  @override
  List<Object?> get props => [uuid];
}

class DeleteUserErrorState extends DeleteUserState {
  final String uuid;
  DeleteUserErrorState({
    required this.uuid
  });

  @override
  List<Object?> get props => [uuid];
}