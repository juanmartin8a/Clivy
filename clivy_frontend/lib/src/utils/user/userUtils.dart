import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../globalUtils.dart';

class UserUtils {

  Future<User$Query$User> getUpdatedUser(
    Map<String, dynamic> changedUser
  ) async {
    return User$Query$User.fromJson(changedUser);
  }

  Future<CustomMultipartFile> getCompressedPFP(String path) async {
    Directory directory = await getTemporaryDirectory();
    String _destinationPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    File? compressedFile = await FlutterImageCompress.compressAndGetFile(
      path,
      _destinationPath,
      quality: 80,
      minHeight: 350,
      minWidth: 350,
    );

    if (compressedFile == null) {
      print("error");
    }

    CustomMultipartFile customMultipartFile = await GlobalUtils().getCustomMultipartFileFromFile(
      File(_destinationPath) // File(response['onSuccess'])
    );

    return customMultipartFile;
  }

  Future<CustomMultipartFile> getCompressedSmallPFP(String path) async {
    Directory directory = await getTemporaryDirectory();
    String _destinationPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    File? compressedFile = await FlutterImageCompress.compressAndGetFile(
      path,
      _destinationPath,
      quality: 80,
      minHeight: 100,
      minWidth: 100,
    );

    if (compressedFile == null) {
      print("error");
    }

    CustomMultipartFile customMultipartFile = await GlobalUtils().getCustomMultipartFileFromFile(
      File(_destinationPath) // File(response['onSuccess'])
    );

    return customMultipartFile;
  }

  // Future<Map<String, dynamic>> getUserChangeAction(
  //   Map<String, dynamic> user,
  //   String changeField,
  //   dynamic changeFieldVal
  // ) async {
  //   final userJson = user; 
  //   userJson["$changeField"] = changeFieldVal;
  //   // final newPaginatedPosts = User$Query$User.fromJson(userJson);

  //   return userJson;
  // }

}