import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class SinglePostState extends Equatable {
  const SinglePostState();

  @override
  List<Object?> get props => [];
}

class SinglePostInitState extends SinglePostState {}

class SinglePostReadyState extends SinglePostState {
  final SinglePost$Query singlePost;
  final String uuid;
  SinglePostReadyState({
    required this.singlePost,
    required this.uuid
  });

  @override
  List<Object?> get props => [singlePost, uuid];
}