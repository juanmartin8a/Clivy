import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserPosts/loadingUserPostsCubit.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsEvent.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsState.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';
import 'package:untitled_client/src/utils/posts/postTypes.dart';
import 'package:untitled_client/src/utils/posts/postUtils.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {
  final PostRepository postRepo;
  final LoadingUserPostsCubit loadingBloc; 
  UserPostsBloc({
    required this.postRepo,
    required this.loadingBloc
  }) : super(UserPostsInitState());

  @override
  Stream<UserPostsState> mapEventToState(UserPostsEvent event) async * {
    if (event is FetchUserPostsEvent) {
      try {
        loadingBloc.loader(true, event.id);
        UserPostsQueryResponse? response;
        if (event.isFetchMore) {
          response = await postRepo.userPosts(
            event.userId,
            event.limit,
            event.cursor,
            event.isFetchMore,
            event.queryResult
          );
        } else {
          response = await postRepo.userPosts(
            event.userId,
            event.limit,
            event.cursor,
            event.isFetchMore,
            null
          );
        }
        loadingBloc.loader(false, event.id);
        yield UserPostsLoadedState(
          id: event.id,
          userPosts: response.userPosts,
          queryResult: response.queryResult,
          isMore: event.isFetchMore
        );
      } catch (err) {
        // print('sapo $err');
        loadingBloc.loader(false, event.id);
        yield UserPostsErrorState();
      }
    } else if (event is DeletePostEvent) {
      yield* _mapDeletePostEventToState(event);
    } else if (event is ChangePostEvent) {
      yield* _mapChangePostEventToState(event);
    } else if (event is AddPostEvent) {
      yield* _mapAddPostEventToState(event);
    }
  }

  Stream<UserPostsState> _mapDeletePostEventToState(DeletePostEvent event) async* {
    final deleteResponse = await PostUtils().getUpdatedUserPaginatedPostsDeleteAction(
      event.posts,
      event.deletedPostId,
    );
    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, deleteResponse.toJson(), event.missingKey
    );
    yield UserPostsLoadedState(
      id: event.uuid,
      userPosts: deleteResponse,//(response as FollowingPostsQueryResponse).posts,
      queryResult: newQueryResult,
      isMore: event.isFetchMore
    ); 
  }

  Stream<UserPostsState> _mapChangePostEventToState(ChangePostEvent event) async* {

    Map<String, dynamic> posts = event.posts.toJson();

    int index = (posts["posts"] as List).indexWhere((post) => post["id"].toInt() == event.changePostId);

    for (int i = 0; i < event.changeMap.length; i++) {
      posts['posts'][index][event.changeMap.keys.toList()[i]] = event.changeMap.values.toList()[i];
    }

    final changedPosts = UserPosts$Query$PaginatedPosts.fromJson(posts);
    
    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, changedPosts.toJson(), event.missingKey // changeResponse.toJson()
    );

    yield UserPostsLoadedState(
      id: event.uuid,
      userPosts: changedPosts, // (response as FollowingPostsQueryResponse).posts,
      queryResult: newQueryResult,
      isMore: event.isFetchMore
    );
  }

  Stream<UserPostsState> _mapAddPostEventToState(AddPostEvent event) async* {
    final deleteResponse = await PostUtils().getAddedUserPaginatedPostsDeleteAction(
      event.posts,
      event.post
      // event.deletedPostId,
    );
    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, deleteResponse.toJson(), event.missingKey
    );
    yield UserPostsLoadedState(
      id: event.uuid,
      userPosts: deleteResponse,//(response as FollowingPostsQueryResponse).posts,
      queryResult: newQueryResult,
      isMore: event.isFetchMore
    ); 
  }
  
}