import 'dart:io';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:http/src/utils.dart';

class CustomMultipartFile extends MultipartFile {
  final String filePath;
  CustomMultipartFile(
    field,
    ByteStream stream,
    length, {
      filename,
      required this.filePath,
      contentType,
    }
  ) : super(field, stream, length, filename: filename, contentType: contentType);

  static Future<CustomMultipartFile> fromPath(
    String field,
    String filePath, {
    String? filename,
    required MediaType contentType,
  }) => multipartFileFromPath(
    field,
    filePath, 
    filename: filename,
    contentType: contentType
  );
}

Future<CustomMultipartFile> multipartFileFromPath(
  String field,
  String filePath, {
  String? filename,
  MediaType? contentType,
}) async {
  filename ??= p.basename(filePath);
  var file = File(filePath);
  var length = file.lengthSync();
  var preStream = file.openRead();
  var stream = toByteStream(preStream);
  return CustomMultipartFile(
    field,
    stream,
    length,
    filename: filename,
    contentType: contentType,
    filePath: filePath,
  );
}