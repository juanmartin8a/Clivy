import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostState.dart';
import 'package:untitled_client/src/repos/postRepository.dart';

class DeleteCubit extends Cubit<DeleteState> {
  final PostRepository postRepo;
  DeleteCubit({
    required this.postRepo
  }) : super(DeleteInitState());
  
  void deletePost(int postId) async {
    try {
      await postRepo.deletePost(postId);
      emit(DeletePostState(
        postId: postId,
        successfullyDeleted: true
      ));
    } catch(e) {}
  }

  void deleteComment(int commentId, bool isReply) async {
    try {
      // emit(DeleteCommentState(
      //   commentId: commentId,
      //   successfullyDeleted: false
      // ));
      await postRepo.deleteComment(commentId, isReply);
      // print
      emit(DeleteCommentState(
        commentId: commentId,
        successfullyDeleted: true,
        isReply: isReply
      ));
    } catch(e) {
      print(e);
    }
  }
}