import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/loading/loadingBloc.dart';
import 'package:untitled_client/src/bloc/posts/postsEvent.dart';
import 'package:untitled_client/src/bloc/posts/postsState.dart';
import 'package:untitled_client/src/bloc/queryVideogameCubit/queryVideogameCubit.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';
import 'package:untitled_client/src/utils/posts/postTypes.dart';
import 'package:untitled_client/src/utils/posts/postUtils.dart';
import 'package:uuid/uuid.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepo;
  final FetchPostsLoadingCubit loadingBloc;
  final QueryVideogameCubit queryVideogameCubit;
  PostsBloc({
    required this.postRepo,
    required this.loadingBloc,
    required this.queryVideogameCubit,
  }) : super(PostsInitState());


  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is FetchMoreEvent) {
      yield* _mapMorePostEventToState(event);
    } else if (event is FetchMoreVideogamePostsEvent) {
      yield* _mapMoreVideogamePostsEventToState(event);
    } else if (event is DeletePostEvent) {
      yield* _mapDeletePostEventToState(event);
    } else if (event is ChangePostEvent) {
      yield* _mapChangePostEventToState(event);
    }
  }

  Stream<PostsState> _mapMorePostEventToState(FetchMoreEvent event) async* {
    if (state is PostsInitState || state is PostsLoadedState || state is FollowingPostsLoadedState) {
      loadingBloc.loader(true, event.id);
      try {
        var response;
        if (event.isFollowing) {
          List<FollowingPosts$Query$PaginatedPosts$Post> postQueryPrevPosts = 
            event.queryResult != null ? FollowingPosts$Query$PaginatedPosts.fromJson(
              (event.queryResult!.data as Map<String, dynamic>)["followingPosts"]
            ).posts : [];
          List<int> idsList = postQueryPrevPosts
            .map((p) => p.id.toInt()).toList();
          // print(event.queryResult);
          bool newIsFetchmore = idsList.length < 150 ? event.isFetchMore : false;
          QueryResult? newQueryResult = idsList.length < 150 ? event.queryResult : null;
          idsList = idsList.length < 150 ? idsList : [];
          response = await postRepo.followingPosts(
            event.limit, 
            newIsFetchmore, //event.isFetchMore,
            newQueryResult, //event.queryResult,
            idsList
          );
        } else {
          List<Posts$Query$PaginatedPosts$Post> postQueryPrevPosts = 
            event.queryResult != null ? Posts$Query$PaginatedPosts.fromJson(
              (event.queryResult!.data as Map<String, dynamic>)["posts"]
            ).posts : [];
          List<int> idsList = postQueryPrevPosts
            .map((p) => p.id.toInt()).toList();
          // print(event.queryResult);
          bool newIsFetchmore = idsList.length < 150 ? event.isFetchMore : false;
          QueryResult? newQueryResult = idsList.length < 150 ? event.queryResult : null;
          idsList = idsList.length < 150 ? idsList : [];
          response = await postRepo.posts(
            event.limit,
            newIsFetchmore,//event.isFetchMore,
            newQueryResult, //event.queryResult,
            idsList
          );
        }
        loadingBloc.loader(false, event.id);
        if (event.isFollowing) {
          yield FollowingPostsLoadedState(
            posts: (response as FollowingPostsQueryResponse).posts,
            queryResult: response.queryResult,
            isMore: event.isFetchMore,
            isFirstFetch: event.isFetchMore ? false : true
          );
        } else {
          yield PostsLoadedState(
            posts: (response as PostsQueryResponse).posts,
            queryResult: response.queryResult,
            isMore: event.isFetchMore,
            isFirstFetch: event.isFetchMore ? false : true
          );
        }
      } catch(err) {
        print(err);
        loadingBloc.loader(false, event.id);
        yield PostsErrorState();
      }
    }
  }

  Stream<PostsState> _mapMoreVideogamePostsEventToState(FetchMoreVideogamePostsEvent event) async* {
    loadingBloc.loader(true, event.id);
    try {
      // VideogamePosts$Query$PaginatedPosts tempPosts = VideogamePosts$Query$PaginatedPosts.fromJson({
      //   "posts": [],
      //   "hasMore": false
      // });
      // QueryResult tempQueryResult = GlobalUtils().generateQueryResult(
      //   QueryResultSource.network, tempPosts.toJson(), 'videogamePosts'
      // );
      // yield VideogameChangedPostsState(
      //   posts: tempPosts,
      //   queryResult: tempQueryResult,
      //   videogameId: event.videogameId,
      //   uuid: Uuid().v4()
      // );
      queryVideogameCubit.selectQueryVideogame(event.videogameId, event.videogameName);
      var response;
      // if (event.isFetchMore) {
      List<VideogamePosts$Query$PaginatedPosts$Post> postQueryPrevPosts = 
        event.queryResult != null ? VideogamePosts$Query$PaginatedPosts.fromJson(
          (event.queryResult!.data as Map<String, dynamic>)["videogamePosts"]
        ).posts : [];
      List<int> idsList = postQueryPrevPosts
        .map((p) => p.id.toInt()).toList();
      // print(event.queryResult);
      bool newIsFetchmore = idsList.length < 150 ? event.isFetchMore : false;
      QueryResult? newQueryResult = idsList.length < 150 ? event.queryResult : null;
      idsList = idsList.length < 150 ? idsList : [];
      response = await postRepo.videogamePosts(
        event.limit,
        newIsFetchmore, //event.isFetchMore,
        event.videogameId,
        newQueryResult, //event.queryResult
        idsList
      );
      // } 
      // else {
        // response = await postRepo.videogamePosts(
        //   event.limit,
        //   event.cursor,
        //   event.isFetchMore,
        //   event.videogameId,
        //   null
        // );
      // }
      loadingBloc.loader(false, event.id);
      yield PostsLoadedState(
        posts: (response as VideogamePostsQueryResponse).posts,
        queryResult: response.queryResult,
        videogameId: event.videogameId,
        videogameName: event.videogameName,
        isMore: event.isFetchMore
      );
      queryVideogameCubit.selectQueryVideogame(event.videogameId, event.videogameName);
    } catch(err) {
      loadingBloc.loader(false, event.id);
      print(err);
      yield PostsErrorState();
    }
  }

  // Stream<PostsState> _mapMoreFollowingPostsEventToState(LikePostEvent event) async* {

  Stream<PostsState> _mapDeletePostEventToState(DeletePostEvent event) async* {
    final deleteResponse = await PostUtils().getUpdatedPaginatedPostsDeleteAction(
      Posts$Query$PaginatedPosts.fromJson(event.posts.toJson()),
      event.deletedPostId,
    );

    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, deleteResponse.toJson(), event.missingKey
    );

    if (event.isFollowing) {
      yield FollowingPostsLoadedState(
        posts: FollowingPosts$Query$PaginatedPosts.fromJson(deleteResponse.toJson()),//(response as FollowingPostsQueryResponse).posts,
        queryResult: newQueryResult,
        isMore: event.isFetchMore
      );
    } else {
      yield PostsLoadedState(
        posts: deleteResponse as dynamic,
        queryResult: newQueryResult,
        videogameId: event.videogameId,
        videogameName: event.videogameName,
        isMore: event.isFetchMore
      );
    }
  }

  Stream<PostsState> _mapChangePostEventToState(ChangePostEvent event) async* {

    Map<String, dynamic> posts = event.posts.toJson();

    int index = (posts["posts"] as List).indexWhere((post) => post["id"].toInt() == event.changePostId);

    for (int i = 0; i < event.changeMap.length; i++) {
      posts['posts'][index][event.changeMap.keys.toList()[i]] = event.changeMap.values.toList()[i];
    }

    final changedPosts = Posts$Query$PaginatedPosts.fromJson(posts);
    
    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, changedPosts.toJson(), event.missingKey // changeResponse.toJson()
    );

    if (event.isFollowing) {
      yield FollowingPostsLoadedState(
        posts: FollowingPosts$Query$PaginatedPosts.fromJson(changedPosts.toJson()),//(response as FollowingPostsQueryResponse).posts,
        queryResult: newQueryResult,
        isMore: event.isFetchMore
      );
    } else {
      yield PostsLoadedState(
        posts: changedPosts as dynamic,
        queryResult: newQueryResult,
        videogameId: event.videogameId,
        videogameName: event.videogameName,
        isMore: event.isFetchMore
      );
    }
  }
}