
import 'package:photo_manager/photo_manager.dart';

class GalleryRepository {

  askForPermission() async {
    PermissionState result = await PhotoManager.requestPermissionExtend();
    return result;
  }

  Future<List<AssetEntity>> fetchImagesFromGallery(int currentPage) async {
    PermissionState result = await askForPermission();
    if (result.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.video,
        filterOption: FilterOptionGroup()
        ..setOption(AssetType.video, FilterOption())
        ..addOrderOption(
          OrderOption(
            type: OrderOptionType.createDate,
            asc: false,
          ),
        )
      );
      List<AssetEntity> media = await albums[0].getAssetListPaged(page: currentPage, size: 120);

      print(result);

      return media.length > 0 ? media : [];
    } 
    throw 'no access to gallery';
  }

  Future<List<AssetEntity>> updateImagesFromGallery(int page) async {
    var result = await askForPermission();
    if (result) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.video,
        filterOption: FilterOptionGroup()
        ..setOption(AssetType.video, FilterOption())
        // ..containsPathModified = true
        ..addOrderOption(
          OrderOption(
            type: OrderOptionType.createDate,
            asc: false,
          ), 
        )
      );

      List<AssetEntity> media = [];
      for (int i = 0; i < page; i++) {
        List<AssetEntity> pageAssets = await albums[0].getAssetListPaged(page: i, size: 120);
        media = [...media, ...pageAssets];
      }

      return media.length > 0 ? media : [];
    } 
    throw 'no access to gallery';
  }
}