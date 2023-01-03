import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/loading/loadingReplies/loadingRepliesState.dart';

class LoadingRepliesCubit extends Cubit<LoadingRepliesState> {
  LoadingRepliesCubit() : super(LoadingRepliesInitState());

  Future<void> loader(bool isLoading, int commentId, String uuid) async {
    if (isLoading == true) {
      emit(GetRepliesLoadingState(commentId: commentId, uuid: uuid));
    } else {
      emit(GetRepliesLoadedState(commentId: commentId, uuid: uuid));
    }
  }
}