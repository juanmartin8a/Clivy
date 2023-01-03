import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';

class UserOptions {
  MeQuery getMeQuery() {
    MeQuery meQuery = MeQuery();

    return meQuery;
  }

  QueryOptions getMeQueryOptions() {
    QueryOptions queryOptions = QueryOptions(
      document: getMeQuery().document,
      variables: {},
      fetchPolicy: FetchPolicy.noCache,
    );
    return queryOptions;
  }

  //sign in 

  SignInMutation signInMutation(
    String usernameOrEmail, String password, String? deviceToken, bool? platformIsIOS
  ) {
    SignInMutation signInMutation = SignInMutation(
      variables: SignInArguments(
        input: SignInInput(
          usernameOrEmail: usernameOrEmail,
          password: password,
        ),
        deviceInput: DeviceInput(
          deviceToken: deviceToken,
          platformIsIOS: platformIsIOS
        ),
      )
    );

    return signInMutation;
  }
  
  MutationOptions signInMutationOptions(
    String usernameOrEmail, String password, String? deviceToken, bool? platformIsIOS
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: signInMutation(usernameOrEmail, password, deviceToken, platformIsIOS).document,
      variables: {
        "input": {
          "usernameOrEmail": usernameOrEmail,
          "password": password
        },
        "deviceInput": {
          "deviceToken": deviceToken,
          "platformIsIOS": platformIsIOS
        }
      }
    );

