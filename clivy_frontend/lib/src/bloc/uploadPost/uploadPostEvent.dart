import 'dart:io';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class UploadPostEvent extends Equatable {
  const UploadPostEvent();

  @override
  List<Object?> get props => [];
}

class UploadPostInitEvent extends UploadPostEvent {}

class UploadPostSubmitEvent extends UploadPostEvent {
  final String caption;
  final File file;
  final int fileWidth;
  final int fileHeight;

  final double startValue;
  final double endValue;

  final Map<String, dynamic> userTagInput;

  final int? videogameId;
  final List<int> genreList;

  UploadPostSubmitEvent({
    required this.caption,
    required this.file,
    required this.fileWidth,
    required this.fileHeight,

    required this.startValue,
    required this.endValue,

    required this.userTagInput,

    this.videogameId,
    required this.genreList
  });

  @override
  List<Object?> get props => [
    caption, file, fileHeight, fileWidth, startValue, endValue, userTagInput, videogameId, genreList
  ];
}