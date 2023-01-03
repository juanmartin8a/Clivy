import 'package:equatable/equatable.dart';

abstract class ImgSizeState extends Equatable {
  const ImgSizeState();

  @override
  List<Object?> get props => [];
}

class ImgSizeInitState extends ImgSizeState {}

class NewImgSizeState extends ImgSizeState {
  final double newImgSize;
  final String id;
  final String uniqueId;
  NewImgSizeState({
    required this.newImgSize,
    required this.id,
    required this.uniqueId,
  });

  @override
  List<Object?> get props => [newImgSize, id, uniqueId];
}