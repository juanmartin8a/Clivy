import 'package:equatable/equatable.dart';

abstract class LoadingRepliesState extends Equatable {
  const LoadingRepliesState();

  @override
  List<Object?> get props => [];
}

class LoadingRepliesInitState extends LoadingRepliesState {}

class GetRepliesLoadingState extends LoadingRepliesState {
  final int commentId;
  final String uuid;
  GetRepliesLoadingState({
    required this.commentId,
    required this.uuid
  });

  @override
  List<Object?> get props => [commentId, uuid];
}

class GetRepliesLoadedState extends LoadingRepliesState {
  final int commentId;
  final String uuid;
  GetRepliesLoadedState({
    required this.commentId,
    required this.uuid
  });

  @override
  List<Object?> get props => [commentId, uuid];
}