import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/flushBars/flushBarsCubit.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostEvent.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostState.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:untitled_client/src/ui/wrapper.dart';
import 'package:untitled_client/src/utils/comments/commentUtils.dart';
import 'package:untitled_client/src/utils/uploadPost/uploadPostUtils.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  final FlushBarsCubit flushBarsCubit;
  final PostRepository postRepo;
  
  UploadPostBloc({
    required this.postRepo,
    required this.flushBarsCubit
  }) : super(UploadPostInitState());

  @override
  Stream<UploadPostState> mapEventToState(UploadPostEvent event) async* {
    if (event is UploadPostSubmitEvent) {
      print("sapotoro12345");
      Get.offAll(Wrapper());
      yield UploadPostUploadingState();
      flushBarsCubit.uploadingPostFlushBar();
      try {
        final taggedUsersList = await CommentUtils().getUserTagInputList(event.userTagInput);
        print("sapo 1");
        final customMultipartFile = await UploadPostUtils().getMultipartFile(
          event.file, event.startValue, event.endValue, event.fileHeight, event.fileWidth
        );
        print("sapo 2");
        final customMultipartFileGif = await UploadPostUtils().getMultipartFileGif(
          File(customMultipartFile.filePath), event.endValue
        );
        print("sapo 3");
        final customMultipartFileImg = await UploadPostUtils().getMultipartFileImg(
          File(customMultipartFile.filePath)
        );
        print("sapo 4");
        final post = await postRepo.createPost(
          event.caption,
          customMultipartFile,
          event.fileHeight,
          event.fileWidth,
          customMultipartFileGif,
          customMultipartFileImg,
          taggedUsersList,
          event.videogameId,
          event.genreList
        );
        print("sapo 5");
        if (post.error != null) {
          print('error in post creation');
          yield UploadPostFailedState();
          flushBarsCubit.uploadPostFailedFlushBar();
        } else {
          print('success in post creation');
          yield UploadPostUploadedState(
            post: post
          );
          flushBarsCubit.uploadedPostFlushBar();
        }
      } catch(err) {
        print(err);
        print('post upload failed');
        yield UploadPostFailedState();
        flushBarsCubit.uploadPostFailedFlushBar();
      }
    }
  }
  
}