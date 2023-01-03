import 'package:equatable/equatable.dart';

abstract class LoadingUserFollowState extends Equatable {
  const LoadingUserFollowState();

  @override
  List<Object?> get props => [];
}

class LoadingUserFollowInitState extends LoadingUserFollowState {}

class GetUserFollowLoadingState extends LoadingUserFollowState {
  final int userId;
  final bool isFollowers;
  final String uuid;
  GetUserFollowLoadingState({
    required this.userId,
    required this.isFollowers,
    required this.uuid
  });

  @override
  List<Object?> get props => [userId, isFollowers, uuid];
}

class GetUserFollowLoadedState extends LoadingUserFollowState {
  final int userId;
  final bool isFollowers;
  final String uuid;
  GetUserFollowLoadedState({
    required this.userId,
    required this.isFollowers,
    required this.uuid
  });

  @override
  List<Object?> get props => [userId, isFollowers, uuid];
}