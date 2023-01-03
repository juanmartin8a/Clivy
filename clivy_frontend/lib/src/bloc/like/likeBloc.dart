import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/like/likeState.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:uuid/uuid.dart';

class LikeCubit extends Cubit<LikeState> {
  final PostRepository postRepo;
  LikeCubit({
    required this.postRepo
  }) : super(LikeInitState());

  void likeUnlikePost({
    required int postId, 
    required bool isLike
  }) async {
    try {
      String newClientId = Uuid().v4();
      if (!isLike) {
        emit(LikePostState(
          postId: postId,
          isPre: true,
          clientId: newClientId
        ));
      } else if (isLike) {
        emit(UnlikePostState(
          postId: postId,
          isPre: true,
          clientId: newClientId
        ));
      }
      final likeVal = await postRepo.likePost(postId, newClientId);
      if (likeVal.value == 1) {
        emit(LikePostState(
          postId: postId,
          clientId: likeVal.clientId!
        ));
      } else if (likeVal.value == -1) {
        emit(UnlikePostState(
          postId: postId,
          clientId: likeVal.clientId!
        ));
      }
    } catch(err) {
      print(err);
      // if (isLike) {
      //   emit(LikePostState(
      //     postId: postId,
      //   ));
      // } else if (!isLike) {
      //   emit(UnlikePostState(
      //     postId: postId,
      //   ));
      // }
    }
  }
}