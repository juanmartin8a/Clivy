import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/bloc/postsHelperBloc/postsHelperState.dart';

class PostsHelperCubit extends Cubit<PostsHelperState> {
  PostsHelperCubit() : super(PostsHelperInitState());

  void posts(
    String uuid,
    dynamic newPosts,
    QueryResult newQueryResult,
    bool newIsFollowing
  ) {
    emit(PostsHelperPostsState(
      uuid: uuid,
      newPosts: newPosts,
      newQueryResult: newQueryResult,
      newIsFollowing: newIsFollowing
    ));
  }

}