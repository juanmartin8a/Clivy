import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';
import 'dart:math';

class CommentUtils {

  Future<Comments$Query$CommentResponse> getUpdatedPaginatedCommentsDeleteAction(
    Comments$Query$CommentResponse paginatedComments,
    int deleteCommentId,
  ) async {
    final paginatedCommentsJson = paginatedComments.toJson();
    final paginatedCommentsList = paginatedCommentsJson['comments'];
    await paginatedCommentsList.removeWhere((comment) => comment['id'] == deleteCommentId);

    paginatedCommentsJson["comments"] = paginatedCommentsList;
    final newPaginatedComments = Comments$Query$CommentResponse.fromJson(paginatedCommentsJson);

    return newPaginatedComments;
  }

  Future<Replies$Query$ReplyResponse> getUpdatedPaginatedRepliesDeleteAction(
    Replies$Query$ReplyResponse paginatedReplies,
    int deleteReplyId,
  ) async {
    final paginatedRepliesJson = paginatedReplies.toJson();
    final paginatedRepliesList = paginatedRepliesJson['replies'];
    await paginatedRepliesList.removeWhere((reply) => reply['id'] == deleteReplyId);

    paginatedRepliesJson["replies"] = paginatedRepliesList;
    final newPaginatedReplies = Replies$Query$ReplyResponse.fromJson(paginatedRepliesJson);

    return newPaginatedReplies;
  }

  Future<Comments$Query$CommentResponse> getUpdatedPostComments(
    Comments$Query$CommentResponse? commentsResponse,
    int postId,
    Map<String, dynamic> newComment,
  ) async {
    Map<String, dynamic> response = {};
    if (commentsResponse == null) {
      response["hasMore"] = false;
      response["postId"] = postId;
      response["comments"] = [newComment];
    } else {
      final commentsJson = commentsResponse.toJson();
      commentsJson['comments'] = [newComment, ...commentsJson['comments']];
      response = commentsJson;
    }

    final newComments = Comments$Query$CommentResponse.fromJson(response);

    return newComments;
  }

  Future<List<UserTagInput>> getUserTagInputList(Map<String, dynamic> userTagInput) async {
    List<UserTagInput> userTagInputList = [];

    userTagInput.forEach((key, value) {
      Map<String, dynamic> userTag = {};
      userTag["userId"] = int.parse(key);
      userTag["userString"] = value;

      // userTagInputMap = {...userTagInputMap, ...userTag};
      UserTagInput userTagInput = UserTagInput.fromJson(userTag);
      userTagInputList.add(userTagInput);
    });

    return userTagInputList;
  }

  Future<Comments$Query$CommentResponse$Comment>  makeCommentResponseFromComment(
    int postId,
    String comment,
    Map<String, dynamic> userTagInput
  ) async {
    Random random = Random();

    // HiveStore hiveStore = await HiveStore.open();
    Map<String, dynamic> user = CurrentUser.user!.toJson(); //await UserCache(hiveStore: hiveStore).meCache();
    Map<String, dynamic> response = {};

    // List<UserTagInput> taggedUsersList = await getUserTagInputMap(userTagInput);

    response["id"] = random.nextInt(9999) * -1;
    response["comment"] = comment;
    // response["userTags"] = userTagInput;
    response["user_id"] = user["id"];
    response["post_id"] = postId;
    response["createdAt"] = DateTime.now().millisecondsSinceEpoch.toString();
    response["replyCount"] = 0;
    response["likeCount"] = 0;
    response["likeState"] = false;

    Map<String, dynamic> newUser = {};
    newUser["id"] = user["id"];
    newUser["username"] = user["username"];
    newUser["smallFile"] = Map<String, dynamic>.from(user["smallFile"]);

    response["user"] = newUser;

    List userTagList = [];
    userTagInput.forEach((key, value) {
      Map<String, dynamic> userTag = {};
      userTag["id"] = random.nextInt(9999) * -1;
      userTag["comment_id"] = response["id"];
      userTag["user_id"] = int.parse(key);
      userTag["user_string"] = value;
      userTagList.add(userTag);
    });

    response["userTags"] = userTagList;
    print(response);

    final newComment = Comments$Query$CommentResponse$Comment.fromJson(response);

    return newComment;
  }

  // Future<Comments$Query$CommentResponse> getUpdatedPostCommentsReplies(
  //   Comments$Query$CommentResponse commentsResponse,
  //   int commentId
  // ) async {
  //   final commentsJson = commentsResponse.toJson();
  //   final comments = await commentsJson['comments'].map((comment) {
  //     Map<String, dynamic>? newComment = {};
  //     if (comment['id'] == commentId) {
  //       newComment = comment;
  //       newComment?['replyCount'] = newComment['replyCount'] + 1;
  //     }
  //     return comment['id'] == commentId
  //     ? newComment
  //     : comment ;
  //   }).toList();

