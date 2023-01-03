import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/loading/loadingState.dart';
// import 'package:untitled_client/src/bloc/like/likeState.dart';
// import 'package:untitled_client/src/repos/postRepository.dart';

class FetchPostsLoadingCubit extends Cubit<MorePostsLoadingState> {
  FetchPostsLoadingCubit() : super(MorePostsLoadingInitState());

  void loader(bool isLoading, String id) {
    if (isLoading == true) {
      emit(LoadingMorePostsState(id: id));
    } else {
      emit(MorePostsLoadedState(id: id));
    }
  }
}