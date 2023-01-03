import 'package:equatable/equatable.dart';

class MoreUserPostsLoadingState extends Equatable {
  const MoreUserPostsLoadingState();

  @override
  List<Object?> get props => [];
}

class MoreUserPostsLoadingInitState extends MoreUserPostsLoadingState {}

class LoadingMoreUserPostsState extends MoreUserPostsLoadingState {
  final String id;
  LoadingMoreUserPostsState({
    required this.id
  });

  @override
  List<Object?> get props => [id];
}

class MoreUserPostsLoadedState extends MoreUserPostsLoadingState {
  final String id;
  MoreUserPostsLoadedState({
    required this.id
  });

  @override
  List<Object?> get props => [id];
}