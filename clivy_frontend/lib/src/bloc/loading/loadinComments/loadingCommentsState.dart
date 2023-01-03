import 'package:equatable/equatable.dart';

abstract class LoadingCommentsState extends Equatable {
  const LoadingCommentsState();

  @override
  List<Object?> get props => [];
}

class LoadingCommentsInitState extends LoadingCommentsState {}

class GetCommentsLoadingState extends LoadingCommentsState {
  final int postId;
  final String uuid;
  GetCommentsLoadingState({
    required this.postId,
    required this.uuid
  });

  @override
  List<Object?> get props => [postId, uuid];
}

class GetCommentsLoadedState extends LoadingCommentsState {
  final int postId;
  final String uuid;
  GetCommentsLoadedState({
    required this.postId,
    required this.uuid
  });

  @override
  List<Object?> get props => [postId, uuid];
}