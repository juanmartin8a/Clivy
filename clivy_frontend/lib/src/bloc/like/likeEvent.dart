import 'package:equatable/equatable.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object?> get props => [];
}

class LikePostEvent extends LikeEvent {
  final int postId;
  LikePostEvent({
    required this.postId
  });

  @override
  List<Object?> get props => [postId];
}

class UnlikePostEvent extends LikeEvent {
  final int postId;
  UnlikePostEvent({
    required this.postId
  });

  @override
  List<Object?> get props => [postId];
}