    return mutationOptions;
  }

  // sign up
  
  RegisterMutation signUpMutation(
    String name,
    String username,
    String email, 
    String password,
    String birthday,
    String? deviceToken,
    bool? platformIsIOS
  ) {
    RegisterMutation signUpMutation = RegisterMutation(
      variables: RegisterArguments(
        input: RegisterInput(
          name: name,
          username: username,
          email: email,
          password: password,
          birthday: birthday
        ),
        deviceInput: DeviceInput(
          deviceToken: deviceToken,
          platformIsIOS: platformIsIOS,
        ),
      )
    );

    return signUpMutation;
  }
  
  MutationOptions signUpMutationOptions(
    String name,
    String username,
    String email, 
    String password,
    String birthday,
    String? deviceToken,
    bool? platformIsIOS
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: signUpMutation(name, username, email, password, birthday, deviceToken, platformIsIOS).document,
      variables: {
        "input": {
          "name": name,
          "username": username,
          "email": email,
          "password": password,
          "birthday": birthday
        },
        "deviceInput": {
          "deviceToken": deviceToken,
          "platformIsIOS": platformIsIOS
        }
      }
    );

    return mutationOptions;
  }

  // sign out 

  SignOutMutation signOutMutation(String token) {
    SignOutMutation signOutMutation = SignOutMutation(
      variables: SignOutArguments(
        token: token
      )
    );

    return signOutMutation;
  }

  MutationOptions signOutMutationOptions(String token) {
    MutationOptions mutationOptions =  MutationOptions(
      document: signOutMutation(token).document,
      variables: {
        "token": token
      }
    );

    return mutationOptions;
  }

  // refresh token

  RefreshTokensMutation refreshTokensMutation(String token) {
    RefreshTokensMutation refreshTokensMutation =  RefreshTokensMutation(
      variables: RefreshTokensArguments(
        token: token
      )
    );

    return refreshTokensMutation;
  }

  MutationOptions refreshTokensMutationOptions(String token) {
    MutationOptions mutationOptions =  MutationOptions(
      document: refreshTokensMutation(token).document,
      variables: {
        "token": token
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  // user
  UserQuery userQuery(int userId) {
    UserQuery userQuery = UserQuery(
      variables: UserArguments(
        userId: userId
      )
    );

    return userQuery;
  }

  QueryOptions userQueryOptions(int userId) {
    QueryOptions queryOptions = QueryOptions(
      document: userQuery(userId).document,
      variables: {
        "userId": userId
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  // update profile

  EditProfileMutation editProfileMutation(
    String? name,
    String? username,
    String? bio,
    CustomMultipartFile? file,
    CustomMultipartFile? smallFile
  ) {
    EditProfileMutation editProfileMutation = EditProfileMutation(
      variables: EditProfileArguments(
        file: file,
        smallFile: smallFile,
        input: UserUpdateInput(
          name: name,
          username: username,
          bio: bio
        )
      )
    );

    return editProfileMutation;
  }
  
  MutationOptions editProfileMutationOptions(
    String? name,
    String? username,
    String? bio,
    CustomMultipartFile? file,
    CustomMultipartFile? smallFile
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: editProfileMutation(
        name, username, bio, file, smallFile
      ).document,
      variables: {
        "input": {
          "name": name,
          "username": username,
          "bio": bio
        },
        "file": file,
        "smallFile": smallFile
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  // follow unfollow user

  FollowUnfollowUserMutation followUnfollowUserMutation(int followUserId, String clientId) {
    FollowUnfollowUserMutation followUnfollowUserMutation = FollowUnfollowUserMutation(
      variables: FollowUnfollowUserArguments(
        followUserId: followUserId,
        clientId: clientId
      )
    );

    return followUnfollowUserMutation;
  }

  MutationOptions followUnfollowUserMutationOptions(
    int followUserId, String clientId,
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: followUnfollowUserMutation(
        followUserId,
        clientId
      ).document,
      variables: {
        "followUserId": followUserId,
        "clientId": clientId
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  // forgot password

  SendResetPasswordEmailMutation sendResetPasswordEmailMutation(String email) {
    SendResetPasswordEmailMutation followUnfollowUserMutation = SendResetPasswordEmailMutation(
      variables: SendResetPasswordEmailArguments(
        email: email,
      )
    );

    return followUnfollowUserMutation;
  }

  MutationOptions sendResetPassswordEmailMutationOptions(
    String email,
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: sendResetPasswordEmailMutation(
        email,
      ).document,
      variables: {
        "email": email,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  VerifyResetCodeQuery verifyResetCodeQuery(String email, String code) {
    VerifyResetCodeQuery verifyResetCodeQuery = VerifyResetCodeQuery(
      variables: VerifyResetCodeArguments(
        email: email,
        code: code
      )
    );

    return verifyResetCodeQuery;
  }

  QueryOptions verifyResetCodeQueryOptions(
    String email, String code
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: verifyResetCodeQuery(
        email,
        code
      ).document,
      variables: {
        "email": email,
        "code": code
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  ChangePasswordAndSignInMutation changePasswordSignInMutation(
    String newPassword, String email, String code, String? deviceToken, bool? platformIsIOS
  ) {
    ChangePasswordAndSignInMutation changePasswordAndSignInMutation = ChangePasswordAndSignInMutation(
      variables: ChangePasswordAndSignInArguments(
        newPassword: newPassword,
        email: email,
        code: code,
        deviceInput: DeviceInput(
          deviceToken: deviceToken,
          platformIsIOS: platformIsIOS
        )
      )
    );

    return changePasswordAndSignInMutation;
  }

  MutationOptions changePasswordSignInMutationOptions(
    String newPassword, String email, String code, String? deviceToken, bool? platformIsIOS
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: changePasswordSignInMutation(
        newPassword, email, code, deviceToken, platformIsIOS
      ).document,
      variables: {
        "newPassword": newPassword,
        "email": email,
        "code": code,
        "deviceInput": {
          "deviceToken": deviceToken,
          "platformIsIOS": platformIsIOS
        }
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  AddNewDeviceTokenMutation addNewDeviceTokenMutation(
    String deviceToken, bool platformIsIOS
  ) {
    AddNewDeviceTokenMutation mutationOptions = AddNewDeviceTokenMutation(
      variables: AddNewDeviceTokenArguments(
        deviceInput: DeviceInput(
          deviceToken: deviceToken,
          platformIsIOS: platformIsIOS
        )
      ) 
    );

    return mutationOptions;
  }

  MutationOptions addNewDeviceTokenMutationOptions(
    String deviceToken, bool platformIsIOS
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: addNewDeviceTokenMutation(
        deviceToken, platformIsIOS
      ).document,
      variables: { 
        "deviceInput": {
          "deviceToken": deviceToken,
          "platformIsIOS": platformIsIOS
        }
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  // user following and followers

  UserFollowingQuery userFollowingQuery(
    int followUserId, int limit, String? cursor, List<int> idsList
  ) {
    UserFollowingQuery userFollowingQuery = UserFollowingQuery(
      variables: UserFollowingArguments(
        followUserId: followUserId,
        limit: limit,
        cursor: cursor,
        idsList: idsList
      ) 
    );

    return userFollowingQuery;
  }

  QueryOptions getUserFollowingQueryOptions(
    int followUserId, int limit, String? cursor, List<int> idsList
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: userFollowingQuery(
        followUserId, limit, cursor, idsList
      ).document,
      variables: { 
        "followUserId": followUserId,
        "limit": limit,
        "cursor": cursor,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  FetchMoreOptions getMoreUserFollowingQueryOptions(
    int followUserId, int limit, String? cursor, List<int> idsList
  ) {
    FetchMoreOptions queryOptions = FetchMoreOptions(
      document: userFollowingQuery(
        followUserId, limit, cursor, idsList
      ).document,
      variables: { 
        "followUserId": followUserId,
        "limit": limit,
        "cursor": cursor,
        "idsList": idsList
      },
      updateQuery: (prevData, newData) {
        final List<dynamic> repos = [
          ...prevData!['userFollowing']['users'] as List<dynamic>,
          ...newData!['userFollowing']['users'] as List<dynamic>
        ];

        newData['userFollowing']['users'] = repos;

        return newData;
      },
      // fetchPolicy: FetchPolicy.cacheAndNetwork
    );

    return queryOptions;
  }

  UserFollowersQuery userFollowersQuery(
    int followUserId, int limit, String? cursor, List<int> idsList
  ) {
    UserFollowersQuery userFollowersQuery = UserFollowersQuery(
      variables: UserFollowersArguments(
        followUserId: followUserId,
        limit: limit,
        cursor: cursor,
        idsList: idsList
      ) 
    );

    return userFollowersQuery;
  }

  QueryOptions getUserFollowersQueryOptions(
    int followUserId, int limit, String? cursor, List<int> idsList
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: userFollowersQuery(
        followUserId, limit, cursor, idsList
      ).document,
      variables: { 
        "followUserId": followUserId,
        "limit": limit,
        "cursor": cursor,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  FetchMoreOptions getMoreUserFollowersQueryOptions(
    int followUserId, int limit, String? cursor, List<int> idsList
  ) {
    FetchMoreOptions queryOptions = FetchMoreOptions(
      document: userFollowersQuery(
        followUserId, limit, cursor, idsList
      ).document,
      variables: { 
        "followUserId": followUserId,
        "limit": limit,
        "cursor": cursor,
        "idsList": idsList
      },
      updateQuery: (prevData, newData) {
        final List<dynamic> repos = [
          ...prevData!['userFollowers']['users'] as List<dynamic>,
          ...newData!['userFollowers']['users'] as List<dynamic>
        ];

        newData['userFollowers']['users'] = repos;

        return newData;
      },
      // fetchPolicy: FetchPolicy.cacheAndNetwork
    );

    return queryOptions;
  }

  MutationOptions deleteUser() {
    MutationOptions mutationOptions = MutationOptions(
      document: DeleteUserMutation(
        // variables: DeleteUserArguments()
      ).document,
      fetchPolicy: FetchPolicy.noCache
    );
    return mutationOptions;
  }

}