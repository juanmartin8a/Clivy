import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';

class PostOptions {

  CreatePostMutation getCreatePostMutation(
    String caption,
    CustomMultipartFile file,
    int fileHeight,
    int fileWidth,
    CustomMultipartFile fileGif,
    CustomMultipartFile fileImg,
    List<UserTagInput> userTagInput,
    int? videogameId,
    List<int> videogameGenreIds
  ) {
    CreatePostMutation createPost = CreatePostMutation(
      variables: CreatePostArguments(
        file: file,
        caption: caption,
        fileDims: FileDimsInput(
          fileHeight: fileHeight,
          fileWidth: fileWidth
        ),
        fileGif: fileGif,
        fileImg: fileImg,
        userTagsInput: userTagInput,
        videogameId: videogameId,
        videogameGenreIds: videogameGenreIds
      )
    );
    return createPost;
  }

  MutationOptions getCreatePostMutationOptions(
    String caption,
    CustomMultipartFile file,
    int fileHeight,
    int fileWidth,
    CustomMultipartFile fileGif,
    CustomMultipartFile fileImg,
    List<UserTagInput> userTagInput,
    int? videogameId,
    List<int> videogameGenreIds
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: getCreatePostMutation(
        caption, 
        file, 
        fileHeight, 
        fileWidth, 
        fileGif, 
        fileImg,
        userTagInput,
        videogameId,
        videogameGenreIds
      ).document,
      variables: {
        "caption": caption,
        "file": file,
        "fileDims": {
          "fileHeight": fileHeight,
          "fileWidth": fileWidth
        },
        "fileGif": fileGif,
        "fileImg": fileImg,
        "userTagsInput": userTagInput,
        "videogameId": videogameId,
        "videogameGenreIds": videogameGenreIds
      }
    );
    return mutationOptions;
  }

  PostsQuery getPostsQueryDocumentNode(int limit, List<int> idsList) {
    PostsQuery postsQuery = PostsQuery(
      variables: PostsArguments(
        limit: limit,
        idsList: idsList,
      )
    );

    return postsQuery;
  }

  FollowingPostsQuery getFollowingPostsQueryDocumentNode(int limit, List<int> idsList) {
    FollowingPostsQuery postsQuery = FollowingPostsQuery(
      variables: FollowingPostsArguments(
        limit: limit,
        idsList: idsList
      )
    );

    return postsQuery;
  }

  VideogamePostsQuery getVideogamePostsQueryDocumentNode(int videogameId, int limit, List<int> idsList) {
    VideogamePostsQuery postsQuery = VideogamePostsQuery(
      variables: VideogamePostsArguments(
        videogameId: videogameId,
        limit: limit,
        idsList: idsList
      )
    );

    return postsQuery;
  }

  FragmentRequest getPostFragmentRequest(int postId) {
    final postFragment = gql('''
      fragment _ on Post {
        id,
        likeState,
        likeCount
      }
    ''');

    FragmentRequest fragmentRequest = Fragment(
      document: postFragment
    ).asRequest(
      idFields: { '__typename': 'Post', 'id': '$postId' },
    );

    return fragmentRequest;
  }

  QueryOptions getPostInitQueryRequest(int limit, List<int> idsList) {
    final queryOptions = QueryOptions(
      document: getPostsQueryDocumentNode(limit, idsList).document,
      variables: {
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.cacheAndNetwork
    );

    return queryOptions;
  }

  QueryOptions getFollowingPostInitQueryRequest(int limit, List<int> idsList) {
    final queryOptions = QueryOptions(
      document: getFollowingPostsQueryDocumentNode(limit, idsList).document,
      variables: {
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  QueryOptions getVideogamePostInitQueryRequest(int videogameId, int limit, List<int> idsList) {
    final queryOptions = QueryOptions(
      document: getVideogamePostsQueryDocumentNode(videogameId, limit, idsList).document,
      variables: {
        "limit": limit,
        "videogameId": videogameId,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.cacheAndNetwork
    );

    return queryOptions;
  }

  FetchMoreOptions getMorePostQueryRequest(
    int limit, 
    List<int> idsList
  ) {
    FetchMoreOptions queryOptions = FetchMoreOptions(
      document: getPostsQueryDocumentNode(limit, idsList).document,
      updateQuery: (prevData, newData) {
        final List<dynamic> repos = [
          ...prevData!['posts']['posts'] as List<dynamic>,
          ...newData!['posts']['posts'] as List<dynamic>
        ];

        newData['posts']['posts'] = repos;

        return newData;
      },
      variables: {
        'limit': limit,
        "idsList": idsList
      },
    );

    return queryOptions;
  }

  FetchMoreOptions getMoreFollowingPostQueryRequest(
    int limit, 
    List<int> idsList
  ) {
    FetchMoreOptions queryOptions = FetchMoreOptions(
      document: getFollowingPostsQueryDocumentNode(limit, idsList).document,
      updateQuery: (prevData, newData) {
        final List<dynamic> repos = [
          ...prevData!['followingPosts']['posts'] as List<dynamic>,
          ...newData!['followingPosts']['posts'] as List<dynamic>
        ];

        newData['followingPosts']['posts'] = repos;

        return newData;
      },
      variables: {
        'limit': limit,
        "idsList": idsList
      },
    );

    return queryOptions;
  }

  FetchMoreOptions getMoreVideogamePostQueryRequest(
    int videogameId,
    int limit,
    List<int> idsList
  ) {
    FetchMoreOptions queryOptions = FetchMoreOptions(
      document: getVideogamePostsQueryDocumentNode(videogameId, limit, idsList).document,
      updateQuery: (prevData, newData) {
        final List<dynamic> repos = [
          ...prevData!['videogamePosts']['posts'] as List<dynamic>,
          ...newData!['videogamePosts']['posts'] as List<dynamic>
        ];

        newData['videogamePosts']['posts'] = repos;

        return newData;
      },
      variables: {
        'videogameId': videogameId,
        'limit': limit,
        "idsList": idsList
      },
    );

    return queryOptions;
  }

  // user posts
  UserPostsQuery getUserPostsQueryDocument(int userId, int limit, String? cursor) {
    UserPostsQuery usersPostsQuery = UserPostsQuery(
      variables: UserPostsArguments(
        userId: userId,
        limit: limit,
        cursor: cursor
      )
    );

    return usersPostsQuery;
  }

  QueryOptions getUserPostsQueryRequest(int userId, int limit, String? cursor) {
    final queryOptions = QueryOptions(
      document: getUserPostsQueryDocument(userId, limit, cursor).document,
      variables: {
        "userId": userId,
        "limit": limit,
        "cursor": cursor
      },
      fetchPolicy: FetchPolicy.cacheAndNetwork
    );

    return queryOptions;
  }

  FetchMoreOptions getMoreUserPostsQueryRequest(
    int userId,
    int limit, 
    String cursor
  ) {
    FetchMoreOptions queryOptions = FetchMoreOptions(
      document: getUserPostsQueryDocument(userId, limit, cursor).document,
      updateQuery: (prevData, newData) {
         final List<dynamic> repos = [
          ...prevData!['userPosts']['posts'] as List<dynamic>,
          ...newData!['userPosts']['posts'] as List<dynamic>
        ];

        newData['userPosts']['posts'] = repos;

        return newData;
      },
      variables: {
        'userId': userId,
        'limit': limit,
        'cursor': cursor
      },
    );

    return queryOptions;
  }

  ViewClipMutation viewClipMutation(int postId) {
    ViewClipMutation viewClipMutation = ViewClipMutation(
      variables: ViewClipArguments(postId: postId)
    );

    return viewClipMutation;
  }

  MutationOptions viewClipMutationOptions(int postId) {
    final mutationOptions = MutationOptions(
      document: viewClipMutation(postId).document,
      variables: {
        "postId": postId,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  // delete post

  DeletePostMutation deletePostMutation(int postId) {
    DeletePostMutation deletePostMutation = DeletePostMutation(
      variables: DeletePostArguments(postId: postId)
    );

    return deletePostMutation;
  }

  MutationOptions deletePostMutationOptions(int postId) {
    final mutationOptions = MutationOptions(
      document: deletePostMutation(postId).document,
      variables: {
        "postId": postId,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

   QueryOptions getSinglePostQueryRequest(int postId) {
    final queryOptions = QueryOptions(
      document: SinglePostQuery(
        variables: SinglePostArguments(
          id: postId
        )
      ).document,
      variables: {
        "id": postId,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }
}