import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mime/mime.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:http_parser/http_parser.dart';

class GlobalUtils {

  QueryResult generateQueryResult(
    QueryResultSource source, Map<String, dynamic> data, String missingKey
  ) {
    Map<String, dynamic> result = {};
    result["$missingKey"] = data;
    QueryResult queryResult = QueryResult(
      data: result,
      source: source
    );

    return queryResult;
  }

  List<int> getFileDimensions(int width, int height) {
    int newHeight = height;
    int newWidth = width;
    
    if (height > (width * 1.25)) {
      newHeight = (width * 1.25).toInt(); // aspect ratio of 5 / 4
    } else if (width > (height * 1.78) ) {
      newWidth = (height * 1.78).toInt(); // aspect ratio of 16 / 9
    }

    return [(newWidth ~/ 2) * 2, (newHeight ~/ 2) * 2];
    // return [newWidth, newHeight];
  }

  Future<CustomMultipartFile> getCustomMultipartFileFromFile(File file) async {
    var mimeType = lookupMimeType(file.path);
  // print(mimeType);
    MediaType contentType = MediaType(mimeType?.split('/')[0] as String, mimeType?.split('/')[1] as String);
    // print(contentType);
    CustomMultipartFile multipartFile = await CustomMultipartFile.fromPath(
      'field',
      file.path,
      contentType: contentType
    );
    return multipartFile;
  }

}