import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/loading/loadingSinglePost/loadingSinglePostCubit.dart';
import 'package:untitled_client/src/bloc/singlePost/singlePostState.dart';
import 'package:untitled_client/src/repos/postRepository.dart';

class SinglePostCubit extends Cubit<SinglePostState> {
  final PostRepository postRepo;
  final LoadingSinglePostCubit loadingCubit;
  SinglePostCubit({
    required this.postRepo,
    required this.loadingCubit,
  }) : super(SinglePostInitState());

  void getSinglePost(int postId, String uuid) async {
    loadingCubit.loader(true, uuid);
    try {
      final post = await postRepo.singlePost(postId);
      loadingCubit.loader(false, uuid);
      emit(SinglePostReadyState(
        singlePost: post,
        uuid: uuid,
      ));
    } catch(e) {
      loadingCubit.loader(false, uuid);
    }
  }

  void changeSinglePost(
    SinglePost$Query post,
    String uuid,
    int changePostId,
    Map<String, dynamic> changeMap
  ) async {

    Map<String, dynamic> postJson = post.toJson();

    if (post.singlePost?.id.toInt() == changePostId) {
      for (int i = 0; i < changeMap.length; i++) {
        postJson[changeMap.keys.toList()[i]] = changeMap.values.toList()[i];
      } 
    }

    final changedPosts = SinglePost$Query.fromJson(postJson);

    emit(SinglePostReadyState(
      singlePost: changedPosts,
      uuid: uuid,
    ));
  }

}