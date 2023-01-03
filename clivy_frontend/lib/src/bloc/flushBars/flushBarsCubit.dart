import 'package:bloc/bloc.dart';
import 'flushBarsState.dart';

class FlushBarsCubit extends Cubit<FlushBarsState> {
  FlushBarsCubit() : super(FlushBarsInitState());

  void uploadingPostFlushBar() {
    emit(FlushBarsUploadingPostState());
  }

  void uploadedPostFlushBar() {
    emit(FlushBarsUploadedPostState());
  }

  void uploadPostFailedFlushBar() {
    emit(FlushBarsUploadPostFailedState());
  }
}