import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/comments/commentCounter/commentCounterState.dart';

class CommentCounterCubit extends Cubit<CommentCounterState> {
  CommentCounterCubit() : super(CommentCounterInitState());

  void commentDeleteComment(
    int id, int commentId, bool isPreUpload, bool isDelete, int? toDeleteNum
  ) {
    if (!isDelete) {
      emit(CommentCounterNewCommentState(
        postId: id,
        commentId: commentId,
        isPreUpload: isPreUpload
      ));
    } else {
      emit(CommentCounterDeleteCommentState(
        postId: id,
        commentId: commentId,
        isPreUpload: isPreUpload,
        toDeleteNum: toDeleteNum != null ? toDeleteNum : 1,
      ));
    }
  }
}