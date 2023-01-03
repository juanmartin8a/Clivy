// import 'package:http/http.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';

CustomMultipartFile fromGraphQLUploadToDartCustomMultipartFile(CustomMultipartFile file) => file;
CustomMultipartFile fromDartCustomMultipartFileToGraphQLUpload(CustomMultipartFile file) => file;

CustomMultipartFile? fromGraphQLUploadNullableToDartCustomMultipartFileNullable(CustomMultipartFile? file) => file;
CustomMultipartFile? fromDartCustomMultipartFileNullableToGraphQLUploadNullable(CustomMultipartFile? file) => file;