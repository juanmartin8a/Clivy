import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/commentLike/commentLikeState.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:uuid/uuid.dart';

class CommentLikeCubit extends Cubit<CommentLikeState> {
  final PostRepository postRepo;
  CommentLikeCubit({
    required this.postRepo
  }) : super(CommentLikeInitState());

  void likeUnlikeComment({
    required int commentId, 
    required bool isLike
  }) async {
    try {
      String newClientId = Uuid().v4();
      if (!isLike) {
        emit(LikeCommentState(
          commentId: commentId,
          isPre: true,
          clientId: newClientId
        ));
      } else if (isLike) {
        emit(UnlikeCommentState(
          commentId: commentId,
          isPre: true,
          clientId: newClientId
        ));
      }
      final likeVal = await postRepo.likeComment(commentId, newClientId);
      if (likeVal.value == 1) {
        emit(LikeCommentState(
          commentId: commentId,
          clientId: likeVal.clientId!
        ));
      } else if (likeVal.value == -1) {
        emit(UnlikeCommentState(
          commentId: commentId,
          clientId: likeVal.clientId!
        ));
      }
    } catch(err) {
      print(err);
    }
  }
  
  void likeUnlikeReply({
    required int replyId, 
    required bool isLike
  }) async {
    try {
      String newClientId = Uuid().v4();
      if (!isLike) {
        emit(LikeReplyState(
          replyId: replyId,
          isPre: true,
          clientId: newClientId
        ));
      } else if (isLike) {
        emit(UnlikeReplyState(
          replyId: replyId,
          isPre: true,
          clientId: newClientId
        ));
      }
      final likeVal = await postRepo.likeReply(replyId, newClientId);
      print(likeVal);
      if (likeVal.value == 1) {
        emit(LikeReplyState(
          replyId: replyId,
          clientId: likeVal.clientId!
        ));
      } else if (likeVal.value == -1) {
        emit(UnlikeReplyState(
          replyId: replyId,
          clientId: likeVal.clientId!
        ));
      }
    } catch(err) {
      print(err);
    }
  }
}