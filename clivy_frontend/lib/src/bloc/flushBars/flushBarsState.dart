import 'package:equatable/equatable.dart';

abstract class FlushBarsState extends Equatable {
  const FlushBarsState();

  @override
  List<Object?> get props => [];
}

class FlushBarsInitState extends FlushBarsState {}

class FlushBarsUploadingPostState extends FlushBarsState {}

class FlushBarsUploadedPostState extends FlushBarsState {}

class FlushBarsUploadPostFailedState extends FlushBarsState {}