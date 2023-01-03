import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:untitled_client/src/models/jwt.dart';
import 'package:untitled_client/src/utils/posts/postTypes.dart';
import 'package:untitled_client/src/utils/user/userOptions.dart';

class UserRepository {
  final GraphQLClient client;

  UserRepository({ 
    required this.client
  });

  Future<Me$Query$User> me() async {
    final result = await client.query(
      UserOptions().getMeQueryOptions()
    );
    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return Me$Query$User.fromJson(result.data!["me"]);
    }
  }

  Future<SignIn$Mutation$UserMutationResponse> signUserIn(
    String usernameOrEmail, String password, String? deviceToken, bool? platformIsIOS
  ) async {
    print(usernameOrEmail);
    print(password);
    final result = await client.mutate(
      UserOptions().signInMutationOptions(usernameOrEmail, password, deviceToken, platformIsIOS)
    );
    if (result.hasException) {
      print('error');
      print(result);
      throw (result.exception as OperationException);
    } else {
      if ((result.data as Map<String, dynamic>)["signIn"]["tokens"] != null) {
        // print(result.data);
        await JWT().createJWTS(
          (result.data as Map<String, dynamic>)["signIn"]["tokens"]["accessToken"],
          (result.data as Map<String, dynamic>)["signIn"]["tokens"]["refreshToken"]
        );
      }
      return SignIn$Mutation$UserMutationResponse.fromJson(
        (result.data as Map<String, dynamic>)["signIn"]
      );
    }
  }

  Future<Register$Mutation$UserMutationResponse> signUserUp(
    String name,
    String username,
    String email, 
    String password,
    String birthday,
    String? deviceToken,
    bool? platformIsIOS
  ) async {
    final result = await client.mutate(
      UserOptions().signUpMutationOptions(name, username, email, password, birthday, deviceToken, platformIsIOS)
    );
    print('mutation register');
    //print(result);
    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      if ((result.data as Map<String, dynamic>)["register"]["tokens"] != null) {
        await JWT().createJWTS(
          (result.data as Map<String, dynamic>)["register"]["tokens"]["accessToken"],
          (result.data as Map<String, dynamic>)["register"]["tokens"]["refreshToken"]
        );
      }
      return Register$Mutation$UserMutationResponse.fromJson(
        (result.data as Map<String, dynamic>)["register"]
      );
    }
  }

  Future<SignOut$Mutation> signOut() async {
    String token = await JWT().getJWT();
    final result = await client.mutate(
      UserOptions().signOutMutationOptions(token)
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      if ((result.data as Map<String, dynamic>)["signOut"] == true) {
        await JWT().deleteJWTS();
      }
      return SignOut$Mutation.fromJson(
        (result.data as Map<String, dynamic>)
      );
    }
  }

  Future<RefreshTokens$Mutation$TokenResponse> refreshToken(String token) async {
    final result = await client.mutate(
      UserOptions().refreshTokensMutationOptions(token)
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      if (result.data!["refreshToken"]["refreshToken"] == "") {
        await JWT().deleteJWTS();
      } else if ((result.data as Map<String, dynamic>)["refreshToken"]["refreshToken"].length > 0) {
        await JWT().createJWTS(
          result.data!["refreshToken"]["accessToken"],
          result.data!["refreshToken"]["refreshToken"]
        );
      }
      return RefreshTokens$Mutation$TokenResponse.fromJson(
        result.data!["refreshToken"]
      );
    }
  }

  Future<User$Query$User> user(int userId) async {
    print(userId);
    final result = await client.query(
      UserOptions().userQueryOptions(userId)
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      return User$Query$User.fromJson(
        (result.data as Map<String, dynamic>)["user"]
      );
    }
  }

  Future<EditProfile$Mutation$UserMutationResponse> editProfile(
    String? name,
    String? username,
    String? bio,
    CustomMultipartFile? file,
    CustomMultipartFile? smallFile
  ) async {
    final result = await client.mutate(
      UserOptions().editProfileMutationOptions(
        name, username, bio, file, smallFile
      ),
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      return EditProfile$Mutation$UserMutationResponse.fromJson(
        (result.data as Map<String, dynamic>)["editUser"]
      );
    }
  }

  Future<FollowUnfollowUser$Mutation$LikeResponse> followUnfollowUser(
    int followUserId,
    String clientId
  ) async {
    final result = await client.mutate(
      UserOptions().followUnfollowUserMutationOptions(
        followUserId, clientId
      ),
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      return FollowUnfollowUser$Mutation$LikeResponse.fromJson(
        (result.data as Map<String, dynamic>)["followUnfollowUser"]
      );
    }
  }

  Future<SendResetPasswordEmail$Mutation> sendResetPasswordEmail(
    String email,
  ) async {
    final result = await client.mutate(
      UserOptions().sendResetPassswordEmailMutationOptions(
        email
      ),
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      return SendResetPasswordEmail$Mutation.fromJson(
        (result.data as Map<String, dynamic>)
      );
    }
  }

  Future<VerifyResetCode$Query> verifyResetCode(
    String email, String code
  ) async {
    final result = await client.query(
      UserOptions().verifyResetCodeQueryOptions(
        email, code
      ),
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      return VerifyResetCode$Query.fromJson(
        (result.data as Map<String, dynamic>)
      );
    }
  }

  Future<ChangePasswordAndSignIn$Mutation$UserMutationResponse> changePasswordAndSignIn(
    String newPassword, String email, String code, String? deviceToken, bool? platformIsIOS
  ) async {
    final result = await client.mutate(
      UserOptions().changePasswordSignInMutationOptions(
        newPassword, email, code, deviceToken, platformIsIOS
      ),
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      if ((result.data as Map<String, dynamic>)["changePasswordAndSignIn"]["tokens"] != null) {
        await JWT().createJWTS(
          (result.data as Map<String, dynamic>)["changePasswordAndSignIn"]["tokens"]["accessToken"],
          (result.data as Map<String, dynamic>)["changePasswordAndSignIn"]["tokens"]["refreshToken"]
        );
      }
      return ChangePasswordAndSignIn$Mutation$UserMutationResponse.fromJson(
        (result.data as Map<String, dynamic>)["changePasswordAndSignIn"]
      );
    }
  }

  Future<AddNewDeviceToken$Mutation> addNewDeviceTokenMutation(
    String deviceToken, bool platformIsIOS
  ) async {
    final result = await client.mutate(
      UserOptions().addNewDeviceTokenMutationOptions(
        deviceToken, platformIsIOS
      ),
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      return AddNewDeviceToken$Mutation.fromJson(
        result.data as Map<String, dynamic>
      );
    }
  }

  Future<UserFollowingResponse> userFollowing(
  // UserFollowing$Query$PaginatedUsers> userFollowing(
    int followUserId, 
    int limit, 
    String? cursor,
    QueryResult? usersQueryResult, 
    bool isFetchMore,
    List<int> idsList
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      result = await client.fetchMore(
        UserOptions().getMoreUserFollowingQueryOptions(followUserId, limit, cursor, idsList),
        originalOptions: UserOptions().getUserFollowingQueryOptions(followUserId, limit, null, idsList),
        previousResult: usersQueryResult!
      );
    } else {
      result = await client.query(
        UserOptions().getUserFollowingQueryOptions(followUserId, limit, null, idsList)
      );
    }

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      Map<String, dynamic> usersAndQueryResult = {
        "paginatedUsers": UserFollowing$Query$PaginatedFollow.fromJson(
          (result.data as Map<String, dynamic>)["userFollowing"]
        ),
        "queryResult": result
      };
      return UserFollowingResponse.fromJson(
        usersAndQueryResult
      );
    }
  }

  Future<UserFollowersResponse> userFollowers(
    int followUserId, 
    int limit, 
    String? cursor,
    QueryResult? usersQueryResult, 
    bool isFetchMore,
    List<int> idsList
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      result = await client.fetchMore(
        UserOptions().getMoreUserFollowersQueryOptions(followUserId, limit, cursor, idsList),
        originalOptions: UserOptions().getUserFollowersQueryOptions(followUserId, limit, null, idsList),
        previousResult: usersQueryResult!
      );
    } else {
      result = await client.query(
        UserOptions().getUserFollowersQueryOptions(followUserId, limit, null, idsList)
      );
    }

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      Map<String, dynamic> usersAndQueryResult = {
        "paginatedUsers": UserFollowers$Query$PaginatedFollow.fromJson(
          (result.data as Map<String, dynamic>)["userFollowers"]
        ),
        "queryResult": result
      };
      return UserFollowersResponse.fromJson(
        usersAndQueryResult
      );
    }
  }

  Future<DeleteUser$Mutation> deleteUser() async {
    QueryResult? result;
    MutationOptions mutationOptions = UserOptions().deleteUser();
    result = await client.mutate(
      mutationOptions,
    );

    if (result.hasException) {
      print('error');
      print(result.exception);
      throw (result.exception as OperationException);
    } else {
      return DeleteUser$Mutation.fromJson(result.data!);
    }
  }

  // Future<FollowingList$Query$PaginatedFollow> 
  // followingList() {
  //   QueryResult? result;
  //   if (isFetchMore) {
  //     FetchMoreOptions fetchMoreOptions = UserOptions().getMoreCommentsQuery(postId, limit, idsList);
  //     result = await client.fetchMore(
  //       fetchMoreOptions,
  //       originalOptions: UserOptions().getCommentsInitQuery(postId, 2, []),
  //       previousResult: commentsQueryResult!,
  //     );
  //   } else {
  //     QueryOptions queryOptions = UserOptions().getCommentsInitQuery(postId, limit, []);
  //     result = await client.query(
  //       queryOptions,
  //     );
  //   }

  // }
}