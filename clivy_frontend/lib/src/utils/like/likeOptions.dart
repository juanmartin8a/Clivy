import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/utils/posts/postOptions.dart';

class LikeOptions {
  const LikeOptions();

  MutationOptions likePostMutationOptions(
    int postId,
    String clientId,
    GraphQLClient client
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: LikeUnlikePostMutation(
        variables: LikeUnlikePostArguments(
          postId: postId,
          clientId: clientId
        )
      ).document,
      variables: {
        "postId": postId,
        "clientId": clientId
      },
      fetchPolicy: FetchPolicy.noCache,
      update: (cache, result) {
        PostOptions postQueryUtil = PostOptions();
        final data = client.readFragment(postQueryUtil.getPostFragmentRequest(postId));
        client.writeFragment(
          postQueryUtil.getPostFragmentRequest(postId),
          data: {
            "__typename": "Post",
            'id': postId,
            'likeState': result!.data!['likeUnlikePost']['value'] == 1 ? true : false, 
            "likeCount": data!['likeCount'] + (result.data!['likeUnlikePost']['value']), 
          },
        );
      },
      onError: (error) {
        print('error in like m $error');
      }
    );

    return mutationOptions;
  }

  MutationOptions likeCommentMutationOptions(
    int commentId,
    String clientId,
    GraphQLClient client
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: LikeUnlikeCommentMutation(
        variables: LikeUnlikeCommentArguments(
          commentId: commentId,
          clientId: clientId
        )
      ).document,
      variables: {
        "commentId": commentId,
        "clientId": clientId
      },
      fetchPolicy: FetchPolicy.noCache,
      onError: (error) {
        print('error in comment like $error');
      }
    );

    return mutationOptions;
  }

  MutationOptions likeReplyMutationOptions(
    int replyId,
    String clientId,
    GraphQLClient client
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: LikeUnlikeReplyMutation(
        variables: LikeUnlikeReplyArguments(
          replyId: replyId,
          clientId: clientId
        )
      ).document,
      variables: {
        "replyId": replyId,
        "clientId": clientId
      },
      fetchPolicy: FetchPolicy.noCache,
      onError: (error) {
        print('error in reply like $error');
      }
    );

    return mutationOptions;
  }
}