import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/loading/loadinComments/loadingCommentsState.dart';

class LoadingCommentsCubit extends Cubit<LoadingCommentsState> {
  LoadingCommentsCubit() : super(LoadingCommentsInitState());

  Future<void> loader(bool isLoading, int postId, String uuid) async {
    if (isLoading == true) {
      emit(GetCommentsLoadingState(postId: postId, uuid: uuid));
    } else {
      emit(GetCommentsLoadedState(postId: postId, uuid: uuid));
    }
  }
}