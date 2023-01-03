import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

class CommentOptions {

  const CommentOptions();

  CommentsQuery getCommentsQueryDocumentNode(int postId, int limit, List<int> idsList) {
    CommentsQuery commentsQuery = CommentsQuery(
      variables: CommentsArguments(
        postId: postId,
        limit: limit,
        idsList: idsList
      )
    );

    return commentsQuery;
  }

  QueryOptions getCommentsInitQuery(
    int postId, 
    int limit, 
    List<int> idsList,
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: getCommentsQueryDocumentNode(
        postId, limit, idsList
      ).document,
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        "postId": postId,
        "limit": limit,
        "idsList": idsList
      },
    );

    return queryOptions;
  }

  FetchMoreOptions getMoreCommentsQuery(
    int postId, 
    int limit, 
    List<int> idsList,
  ) {
    FetchMoreOptions fetchMoreOptions = FetchMoreOptions(
      document: getCommentsQueryDocumentNode(
        postId, limit, idsList
      ).document,
      // fetchPolicy: FetchPolicy.cacheAndNetwork,
      variables: {
        "postId": postId,
        "limit": limit,
        "idsList": idsList
      },
      updateQuery: (prevData, newData) {
        final List<dynamic> repos = [
          ...prevData!['comments']['comments'] as List<dynamic>,
          ...newData!['comments']['comments'] as List<dynamic>
        ];

        newData['comments']['comments'] = repos;

        return newData;
      }
    );

    return fetchMoreOptions;
  }

  // replies

  RepliesQuery getRepliesQueryDocumentNode(int commentId, int postId, int limit, String? cursor, List<int> idsList) {
    RepliesQuery repliesQuery = RepliesQuery(
      variables: RepliesArguments(
        commentId: commentId,
        postId: postId,
        limit: limit,
        cursor: cursor,
        idsList: idsList
      )
    );

    return repliesQuery;
  }

  QueryOptions getRepliesInitQuery(
    int commentId, 
    int postId,
    int limit, 
    String? cursor,
    List<int> idsList
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: getRepliesQueryDocumentNode(commentId, postId, limit, cursor, idsList).document,
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        "commentId": commentId,
        "postId": postId,
        "limit": limit,
        "cursor": cursor,
        "idsList": idsList
      },
    );

    return queryOptions;
  }

  FetchMoreOptions getMoreRepliesQuery(
    int commentId, 
    int postId,
    int limit, 
    String? cursor,
    List<int> idsList
  ) {
    FetchMoreOptions fetchMoreOptions = FetchMoreOptions(
      document: getRepliesQueryDocumentNode(
        commentId, postId, limit, cursor, idsList
      ).document,
      variables: {
        "commentId": commentId,
        "postId": postId,
        "limit": limit,
        "cursor": cursor,
        "idsList": idsList
      },
      
      updateQuery: (prevData, newData) {
        final List<dynamic> repos = [
          ...prevData!['commentReplies']['replies'] as List<dynamic>,
          ...newData!['commentReplies']['replies'] as List<dynamic>
        ];

        newData['commentReplies']['replies'] = repos;

        return newData;
      }
    );

    return fetchMoreOptions;
  }

  // ########## MUTATIONS ###########

  // comments

  CommentPostMutation createCommentDocumentNode(
    int postId, String comment, List<UserTagInput> userTagInput
  ) {
    CommentPostMutation commentPostMutation = CommentPostMutation(
      variables: CommentPostArguments(
        postId: postId, 
        comment: comment,
        userTagsInput: userTagInput
      )
    );

    return commentPostMutation;
  }

  MutationOptions createCommentMutation(
    int postId, String comment, List<UserTagInput> userTagInput, GraphQLClient client
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: createCommentDocumentNode(
        postId, comment, userTagInput
      ).document,
      variables: {
        "postId": postId,
        "comment": comment,
        "userTagsInput": userTagInput
      },
      fetchPolicy: FetchPolicy.noCache,
      // update: (cache, result) {
      //   final data = client.readQuery(getCommentsInitQuery(postId, 2, null).asRequest);
      //   client.writeQuery(
      //     getCommentsInitQuery(postId, 2, null).asRequest,
      //     data: {
      //       'comments': {
      //         'comments': [result!.data!['commentPost']['comment'], ...data!['comments']['comments']],
      //         'hasMore': data['comments']['hasMore'],
      //         'postId': data['comments']['postId']
      //       }
      //     },
      //   );
      // },
      onError: (error) {
        print('error in create comment $error');
      }
    );

    return mutationOptions;
  }

  //replies
  ReplyCommentMutation createReplyDocumentNode(int commentId, int postId, String reply, List<UserTagInput> userTagInput) {
    ReplyCommentMutation createReplyMutation = ReplyCommentMutation(
      variables: ReplyCommentArguments(
        commentId: commentId,
        postId: postId,
        reply: reply,
        userTagsInput: userTagInput
      )
    );

    return createReplyMutation;
  }

  MutationOptions createReplyMutation(
    int commentId, int postId, String reply, int replyCount, List<UserTagInput> userTagInput, GraphQLClient client
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: createReplyDocumentNode(
        commentId, postId, reply, userTagInput
      ).document,
      variables: {
        "commentId": commentId,
        "postId": postId,
        "reply": reply,
        "userTagsInput": userTagInput
      },
      fetchPolicy: FetchPolicy.noCache,
      // update: (cache, result) {
      //   final data = client.readQuery(getRepliesInitQuery(commentId, 2, null).asRequest);
      //   client.writeQuery(
      //     getRepliesInitQuery(commentId, 2, null).asRequest,
      //     data: {
      //       'commentReplies': {
      //         'replies': data == null 
      //           ? [result!.data!['replyComment']['reply']]
      //           : [result!.data!['replyComment']['reply'], ...data['commentReplies']['replies']],
      //         'hasMore': data == null
      //           ? replyCount > 0
      //             ? true
      //             : false
      //           : data['commentReplies']['hasMore'],
      //         'commentId': commentId
      //       }
      //     },
      //   );
      // },
      onError: (error) {
        print('error in create replies $error');
      }
    );

    return mutationOptions;
  }

  // delete comment

  DeleteCommentMutation deleteCommentMutation(int commentId, bool isReply) {
    DeleteCommentMutation deleteCommentMutation = DeleteCommentMutation(
      variables: DeleteCommentArguments(commentId: commentId, isReply: isReply)
    );

    return deleteCommentMutation;
  }

  MutationOptions deleteCommentMutationOptions(int commentId, bool isReply) {
    final mutationOptions = MutationOptions(
      document: deleteCommentMutation(commentId, isReply).document,
      variables: {
        "commentId": commentId,
        "isReply": isReply
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

}