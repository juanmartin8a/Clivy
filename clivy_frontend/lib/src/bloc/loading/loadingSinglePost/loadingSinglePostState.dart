import 'package:equatable/equatable.dart';

abstract class LoadingSinglePostState extends Equatable {
  const LoadingSinglePostState();

  @override
  List<Object?> get props => [];
}

class LoadingSinglePostInitState extends LoadingSinglePostState {}

class SinglePostLoadingState extends LoadingSinglePostState {
  final String uuid;
  SinglePostLoadingState({
    required this.uuid
  });

  @override
  List<Object?> get props => [uuid];
}

class SinglePostLoadedState extends LoadingSinglePostState {
  final String uuid;
  SinglePostLoadedState({
    required this.uuid
  });

  @override
  List<Object?> get props => [uuid];
}