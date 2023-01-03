import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/forYouFollowing/forYouFollowingState.dart';

class ForYouFollowingCubit extends Cubit<ForYouFollowingState> {
  ForYouFollowingCubit() : super(ShowForYouFollowingState());

  void showUnshowForYouFollowingState(bool isShow) {
    if (isShow) {
      emit(ShowForYouFollowingState());
    } else {
      emit(UnshowForYouFollowingState());
    }
  }
}