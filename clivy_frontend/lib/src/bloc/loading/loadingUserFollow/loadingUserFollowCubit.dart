import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserFollow/loadingUserFollowState.dart';

class LoadingUserFollowCubit extends Cubit<LoadingUserFollowState> {
  LoadingUserFollowCubit() : super(LoadingUserFollowInitState());

  Future<void> loader(bool isLoading, int userId, bool isFollowers, String uuid) async {
    if (isLoading == true) {
      emit(GetUserFollowLoadingState(
        userId: userId, 
        isFollowers: isFollowers,
        uuid: uuid
      ));
    } else {
      emit(GetUserFollowLoadedState(
        userId: userId, 
        isFollowers: isFollowers,
        uuid: uuid
      ));
    }
  }
}