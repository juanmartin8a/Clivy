import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/loading/loadingNotifications/loadingNotificationsState.dart';

class LoadingNotificationsCubit extends Cubit<LoadingNotificationsState> {
  LoadingNotificationsCubit() : super(LoadingNotificationsInitState());

  Future<void> loader(bool isLoading) async {
    if (isLoading == true) {
      emit(GetNotificationsLoadingState());
    } else {
      emit(GetNotificationsLoadedState());
    }
  }
}