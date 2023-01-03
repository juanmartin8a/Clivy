import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

class GalleryInitEvent extends GalleryEvent {}

class FetchFromGallery extends GalleryEvent {
  final int page;
  final List<Widget> widgetList;
  FetchFromGallery({
    required this.page,
    required this.widgetList
  });

  @override
  List<Object?> get props => [widgetList, page];
}

class GalleryFileChoosenEvent extends GalleryEvent {
  final File file;
  GalleryFileChoosenEvent({
    required this.file
  });

  @override
  List<Object?> get props => [file];
}

class GalleryOnChangeEvent extends GalleryEvent {
  final int page;
  final List<Widget> widgetList;
  final bool hasMore;
  GalleryOnChangeEvent({
    required this.page,
    required this.widgetList,
    required this.hasMore
  });

  @override
  List<Object?> get props => [page, widgetList, hasMore];
}