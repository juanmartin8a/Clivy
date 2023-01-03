import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class UploadPostState extends Equatable {
  const UploadPostState();

  @override
  List<Object?> get props => [];
}

class UploadPostInitState extends UploadPostState {}

class UploadPostUploadingState extends UploadPostState {}

class UploadPostUploadedState extends UploadPostState {
  final CreatePost$Mutation$CreatePostResponse post;

  UploadPostUploadedState({
    required this.post
  });

  @override
  List<Object?> get props => [post];
}

class UploadPostFailedState extends UploadPostState {}