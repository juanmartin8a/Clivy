import 'package:equatable/equatable.dart';

class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object?> get props => [];
}

class LikeInitState extends LikeState {}

class LikePostState extends LikeState {
  final int postId;
  final bool isPre;
  final String clientId;
  LikePostState({
    required this.postId,
    this.isPre = false,
    required this.clientId
  });

  @override
  List<Object?> get props => [postId, clientId];
}

class UnlikePostState extends LikeState {
  final int postId;
  final bool isPre;
  final String clientId;
  UnlikePostState({
    required this.postId,
    this.isPre = false,
    required this.clientId
  });

  @override
  List<Object?> get props => [postId, clientId];
}
