import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/gallery/loading/galleryLoadingState.dart';

class GalleryLoadingCubit extends Cubit<GalleryLoadingState> {
  GalleryLoadingCubit() : super(GalleryLoadingInitState());
  
  Future<void> loader(bool isLoading) async {
    if (isLoading == true) {
      emit(GetGalleryLoadingState());
    } else {
      emit(GetGalleryLoadedState());
    }
  }
}