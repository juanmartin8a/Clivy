import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/homeAppBar/homeAppBarState.dart';

class HomeAppBarCubit extends Cubit<HomeAppBarState> {
  HomeAppBarCubit() : super(HomeAppBarInitState());

  void changeTitleOpacity(double titleOpacity, double page) {
    late double clivyOpacity;
    late double usernameOpacity;
    late double activityOpacity;
    late double createClipOpacity;
    if (page < 1) {
      clivyOpacity = 1 - titleOpacity;
      usernameOpacity = titleOpacity;
      activityOpacity = 0;
      createClipOpacity = 0;
    } else if (page >= 1 && page < 2) {
      clivyOpacity = 0;
      usernameOpacity = 1 - titleOpacity;
      activityOpacity = titleOpacity;
      createClipOpacity = 0;
    } else if (page >= 2 && page < 3) {
      clivyOpacity = 0;
      usernameOpacity = 0;
      activityOpacity = 1 - titleOpacity;
      createClipOpacity = titleOpacity;
    } else {
      clivyOpacity = 0;
      usernameOpacity = 0;
      activityOpacity = titleOpacity;
      createClipOpacity = 1 - titleOpacity;
    }
    // print(clivyOpacity);
    emit(HomeAppBarChangePageState(
      clivyOpacity: clivyOpacity,
      usernameOpacity: usernameOpacity,
      activityOpacity: activityOpacity,
      createClipOpacity: createClipOpacity
    ));
  }
}