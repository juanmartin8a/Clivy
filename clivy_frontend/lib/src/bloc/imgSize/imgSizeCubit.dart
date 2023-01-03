import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/imgSize/imgSizeState.dart';
import 'package:uuid/uuid.dart';

class ImgSizeCubit extends Cubit<ImgSizeState> {
  ImgSizeCubit() : super(ImgSizeInitState());

  void changeImgSize(String id, double imgSizeCubit) {
    emit(NewImgSizeState(
      id: id,
      newImgSize: imgSizeCubit,
      uniqueId: Uuid().v4()
    ));
  }
}