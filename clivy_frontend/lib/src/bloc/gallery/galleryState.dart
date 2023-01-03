

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object?> get props => [];
}

class GalleryInitState extends GalleryState {}

class GalleryLoadedState extends GalleryState {
  final int page;
  final List<Widget> gallery;
  final bool hasMore;
  GalleryLoadedState({
    required this.page,
    required this.gallery,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [page, gallery, hasMore];
}

class GalleryFileChoosenState extends GalleryState {
  final File file;
  GalleryFileChoosenState({
    required this.file
  });

  @override
  List<Object?> get props => [file];
}

class GalleryFailedState extends GalleryState {}
