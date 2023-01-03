import 'package:equatable/equatable.dart';

abstract class CommentLikeState extends Equatable {
  const CommentLikeState();

  @override
  List<Object?> get props => [];
}

class CommentLikeInitState extends CommentLikeState {}

class LikeCommentState extends CommentLikeState {
  final int commentId;
  final bool isPre;
  final String clientId;
  const LikeCommentState({
    required this.commentId,
    this.isPre = false,
    required this.clientId
  });

  @override
  List<Object?> get props => [commentId, clientId];
}

class UnlikeCommentState extends CommentLikeState {
  final int commentId;
  final bool isPre;
  final String clientId;
  const UnlikeCommentState({
    required this.commentId,
    this.isPre = false,
    required this.clientId,
  });

  @override
  List<Object?> get props => [commentId, clientId];
}

class LikeReplyState extends CommentLikeState {
  final int replyId;
  final bool isPre;
  final String clientId;
  const LikeReplyState({
    required this.replyId,
    this.isPre = false,
    required this.clientId
  });

  @override
  List<Object?> get props => [replyId, clientId];
}

class UnlikeReplyState extends CommentLikeState {
  final int replyId;
  final bool isPre;
  final String clientId;
  const UnlikeReplyState({
    required this.replyId,
    this.isPre = false,
    required this.clientId
  });

  @override
  List<Object?> get props => [replyId, clientId];
}