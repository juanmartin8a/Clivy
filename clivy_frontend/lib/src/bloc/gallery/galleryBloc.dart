import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/gallery/galleryEvent.dart';
import 'package:untitled_client/src/bloc/gallery/galleryState.dart';
import 'package:untitled_client/src/bloc/gallery/loading/galleryLoadingCubit.dart';
import 'package:untitled_client/src/repos/galleryRepository.dart';
import 'package:untitled_client/src/utils/gallery/galleryUtils.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryLoadingCubit galleryLoadingCubit;
  final GalleryRepository galleryRepo;
  GalleryBloc({
    required this.galleryLoadingCubit,
    required this.galleryRepo
  }) : super(GalleryInitState());
  // int page = 0;

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* { 
    if (event is FetchFromGallery) {
      galleryLoadingCubit.loader(true);
      // try {
        // print("toromax");
        final media = await galleryRepo.fetchImagesFromGallery(event.page);
        // print(media);
        final newWidgets = await GalleryUtils(galleryBloc: this).getWidgetListFromAssetList(media);
        // print(media.length);
        galleryLoadingCubit.loader(false);
        if (media.isEmpty || media.length < 80) {
          yield GalleryLoadedState(
            page: event.page,
            gallery: [...event.widgetList, ...newWidgets],
            hasMore: false
          );
        } else {
          yield GalleryLoadedState(
            page: event.page + 1,
            gallery: [...event.widgetList, ...newWidgets],
            hasMore: true
          );
        }
      // } catch(err) {
      //   galleryLoadingCubit.loader(false);
      //   print(err);
      //   yield GalleryFailedState();
      // }
    } 
    // else if (event is GalleryFileChoosenEvent) {
    //   yield GalleryFileChoosenState(
    //     file: event.file
    //   );
    // } 
    else if (event is GalleryOnChangeEvent) {
      galleryLoadingCubit.loader(true);
      final updatedMedia = await galleryRepo.updateImagesFromGallery(event.page);
      final newWidgets = await GalleryUtils(galleryBloc: this).getWidgetListFromAssetList(updatedMedia);
      galleryLoadingCubit.loader(false);
      if (newWidgets.isEmpty || (newWidgets.length % 80) != 0) {
        yield GalleryLoadedState(
          page: event.page,
          gallery: newWidgets,
          hasMore: false
        );
      } else {
        yield GalleryLoadedState(
          page: event.page,
          gallery: newWidgets,
          hasMore: true
        );
      }

    }
  }
  
}