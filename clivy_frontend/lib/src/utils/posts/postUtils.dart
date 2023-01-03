import 'package:untitled_client/src/api/graphql/graphql_api.dart';

class PostUtils {

  Future<Posts$Query$PaginatedPosts> getUpdatedPaginatedPostsDeleteAction(
    Posts$Query$PaginatedPosts paginatedPosts,
    int deletePostId,
  ) async {
    final paginatedPostsJson = paginatedPosts.toJson();
    final paginatedPostsList = paginatedPostsJson['posts'];
    await paginatedPostsList.removeWhere((post) => post['id'] == deletePostId);

    paginatedPostsJson["posts"] = paginatedPostsList;
    final newPaginatedPosts = Posts$Query$PaginatedPosts.fromJson(paginatedPostsJson);

    return newPaginatedPosts;
  }

  Future<UserPosts$Query$PaginatedPosts> getUpdatedUserPaginatedPostsDeleteAction(
    UserPosts$Query$PaginatedPosts paginatedPosts,
    int deletePostId,
  ) async {
    final paginatedPostsJson = paginatedPosts.toJson();
    final paginatedPostsList = paginatedPostsJson['posts'];
    await paginatedPostsList.removeWhere((post) => post['id'] == deletePostId);

    paginatedPostsJson["posts"] = paginatedPostsList;
    final newPaginatedPosts = UserPosts$Query$PaginatedPosts.fromJson(paginatedPostsJson);

    return newPaginatedPosts;
  }

  Future<UserPosts$Query$PaginatedPosts> getAddedUserPaginatedPostsDeleteAction(
    UserPosts$Query$PaginatedPosts paginatedPosts,
    // int deletePostId,
    UserPosts$Query$PaginatedPosts$Post post
  ) async {
    final paginatedPostsJson = paginatedPosts.toJson();
    var paginatedPostsList = paginatedPostsJson['posts'];
    paginatedPostsList = [post, ...paginatedPostsList];
    // await paginatedPostsList.removeWhere((post) => post['id'] == deletePostId).toList();

    paginatedPostsJson["posts"] = paginatedPostsList;
    final newPaginatedPosts = UserPosts$Query$PaginatedPosts.fromJson(paginatedPostsJson);

    return newPaginatedPosts;
  }

  // Future<Map<String, dynamic>> getPostChangeAction(
  //   Map<String, dynamic> post,
  //   String changeField,
  //   dynamic changeFieldVal
  // ) async {
  //   final newPost = post;
  //   newPost["$changeField"] = changeFieldVal;

  //   return newPost;
  // }

  // Future<Posts$Query$PaginatedPosts> getUserPaginatedPostsChangeAction(
  //   Posts$Query$PaginatedPosts paginatedPosts,
  //   int changePostId,
  //   String changeField,
  //   dynamic changeFieldVal
  // ) async {
  //   final paginatedPostsJson = paginatedPosts.toJson();
  //   // final paginatedPostsList = paginatedPostsJson['posts'];
  //   final paginatedPostsList = paginatedPostsJson['posts'].indexOf()
  //   .map((post) {
  //     if (post["id"] == changePostId) {
  //       var newPost = post;
  //       newPost["$changeField"] = changeFieldVal;
  //       return newPost;
  //     }
  //     return post;
  //   }).toList();

  //   paginatedPostsJson["posts"] = paginatedPostsList;
  //   final newPaginatedPosts = Posts$Query$PaginatedPosts.fromJson(paginatedPostsJson);

  //   return newPaginatedPosts;
  // }

  // Future<UserPosts$Query$PaginatedPosts> getUserPaginatedUserPostsChangeAction(
  //   UserPosts$Query$PaginatedPosts paginatedPosts,
  //   int changePostId,
  //   String changeField,
  //   dynamic changeFieldVal
  // ) async {
  //   final paginatedPostsJson = paginatedPosts.toJson();
  //   // final paginatedPostsList = paginatedPostsJson['posts'];
  //   final paginatedPostsList = paginatedPostsJson['posts'].map((post) {
  //     if (post["id"] == changePostId) {
  //       var newPost = post;
  //       newPost["$changeField"] = changeFieldVal;
  //       return newPost;
  //     }
  //     return post;
  //   }).toList();

  //   paginatedPostsJson["posts"] = paginatedPostsList;
  //   final newPaginatedPosts = UserPosts$Query$PaginatedPosts.fromJson(paginatedPostsJson);

  //   return newPaginatedPosts;
  // }

  // Future<Posts$Query$PaginatedPosts> getPostsComments(
  //   Posts$Query$PaginatedPosts paginatedPosts,
  //   int postId,
  //   Comments$Query$CommentResponse comment,
  // ) async {
  //   final paginatedPostsJson = paginatedPosts.toJson();
  //   final posts = await paginatedPostsJson['posts'].map((post) {
  //     Map<String, dynamic>? newPost = {};
  //     if (post['id'] == postId) {
  //       newPost = post;
  //       newPost?['comments'] = comment.comments;

  //     }
  //     return post['id'] == postId 
  //     ? newPost
  //     : post ;
  //   }).toList();

  //   paginatedPostsJson["posts"] = posts;
  //   final newPaginatedPosts = Posts$Query$PaginatedPosts.fromJson(paginatedPostsJson);

  //   return newPaginatedPosts;
  // }

  

}