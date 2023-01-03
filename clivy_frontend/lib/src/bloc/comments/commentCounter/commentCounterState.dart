import 'package:equatable/equatable.dart';

abstract class CommentCounterState extends Equatable {
  const CommentCounterState();

  @override
  List<Object?> get props => [];
}

class CommentCounterInitState extends CommentCounterState {}

class CommentCounterNewCommentState extends CommentCounterState {
  final int postId;
  final int commentId;
  final bool isPreUpload;
  CommentCounterNewCommentState({
    required this.postId,
    required this.commentId,
    required this.isPreUpload,
  });

  @override
  List<Object?> get props => [postId, commentId];
}

class CommentCounterDeleteCommentState extends CommentCounterState {
  final int postId;
  final int commentId;
  final bool isPreUpload;
  final int toDeleteNum;
  CommentCounterDeleteCommentState({
    required this.postId,
    required this.commentId,
    required this.isPreUpload,
    required this.toDeleteNum
  });

  @override
  List<Object?> get props => [postId, commentId, toDeleteNum];
}