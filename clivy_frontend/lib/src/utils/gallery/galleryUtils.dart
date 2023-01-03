import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:untitled_client/src/bloc/gallery/galleryBloc.dart';
import 'package:untitled_client/src/ui/screens/createPost/widgets/prevData.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';

class GalleryUtils {
  final GalleryBloc galleryBloc;
  GalleryUtils({
    required this.galleryBloc
  });

  Future<List<Widget>> getWidgetListFromAssetList(List<AssetEntity> assetList) async {
    List<Widget> widgetList= [];
    for (int i = 0; i < assetList.length; i++) {
      final Widget image = AssetEntityImage(
        assetList[i],
        isOriginal: false, // Defaults to `true`.
        thumbnailSize: const ThumbnailSize.square(240), // Preferred value.
        thumbnailFormat: ThumbnailFormat.jpeg, // Defaults to `jpeg`.
        fit: BoxFit.cover,
      );

      widgetList.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: GestureDetector(
            onTap: () async {
              final dimsList = GlobalUtils().getFileDimensions(
                assetList[i].width, assetList[i].height
              );

              // String? mediaUrl = await assetList[i].getMediaUrl();

              Get.dialog(
                PreviewFile(
                  // mediaUrl: mediaUrl!,
                  assetEntity: assetList[i],
                  fileHeight: dimsList[1],
                  fileWidth: dimsList[0],
                ),
                transitionDuration: Duration(milliseconds: 250),
                barrierColor: Colors.black38,
              );
            },
            child: image
          )
        )
      );
      // widgetList.add(
      //   ClipRRect(
      //     borderRadius: BorderRadius.circular(3),
      //     child: FutureBuilder(
      //       future: assetList[i].thumbDataWithSize(240, 240, quality: 85),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.done) {
      //           return GestureDetector(
      //             onTap: () async {
      //               final dimsList = GlobalUtils().getFileDimensions(
      //                 assetList[i].width, assetList[i].height
      //               );

      //               String? mediaUrl = await assetList[i].getMediaUrl();

      //               Get.dialog(
      //                 PreviewFile(
      //                   mediaUrl: mediaUrl!,
      //                   fileHeight: dimsList[1],
      //                   fileWidth: dimsList[0],
      //                 ),
      //                 transitionDuration: Duration(milliseconds: 250),
      //                 barrierColor: Colors.black38,
      //               );
      //             },
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(3),
      //                 image: DecorationImage(
      //                   image: MemoryImage(
      //                     (snapshot.data as Uint8List)
      //                   ),
      //                   fit: BoxFit.cover
      //                 )
      //               )
      //             )
      //           );
      //         }
      //         return Container();
      //       }
      //     ),
      //   )
      // );
    }
    return widgetList;
  }
}