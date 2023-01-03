import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:untitled_client/src/utils/comments/commentOptions.dart';
import 'package:untitled_client/src/utils/like/likeOptions.dart';
import 'package:untitled_client/src/utils/posts/postOptions.dart';
import 'package:untitled_client/src/utils/posts/postTypes.dart';

class PostRepository {
  final GraphQLClient client;

  PostRepository({
    required this.client
  });

  Future<CreatePost$Mutation$CreatePostResponse> createPost(
    String caption,
    CustomMultipartFile file,
    int fileHeight,
    int fileWidth,
    CustomMultipartFile fileGif,
    CustomMultipartFile fileImg,
    List<UserTagInput> userTagInput,
    int? videogameId,
    List<int> videogameGenreIds
  ) async {
    final result = await client.mutate(
      PostOptions().getCreatePostMutationOptions(
        caption, file, fileHeight, fileWidth, fileGif, fileImg, userTagInput, videogameId, videogameGenreIds
      )
    );
    print('create post result is $result');
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return CreatePost$Mutation$CreatePostResponse.fromJson(
        (result.data as Map<String, dynamic>)["createPost"]
      );
    }
  }

  Future<PostsQueryResponse> posts(
    int limit,
    bool isFetchMore,
    QueryResult? postsQueryResult,
    List<int> idsList
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      result = await client.fetchMore(
        PostOptions().getMorePostQueryRequest(limit, idsList),
        originalOptions: PostOptions().getPostInitQueryRequest(1, []),
        previousResult: postsQueryResult!
      );
    } else {
      result = await client.query(
        PostOptions().getPostInitQueryRequest(limit, [])
      );
    }
    // print('result $result');
    if (result.hasException) {
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      Map<String, dynamic> postsAndQueryResult = {
        "posts": Posts$Query$PaginatedPosts.fromJson(
          (result.data as Map<String, dynamic>)["posts"]
        ),
        "queryResult": result
      };
      return PostsQueryResponse.fromJson(postsAndQueryResult);
    }
  }

  Future<FollowingPostsQueryResponse> followingPosts(
    int limit,
    bool isFetchMore,
    QueryResult? postsQueryResult,
    List<int> idsList
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      result = await client.fetchMore(
        PostOptions().getMoreFollowingPostQueryRequest(limit, idsList),
        originalOptions: PostOptions().getFollowingPostInitQueryRequest(1, []),
        previousResult: postsQueryResult!
      );
    } else {
      result = await client.query(
        PostOptions().getFollowingPostInitQueryRequest(limit, [])
      );
    }
    if (result.hasException) {
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      Map<String, dynamic> postsAndQueryResult = {
        "posts": FollowingPosts$Query$PaginatedPosts.fromJson(
          (result.data as Map<String, dynamic>)["followingPosts"]
        ),
        "queryResult": result
      };
      return FollowingPostsQueryResponse.fromJson(postsAndQueryResult);
    }
  }

  Future<VideogamePostsQueryResponse> videogamePosts(
    int limit,
    bool isFetchMore,
    int videogameId,
    QueryResult? postsQueryResult,
    List<int> idsList,
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      result = await client.fetchMore(
        PostOptions().getMoreVideogamePostQueryRequest(videogameId, limit, idsList),
        originalOptions: PostOptions().getVideogamePostInitQueryRequest(videogameId, 1, []),
        previousResult: postsQueryResult!
      );
    } else {
      result = await client.query(
        PostOptions().getVideogamePostInitQueryRequest(videogameId, limit, [])
      );
    }
    if (result.hasException) {
      // print(result.exception);
      throw (result.exception as OperationException);
    } else {
      Map<String, dynamic> postsAndQueryResult = {
        "posts": VideogamePosts$Query$PaginatedPosts.fromJson(
          (result.data as Map<String, dynamic>)["videogamePosts"]
        ),
        "queryResult": result
      };
      return VideogamePostsQueryResponse.fromJson(postsAndQueryResult);
    }
  }

  // like
  Future<LikeUnlikePost$Mutation$LikeResponse> likePost(
    int postId,
    String clientId
  ) async {
    MutationOptions mutationOptions = LikeOptions().likePostMutationOptions(postId, clientId, client);
    final result = await client.mutate(
      mutationOptions
    ).catchError((err) {
      print('the error is $err');
    });
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return LikeUnlikePost$Mutation$LikeResponse.fromJson(
        (result.data as Map<String, dynamic>)["likeUnlikePost"]
      );
    }
  }

  // views
  Future<ViewClip$Mutation> viewClip(
    int postId,
  ) async {
    MutationOptions mutationOptions = PostOptions().viewClipMutationOptions(postId);
    final result = await client.mutate(
      mutationOptions
    ).catchError((err) {
      print('the error is $err');
    });
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return ViewClip$Mutation.fromJson(
        result.data as Map<String, dynamic>
      );
    }
  }

  // comments
  Future<CommentPost$Mutation$CreateCommentResponse> createComment(
    int postId,
    String comment,
    List<UserTagInput> userTagInput
  ) async {
    final result = await client.mutate(
      CommentOptions().createCommentMutation(postId, comment, userTagInput, client)
    );
    if (result.hasException) {
      print('error detected');
      print(result);
      throw (result.exception as OperationException);
    } else {
      return CommentPost$Mutation$CreateCommentResponse.fromJson(
        (result.data as Map<String, dynamic>)['commentPost']
      );
    }
  }

  Future<CommentsQueryResponse> postComments(
    int postId,
    int limit,
    bool isFetchMore,
    QueryResult? commentsQueryResult,
    List<int> idsList,
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      FetchMoreOptions fetchMoreOptions = CommentOptions().getMoreCommentsQuery(postId, limit, idsList);
      result = await client.fetchMore(
        fetchMoreOptions,
        originalOptions: CommentOptions().getCommentsInitQuery(postId, 2, []),
        previousResult: commentsQueryResult!,
      );
    } else {
      QueryOptions queryOptions = CommentOptions().getCommentsInitQuery(postId, limit, []);
      result = await client.query(
        queryOptions,
      );
    }

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      Map<String, dynamic> commentsAndQueryResult = {
        "comments": Comments$Query$CommentResponse.fromJson(
          (result.data as Map<String, dynamic>)["comments"]
        ),
        "queryResult": result
      };
      return CommentsQueryResponse.fromJson(commentsAndQueryResult);
    }
  }

  //replies
  Future<ReplyComment$Mutation$CreateReplyResponse> createReply(
    int commentId,
    int postId,
    String reply,
    int replyCount,
    List<UserTagInput> userTagInput
  ) async {
    final result = await client.mutate(
      CommentOptions().createReplyMutation(commentId, postId, reply, replyCount, userTagInput, client)
    );
    // print(result);
    if (result.hasException) {
      print('error detected');
      throw (result.exception as OperationException);
    } else {
      return ReplyComment$Mutation$CreateReplyResponse.fromJson(
        (result.data as Map<String, dynamic>)['replyComment']
      );
    }
  }

  Future<RepliesQueryResponse> commentReplies(
    int commentId,
    int postId,
    int limit,
    String? cursor,
    bool isFetchMore,
    QueryResult? repliesQueryResult,
    List<int> idsList
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      FetchMoreOptions fetchMoreOptions = CommentOptions().getMoreRepliesQuery(commentId, postId, limit, cursor, idsList);
      result = await client.fetchMore(
        fetchMoreOptions,
        originalOptions: CommentOptions().getRepliesInitQuery(commentId, postId, 2, null, idsList),
        previousResult: repliesQueryResult!,
      );
    } else {
      QueryOptions queryOptions = CommentOptions().getRepliesInitQuery(commentId, postId, limit, null, idsList);
      result = await client.query(
        queryOptions,
      );
    }

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      Map<String, dynamic> commentsAndQueryResult = {
        "replies": Replies$Query$ReplyResponse.fromJson(
          (result.data as Map<String, dynamic>)["commentReplies"]
        ),
        "queryResult": result
      };
      return RepliesQueryResponse.fromJson(commentsAndQueryResult);
    }
  }

  // user posts 
  Future<UserPostsQueryResponse> userPosts(
    int userId,
    int limit,
    String? cursor,
    bool isFetchMore,
    QueryResult? userPostsQueryResult
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      FetchMoreOptions fetchMoreOptions = PostOptions().getMoreUserPostsQueryRequest(userId, limit, cursor!);
      result = await client.fetchMore(
        fetchMoreOptions,
        originalOptions: PostOptions().getUserPostsQueryRequest(userId, 10, null),
        previousResult: userPostsQueryResult!,
      );
    } else {
      QueryOptions queryOptions = PostOptions().getUserPostsQueryRequest(userId, limit, null);
      result = await client.query(
        queryOptions,
      );
    }

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      Map<String, dynamic> postsAndQueryResult = {
        "userPosts": UserPosts$Query$PaginatedPosts.fromJson(
          (result.data as Map<String, dynamic>)["userPosts"]
        ),
        "queryResult": result
      };
      return UserPostsQueryResponse.fromJson(postsAndQueryResult);
    }
  }

  // comment and reply like
  Future<LikeUnlikeComment$Mutation$LikeResponse> likeComment(
    int commentId,
    String clientId
  ) async {
    MutationOptions mutationOptions = LikeOptions().likeCommentMutationOptions(commentId, clientId, client);
    final result = await client.mutate(
      mutationOptions
    ).catchError((err) {
      print('the error is $err');
    });
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return LikeUnlikeComment$Mutation$LikeResponse.fromJson(
        (result.data as Map<String, dynamic>)["likeUnlikeComment"]
      );
    }
  }

  Future<LikeUnlikeReply$Mutation$LikeResponse> likeReply(
    int replyId,
    String clientId
  ) async {
    MutationOptions mutationOptions = LikeOptions().likeReplyMutationOptions(replyId, clientId, client);
    final result = await client.mutate(
      mutationOptions
    ).catchError((err) {
      print('the error is $err');
    });
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return LikeUnlikeReply$Mutation$LikeResponse.fromJson(
        (result.data as Map<String, dynamic>)["likeUnlikeReply"]
      );
    }
  }

  Future<DeletePost$Mutation> deletePost(
    int postId
  ) async {
    MutationOptions mutationOptions = PostOptions().deletePostMutationOptions(postId);
    final result = await client.mutate(
      mutationOptions
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return DeletePost$Mutation.fromJson(
        result.data!
      );
    }
  }

  Future<DeleteComment$Mutation> deleteComment(
    int commentId,
    bool isReply
  ) async {
    MutationOptions mutationOptions = CommentOptions().deleteCommentMutationOptions(commentId, isReply);
    final result = await client.mutate(
      mutationOptions
    );
    
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return DeleteComment$Mutation.fromJson(
        result.data!
      );
    }
  }

  Future<SinglePost$Query> singlePost(
    int postId
  ) async {
    QueryOptions queryOptions = PostOptions().getSinglePostQueryRequest(postId);
    final result = await client.query(
      queryOptions
    );
    
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SinglePost$Query.fromJson(
        result.data!
      );
    }
  }

}