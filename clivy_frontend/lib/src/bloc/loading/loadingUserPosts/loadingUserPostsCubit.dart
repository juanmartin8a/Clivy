import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserPosts/loadingUserPostsState.dart';

class LoadingUserPostsCubit extends Cubit<MoreUserPostsLoadingState> {
  LoadingUserPostsCubit() : super(MoreUserPostsLoadingInitState());

  Future<void> loader(bool isLoading, String id) async {
    if (isLoading == true) {
      emit(LoadingMoreUserPostsState(id: id));
    } else {
      emit(MoreUserPostsLoadedState(id: id));
    }
  }
}