import 'package:equatable/equatable.dart';

abstract class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object?> get props => [];
}

class FollowInitState extends FollowState {}

class FollowUserState extends FollowState {
  final int userId;
  final bool isPre;
  final String clientId;
  FollowUserState({
    required this.userId,
    this.isPre = false,
    required this.clientId
  });

  @override
  List<Object?> get props => [userId, isPre, clientId];
}

class UnfollowUserState extends FollowState {
  final int userId;
  final bool isPre;
  final String clientId;
  UnfollowUserState({
    required this.userId,
    this.isPre = false,
    required this.clientId
  });

  @override
  List<Object?> get props => [userId, isPre, clientId];
}