  //   commentsJson["comments"] = comments;
  //   final newComments = Comments$Query$CommentResponse.fromJson(commentsJson);

  //   return newComments;
  // }

  // replies
   Future<Replies$Query$ReplyResponse> getUpdatedCommentReplies(
    Replies$Query$ReplyResponse? repliesResponse,
    int commentId,
    int postId,
    Map<String, dynamic> newReply,
    int replyCount
  ) async {
    Map<String, dynamic> response = {};
    if (repliesResponse == null) {
      response["hasMore"] = replyCount > 0 ? true : false;
      response["commentId"] = commentId;
      response["postId"] = postId;
      response["replies"] = [newReply];
    } else {
      final repliesJson = repliesResponse.toJson();
      repliesJson['replies'] = [...repliesJson['replies'], newReply];
      response = repliesJson;
    }

    final newReplies = Replies$Query$ReplyResponse.fromJson(response);

    return newReplies;
  }

  Future<List<UserTagInput>> getReplyUserTagInputList(Map<String, dynamic> userTagInput) async {
    List<UserTagInput> userTagInputList = [];

    userTagInput.forEach((key, value) {
      Map<String, dynamic> userTag = {};
      userTag["userId"] = int.parse(key);
      userTag["userString"] = value;

      // userTagInputMap = {...userTagInputMap, ...userTag};
      UserTagInput userTagInput = UserTagInput.fromJson(userTag);
      userTagInputList.add(userTagInput);
    });

    return userTagInputList;
  }

  Future<Replies$Query$ReplyResponse$Reply> makeRepliesResponseFromReply(
    int commentId,
    int postId,
    String reply,
    Map<String, dynamic> userTagInput
  ) async {
    Random random = Random();

    // HiveStore hiveStore = await HiveStore.open();
    Map<String, dynamic> user = CurrentUser.user!.toJson();//await UserCache(hiveStore: hiveStore).meCache();
    Map<String, dynamic> response = {};
    response["id"] = random.nextInt(9999) * -1;
    response["reply"] = reply;
    response["user_id"] = user["id"];
    response["comment_id"] = commentId;
    response["post_id"] = postId;
    response["createdAt"] = DateTime.now().millisecondsSinceEpoch.toString();
    response["likeCount"] = 0;
    response["likeState"] = false;

    Map<String, dynamic> newUser = {};
    newUser["id"] = user["id"];
    newUser["username"] = user["username"];
    newUser["smallFile"] = user["file"];

    response["user"] = newUser;

    List userTagList = [];
    userTagInput.forEach((key, value) {
      Map<String, dynamic> userTag = {};
      userTag["id"] = random.nextInt(9999) * -1;
      userTag["reply_id"] = response["id"];
      userTag["user_id"] = int.parse(key);
      userTag["user_string"] = value;
      userTagList.add(userTag);
    });

    response["userTags"] = userTagList;
    
    final newReply = Replies$Query$ReplyResponse$Reply.fromJson(response);

    return newReply;
  }

  // replies -- create reply process

  // Future<> create

  // Future<Map<String, dynamic>> createReplyProcess(
  //   Replies$Query$ReplyResponse? repliesResponse,
  //   int commentId,
  //   Map<String, dynamic> newReply,
  //   int replyCount,
  //   Comments$Query$CommentResponse commentsResponse,
  // ) async {
  //   final repliesReponse = await getUpdatedCommentReplies(
  //     repliesResponse,
  //     commentId,
  //     newReply,
  //     replyCount
  //   ).catchError((err) {
  //     print('error in comment Response $err');
  //   });
  //   final updatedComments = await getUpdatedPostCommentsReplies(
  //     commentsResponse, commentId
  //   ).catchError((err) {
  //     print('error in updated comments $err');
  //   });
  //   return {
  //     "repliesReponse": repliesReponse,
  //     "updatedComments": updatedComments
  //   };
  // }

  //replies get new query results from gql
  Future<Map<String, dynamic>> newQueryResultsCommentsAndReplies(
    QueryResultSource commentSource, 
    Map<String, dynamic> commentData, 
    String commentMissingKey,
    QueryResultSource replySource, 
    Map<String, dynamic> replyData, 
    String replyMissingKey
  ) async {
    final newQueryResultComment = GlobalUtils().generateQueryResult(
      commentSource, commentData, commentMissingKey
    );
    final newQueryResultReplies = GlobalUtils().generateQueryResult(
      replySource, replyData, replyMissingKey
    );
    return {
      "newCommentQueryResult": newQueryResultComment,
      "newRepliesQueryResult": newQueryResultReplies
    };
  }
}