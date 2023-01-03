import 'package:equatable/equatable.dart';

abstract class DeleteState extends Equatable {
  const DeleteState();

  @override
  List<Object?> get props => [];
}

class DeleteInitState extends DeleteState {}

class DeletePostState extends DeleteState {
  final int postId;
  final bool successfullyDeleted;
  DeletePostState({
    required this.postId,
    required this.successfullyDeleted
  });

  @override
  List<Object?> get props => [postId, successfullyDeleted];
}

class DeleteCommentState extends DeleteState {
  final int commentId;
  final bool successfullyDeleted;
  final bool isReply;
  DeleteCommentState({
    required this.commentId,
    required this.successfullyDeleted,
    required this.isReply
  });

  @override
  List<Object?> get props => [commentId, successfullyDeleted, isReply];
}