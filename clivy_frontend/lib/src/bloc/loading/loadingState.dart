import 'package:equatable/equatable.dart';

abstract class MorePostsLoadingState extends Equatable {
  const MorePostsLoadingState();

  @override
  List<Object?> get props => [];
}

class MorePostsLoadingInitState extends MorePostsLoadingState {}

class LoadingMorePostsState extends MorePostsLoadingState {
  final String id;
  LoadingMorePostsState({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class MorePostsLoadedState extends MorePostsLoadingState {
  final String id;
  MorePostsLoadedState({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}