import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/loading/loadingSinglePost/loadingSinglePostState.dart';

class LoadingSinglePostCubit extends Cubit<LoadingSinglePostState> {
  LoadingSinglePostCubit() : super(LoadingSinglePostInitState());

  Future<void> loader(bool isLoading, String uuid) async {
    if (isLoading == true) {
      emit(SinglePostLoadingState(uuid: uuid));
    } else {
      emit(SinglePostLoadedState(uuid: uuid));
    }
  }
}