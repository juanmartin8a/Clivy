// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokens$Mutation$TokenResponse
    _$RefreshTokens$Mutation$TokenResponseFromJson(Map<String, dynamic> json) =>
        RefreshTokens$Mutation$TokenResponse()
          ..refreshToken = json['refreshToken'] as String
          ..accessToken = json['accessToken'] as String;

Map<String, dynamic> _$RefreshTokens$Mutation$TokenResponseToJson(
        RefreshTokens$Mutation$TokenResponse instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
    };

RefreshTokens$Mutation _$RefreshTokens$MutationFromJson(
        Map<String, dynamic> json) =>
    RefreshTokens$Mutation()
      ..refreshToken = RefreshTokens$Mutation$TokenResponse.fromJson(
          json['refreshToken'] as Map<String, dynamic>);

Map<String, dynamic> _$RefreshTokens$MutationToJson(
        RefreshTokens$Mutation instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken.toJson(),
    };

LikeUnlikeReply$Mutation$LikeResponse
    _$LikeUnlikeReply$Mutation$LikeResponseFromJson(
            Map<String, dynamic> json) =>
        LikeUnlikeReply$Mutation$LikeResponse()
          ..value = json['value'] as int?
          ..clientId = json['clientId'] as String?;

Map<String, dynamic> _$LikeUnlikeReply$Mutation$LikeResponseToJson(
        LikeUnlikeReply$Mutation$LikeResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'clientId': instance.clientId,
    };

LikeUnlikeReply$Mutation _$LikeUnlikeReply$MutationFromJson(
        Map<String, dynamic> json) =>
    LikeUnlikeReply$Mutation()
      ..likeUnlikeReply = LikeUnlikeReply$Mutation$LikeResponse.fromJson(
          json['likeUnlikeReply'] as Map<String, dynamic>);

Map<String, dynamic> _$LikeUnlikeReply$MutationToJson(
        LikeUnlikeReply$Mutation instance) =>
    <String, dynamic>{
      'likeUnlikeReply': instance.likeUnlikeReply.toJson(),
    };

ViewClip$Mutation _$ViewClip$MutationFromJson(Map<String, dynamic> json) =>
    ViewClip$Mutation()..viewClip = json['viewClip'] as bool;

Map<String, dynamic> _$ViewClip$MutationToJson(ViewClip$Mutation instance) =>
    <String, dynamic>{
      'viewClip': instance.viewClip,
    };

LikeUnlikePost$Mutation$LikeResponse
    _$LikeUnlikePost$Mutation$LikeResponseFromJson(Map<String, dynamic> json) =>
        LikeUnlikePost$Mutation$LikeResponse()
          ..value = json['value'] as int?
          ..clientId = json['clientId'] as String?;

Map<String, dynamic> _$LikeUnlikePost$Mutation$LikeResponseToJson(
        LikeUnlikePost$Mutation$LikeResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'clientId': instance.clientId,
    };

LikeUnlikePost$Mutation _$LikeUnlikePost$MutationFromJson(
        Map<String, dynamic> json) =>
    LikeUnlikePost$Mutation()
      ..likeUnlikePost = LikeUnlikePost$Mutation$LikeResponse.fromJson(
          json['likeUnlikePost'] as Map<String, dynamic>);

Map<String, dynamic> _$LikeUnlikePost$MutationToJson(
        LikeUnlikePost$Mutation instance) =>
    <String, dynamic>{
      'likeUnlikePost': instance.likeUnlikePost.toJson(),
    };

SignIn$Mutation$UserMutationResponse$ErrorResponse
    _$SignIn$Mutation$UserMutationResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        SignIn$Mutation$UserMutationResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic> _$SignIn$Mutation$UserMutationResponse$ErrorResponseToJson(
        SignIn$Mutation$UserMutationResponse$ErrorResponse instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

SignIn$Mutation$UserMutationResponse$User
    _$SignIn$Mutation$UserMutationResponse$UserFromJson(
            Map<String, dynamic> json) =>
        SignIn$Mutation$UserMutationResponse$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..file = UserFragmentMixin$FileResponse.fromJson(
              json['file'] as Map<String, dynamic>);

Map<String, dynamic> _$SignIn$Mutation$UserMutationResponse$UserToJson(
        SignIn$Mutation$UserMutationResponse$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'file': instance.file.toJson(),
    };

SignIn$Mutation$UserMutationResponse$TokenResponse
    _$SignIn$Mutation$UserMutationResponse$TokenResponseFromJson(
            Map<String, dynamic> json) =>
        SignIn$Mutation$UserMutationResponse$TokenResponse()
          ..refreshToken = json['refreshToken'] as String
          ..accessToken = json['accessToken'] as String;

Map<String, dynamic> _$SignIn$Mutation$UserMutationResponse$TokenResponseToJson(
        SignIn$Mutation$UserMutationResponse$TokenResponse instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
    };

SignIn$Mutation$UserMutationResponse
    _$SignIn$Mutation$UserMutationResponseFromJson(Map<String, dynamic> json) =>
        SignIn$Mutation$UserMutationResponse()
          ..errors = (json['errors'] as List<dynamic>?)
              ?.map((e) =>
                  SignIn$Mutation$UserMutationResponse$ErrorResponse.fromJson(
                      e as Map<String, dynamic>))
              .toList()
          ..user = json['user'] == null
              ? null
              : SignIn$Mutation$UserMutationResponse$User.fromJson(
                  json['user'] as Map<String, dynamic>)
          ..tokens = json['tokens'] == null
              ? null
              : SignIn$Mutation$UserMutationResponse$TokenResponse.fromJson(
                  json['tokens'] as Map<String, dynamic>);

Map<String, dynamic> _$SignIn$Mutation$UserMutationResponseToJson(
        SignIn$Mutation$UserMutationResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
      'user': instance.user?.toJson(),
      'tokens': instance.tokens?.toJson(),
    };

SignIn$Mutation _$SignIn$MutationFromJson(Map<String, dynamic> json) =>
    SignIn$Mutation()
      ..signIn = SignIn$Mutation$UserMutationResponse.fromJson(
          json['signIn'] as Map<String, dynamic>);

Map<String, dynamic> _$SignIn$MutationToJson(SignIn$Mutation instance) =>
    <String, dynamic>{
      'signIn': instance.signIn.toJson(),
    };

UserFragmentMixin$FileResponse _$UserFragmentMixin$FileResponseFromJson(
        Map<String, dynamic> json) =>
    UserFragmentMixin$FileResponse()
      ..file = json['file'] as String?
      ..error = json['error'] as String?;

Map<String, dynamic> _$UserFragmentMixin$FileResponseToJson(
        UserFragmentMixin$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

SignInInput _$SignInInputFromJson(Map<String, dynamic> json) => SignInInput(
      usernameOrEmail: json['usernameOrEmail'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInInputToJson(SignInInput instance) =>
    <String, dynamic>{
      'usernameOrEmail': instance.usernameOrEmail,
      'password': instance.password,
    };

DeviceInput _$DeviceInputFromJson(Map<String, dynamic> json) => DeviceInput(
      deviceToken: json['deviceToken'] as String?,
      platformIsIOS: json['platformIsIOS'] as bool?,
    );

Map<String, dynamic> _$DeviceInputToJson(DeviceInput instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'platformIsIOS': instance.platformIsIOS,
    };

AddNewDeviceToken$Mutation _$AddNewDeviceToken$MutationFromJson(
        Map<String, dynamic> json) =>
    AddNewDeviceToken$Mutation()
      ..addNewDeviceToken = json['addNewDeviceToken'] as bool;

Map<String, dynamic> _$AddNewDeviceToken$MutationToJson(
        AddNewDeviceToken$Mutation instance) =>
    <String, dynamic>{
      'addNewDeviceToken': instance.addNewDeviceToken,
    };

CommentPost$Mutation$CreateCommentResponse$Comment
    _$CommentPost$Mutation$CreateCommentResponse$CommentFromJson(
            Map<String, dynamic> json) =>
        CommentPost$Mutation$CreateCommentResponse$Comment()
          ..$$typename = json['__typename'] as String?
          ..id = (json['id'] as num).toDouble()
          ..comment = json['comment'] as String
          ..userId = (json['user_id'] as num).toDouble()
          ..postId = (json['post_id'] as num).toDouble()
          ..createdAt = json['createdAt'] as String
          ..replyCount = json['replyCount'] as int
          ..likeCount = json['likeCount'] as int
          ..likeState = json['likeState'] as bool?
          ..user = CommentFragmentMixin$User.fromJson(
              json['user'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) => CommentFragmentMixin$CommentUserTag.fromJson(
                  e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$CommentPost$Mutation$CreateCommentResponse$CommentToJson(
        CommentPost$Mutation$CreateCommentResponse$Comment instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'comment': instance.comment,
      'user_id': instance.userId,
      'post_id': instance.postId,
      'createdAt': instance.createdAt,
      'replyCount': instance.replyCount,
      'likeCount': instance.likeCount,
      'likeState': instance.likeState,
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
    };

CommentPost$Mutation$CreateCommentResponse
    _$CommentPost$Mutation$CreateCommentResponseFromJson(
            Map<String, dynamic> json) =>
        CommentPost$Mutation$CreateCommentResponse()
          ..comment = json['comment'] == null
              ? null
              : CommentPost$Mutation$CreateCommentResponse$Comment.fromJson(
                  json['comment'] as Map<String, dynamic>)
          ..postId = json['postId'] as int?
          ..error = json['error'] as bool?;

Map<String, dynamic> _$CommentPost$Mutation$CreateCommentResponseToJson(
        CommentPost$Mutation$CreateCommentResponse instance) =>
    <String, dynamic>{
      'comment': instance.comment?.toJson(),
      'postId': instance.postId,
      'error': instance.error,
    };

CommentPost$Mutation _$CommentPost$MutationFromJson(
        Map<String, dynamic> json) =>
    CommentPost$Mutation()
      ..commentPost = CommentPost$Mutation$CreateCommentResponse.fromJson(
          json['commentPost'] as Map<String, dynamic>);

Map<String, dynamic> _$CommentPost$MutationToJson(
        CommentPost$Mutation instance) =>
    <String, dynamic>{
      'commentPost': instance.commentPost.toJson(),
    };

CommentFragmentMixin$User$FileResponse
    _$CommentFragmentMixin$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        CommentFragmentMixin$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic> _$CommentFragmentMixin$User$FileResponseToJson(
        CommentFragmentMixin$User$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

CommentFragmentMixin$User _$CommentFragmentMixin$UserFromJson(
        Map<String, dynamic> json) =>
    CommentFragmentMixin$User()
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..smallFile = CommentFragmentMixin$User$FileResponse.fromJson(
          json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic> _$CommentFragmentMixin$UserToJson(
        CommentFragmentMixin$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'smallFile': instance.smallFile.toJson(),
    };

CommentFragmentMixin$CommentUserTag
    _$CommentFragmentMixin$CommentUserTagFromJson(Map<String, dynamic> json) =>
        CommentFragmentMixin$CommentUserTag()
          ..commentId = json['comment_id'] as int
          ..userId = json['user_id'] as int
          ..userString = json['user_string'] as String;

Map<String, dynamic> _$CommentFragmentMixin$CommentUserTagToJson(
        CommentFragmentMixin$CommentUserTag instance) =>
    <String, dynamic>{
      'comment_id': instance.commentId,
      'user_id': instance.userId,
      'user_string': instance.userString,
    };

UserTagInput _$UserTagInputFromJson(Map<String, dynamic> json) => UserTagInput(
      userString: json['userString'] as String,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$UserTagInputToJson(UserTagInput instance) =>
    <String, dynamic>{
      'userString': instance.userString,
      'userId': instance.userId,
    };

UserTapped$Mutation$User$FileResponse
    _$UserTapped$Mutation$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        UserTapped$Mutation$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic> _$UserTapped$Mutation$User$FileResponseToJson(
        UserTapped$Mutation$User$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

UserTapped$Mutation$User _$UserTapped$Mutation$UserFromJson(
        Map<String, dynamic> json) =>
    UserTapped$Mutation$User()
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..name = json['name'] as String
      ..file = UserTapped$Mutation$User$FileResponse.fromJson(
          json['file'] as Map<String, dynamic>);

Map<String, dynamic> _$UserTapped$Mutation$UserToJson(
        UserTapped$Mutation$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'file': instance.file.toJson(),
    };

UserTapped$Mutation _$UserTapped$MutationFromJson(Map<String, dynamic> json) =>
    UserTapped$Mutation()
      ..userTapped = json['userTapped'] == null
          ? null
          : UserTapped$Mutation$User.fromJson(
              json['userTapped'] as Map<String, dynamic>);

Map<String, dynamic> _$UserTapped$MutationToJson(
        UserTapped$Mutation instance) =>
    <String, dynamic>{
      'userTapped': instance.userTapped?.toJson(),
    };

DeleteUser$Mutation _$DeleteUser$MutationFromJson(Map<String, dynamic> json) =>
    DeleteUser$Mutation()..deleteUser = json['deleteUser'] as bool;

Map<String, dynamic> _$DeleteUser$MutationToJson(
        DeleteUser$Mutation instance) =>
    <String, dynamic>{
      'deleteUser': instance.deleteUser,
    };

ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse
    _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic>
    _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponseToJson(
            ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse
                instance) =>
        <String, dynamic>{
          'field': instance.field,
          'message': instance.message,
        };

ChangePasswordAndSignIn$Mutation$UserMutationResponse$User
    _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$UserFromJson(
            Map<String, dynamic> json) =>
        ChangePasswordAndSignIn$Mutation$UserMutationResponse$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..file = UserFragmentMixin$FileResponse.fromJson(
              json['file'] as Map<String, dynamic>);

Map<String,
    dynamic> _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$UserToJson(
        ChangePasswordAndSignIn$Mutation$UserMutationResponse$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'file': instance.file.toJson(),
    };

ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponse
    _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponseFromJson(
            Map<String, dynamic> json) =>
        ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponse()
          ..refreshToken = json['refreshToken'] as String
          ..accessToken = json['accessToken'] as String;

Map<String, dynamic>
    _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponseToJson(
            ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponse
                instance) =>
        <String, dynamic>{
          'refreshToken': instance.refreshToken,
          'accessToken': instance.accessToken,
        };

ChangePasswordAndSignIn$Mutation$UserMutationResponse
    _$ChangePasswordAndSignIn$Mutation$UserMutationResponseFromJson(
            Map<String, dynamic> json) =>
        ChangePasswordAndSignIn$Mutation$UserMutationResponse()
          ..errors = (json['errors'] as List<dynamic>?)
              ?.map((e) =>
                  ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..user = json['user'] == null
              ? null
              : ChangePasswordAndSignIn$Mutation$UserMutationResponse$User
                  .fromJson(json['user'] as Map<String, dynamic>)
          ..tokens = json['tokens'] == null
              ? null
              : ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponse
                  .fromJson(json['tokens'] as Map<String, dynamic>);

Map<String, dynamic>
    _$ChangePasswordAndSignIn$Mutation$UserMutationResponseToJson(
            ChangePasswordAndSignIn$Mutation$UserMutationResponse instance) =>
        <String, dynamic>{
          'errors': instance.errors?.map((e) => e.toJson()).toList(),
          'user': instance.user?.toJson(),
          'tokens': instance.tokens?.toJson(),
        };

ChangePasswordAndSignIn$Mutation _$ChangePasswordAndSignIn$MutationFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordAndSignIn$Mutation()
      ..changePasswordAndSignIn =
          ChangePasswordAndSignIn$Mutation$UserMutationResponse.fromJson(
              json['changePasswordAndSignIn'] as Map<String, dynamic>);

Map<String, dynamic> _$ChangePasswordAndSignIn$MutationToJson(
        ChangePasswordAndSignIn$Mutation instance) =>
    <String, dynamic>{
      'changePasswordAndSignIn': instance.changePasswordAndSignIn.toJson(),
    };

EditProfile$Mutation$UserMutationResponse$ErrorResponse
    _$EditProfile$Mutation$UserMutationResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        EditProfile$Mutation$UserMutationResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic>
    _$EditProfile$Mutation$UserMutationResponse$ErrorResponseToJson(
            EditProfile$Mutation$UserMutationResponse$ErrorResponse instance) =>
        <String, dynamic>{
          'field': instance.field,
          'message': instance.message,
        };

EditProfile$Mutation$UserMutationResponse$User$FileResponse
    _$EditProfile$Mutation$UserMutationResponse$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        EditProfile$Mutation$UserMutationResponse$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic>
    _$EditProfile$Mutation$UserMutationResponse$User$FileResponseToJson(
            EditProfile$Mutation$UserMutationResponse$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
          'error': instance.error,
        };

EditProfile$Mutation$UserMutationResponse$User
    _$EditProfile$Mutation$UserMutationResponse$UserFromJson(
            Map<String, dynamic> json) =>
        EditProfile$Mutation$UserMutationResponse$User()
          ..$$typename = json['__typename'] as String?
          ..id = (json['id'] as num).toDouble()
          ..name = json['name'] as String
          ..username = json['username'] as String
          ..email = json['email'] as String
          ..bio = json['bio'] as String
          ..file = EditProfile$Mutation$UserMutationResponse$User$FileResponse
              .fromJson(json['file'] as Map<String, dynamic>)
          ..followingCount = json['followingCount'] as int
          ..followersCount = json['followersCount'] as int;

Map<String, dynamic> _$EditProfile$Mutation$UserMutationResponse$UserToJson(
        EditProfile$Mutation$UserMutationResponse$User instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'bio': instance.bio,
      'file': instance.file.toJson(),
      'followingCount': instance.followingCount,
      'followersCount': instance.followersCount,
    };

EditProfile$Mutation$UserMutationResponse
    _$EditProfile$Mutation$UserMutationResponseFromJson(
            Map<String, dynamic> json) =>
        EditProfile$Mutation$UserMutationResponse()
          ..errors = (json['errors'] as List<dynamic>?)
              ?.map((e) =>
                  EditProfile$Mutation$UserMutationResponse$ErrorResponse
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..user = json['user'] == null
              ? null
              : EditProfile$Mutation$UserMutationResponse$User.fromJson(
                  json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$EditProfile$Mutation$UserMutationResponseToJson(
        EditProfile$Mutation$UserMutationResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
      'user': instance.user?.toJson(),
    };

EditProfile$Mutation _$EditProfile$MutationFromJson(
        Map<String, dynamic> json) =>
    EditProfile$Mutation()
      ..editUser = EditProfile$Mutation$UserMutationResponse.fromJson(
          json['editUser'] as Map<String, dynamic>);

Map<String, dynamic> _$EditProfile$MutationToJson(
        EditProfile$Mutation instance) =>
    <String, dynamic>{
      'editUser': instance.editUser.toJson(),
    };

UserUpdateInput _$UserUpdateInputFromJson(Map<String, dynamic> json) =>
    UserUpdateInput(
      name: json['name'] as String?,
      username: json['username'] as String?,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$UserUpdateInputToJson(UserUpdateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'bio': instance.bio,
    };

DeleteComment$Mutation _$DeleteComment$MutationFromJson(
        Map<String, dynamic> json) =>
    DeleteComment$Mutation()..deleteComment = json['deleteComment'] as bool;

Map<String, dynamic> _$DeleteComment$MutationToJson(
        DeleteComment$Mutation instance) =>
    <String, dynamic>{
      'deleteComment': instance.deleteComment,
    };

Register$Mutation$UserMutationResponse$ErrorResponse
    _$Register$Mutation$UserMutationResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        Register$Mutation$UserMutationResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic>
    _$Register$Mutation$UserMutationResponse$ErrorResponseToJson(
            Register$Mutation$UserMutationResponse$ErrorResponse instance) =>
        <String, dynamic>{
          'field': instance.field,
          'message': instance.message,
        };

Register$Mutation$UserMutationResponse$User
    _$Register$Mutation$UserMutationResponse$UserFromJson(
            Map<String, dynamic> json) =>
        Register$Mutation$UserMutationResponse$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..file = UserFragmentMixin$FileResponse.fromJson(
              json['file'] as Map<String, dynamic>);

Map<String, dynamic> _$Register$Mutation$UserMutationResponse$UserToJson(
        Register$Mutation$UserMutationResponse$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'file': instance.file.toJson(),
    };

Register$Mutation$UserMutationResponse$TokenResponse
    _$Register$Mutation$UserMutationResponse$TokenResponseFromJson(
            Map<String, dynamic> json) =>
        Register$Mutation$UserMutationResponse$TokenResponse()
          ..refreshToken = json['refreshToken'] as String
          ..accessToken = json['accessToken'] as String;

Map<String, dynamic>
    _$Register$Mutation$UserMutationResponse$TokenResponseToJson(
            Register$Mutation$UserMutationResponse$TokenResponse instance) =>
        <String, dynamic>{
          'refreshToken': instance.refreshToken,
          'accessToken': instance.accessToken,
        };

Register$Mutation$UserMutationResponse
    _$Register$Mutation$UserMutationResponseFromJson(
            Map<String, dynamic> json) =>
        Register$Mutation$UserMutationResponse()
          ..errors = (json['errors'] as List<dynamic>?)
              ?.map((e) =>
                  Register$Mutation$UserMutationResponse$ErrorResponse.fromJson(
                      e as Map<String, dynamic>))
              .toList()
          ..user = json['user'] == null
              ? null
              : Register$Mutation$UserMutationResponse$User.fromJson(
                  json['user'] as Map<String, dynamic>)
          ..tokens = json['tokens'] == null
              ? null
              : Register$Mutation$UserMutationResponse$TokenResponse.fromJson(
                  json['tokens'] as Map<String, dynamic>);

Map<String, dynamic> _$Register$Mutation$UserMutationResponseToJson(
        Register$Mutation$UserMutationResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
      'user': instance.user?.toJson(),
      'tokens': instance.tokens?.toJson(),
    };

Register$Mutation _$Register$MutationFromJson(Map<String, dynamic> json) =>
    Register$Mutation()
      ..register = Register$Mutation$UserMutationResponse.fromJson(
          json['register'] as Map<String, dynamic>);

Map<String, dynamic> _$Register$MutationToJson(Register$Mutation instance) =>
    <String, dynamic>{
      'register': instance.register.toJson(),
    };

RegisterInput _$RegisterInputFromJson(Map<String, dynamic> json) =>
    RegisterInput(
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      birthday: json['birthday'] as String,
    );

Map<String, dynamic> _$RegisterInputToJson(RegisterInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'birthday': instance.birthday,
    };

LikeUnlikeComment$Mutation$LikeResponse
    _$LikeUnlikeComment$Mutation$LikeResponseFromJson(
            Map<String, dynamic> json) =>
        LikeUnlikeComment$Mutation$LikeResponse()
          ..value = json['value'] as int?
          ..clientId = json['clientId'] as String?;

Map<String, dynamic> _$LikeUnlikeComment$Mutation$LikeResponseToJson(
        LikeUnlikeComment$Mutation$LikeResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'clientId': instance.clientId,
    };

LikeUnlikeComment$Mutation _$LikeUnlikeComment$MutationFromJson(
        Map<String, dynamic> json) =>
    LikeUnlikeComment$Mutation()
      ..likeUnlikeComment = LikeUnlikeComment$Mutation$LikeResponse.fromJson(
          json['likeUnlikeComment'] as Map<String, dynamic>);

Map<String, dynamic> _$LikeUnlikeComment$MutationToJson(
        LikeUnlikeComment$Mutation instance) =>
    <String, dynamic>{
      'likeUnlikeComment': instance.likeUnlikeComment.toJson(),
    };

DeleteUserSearch$Mutation _$DeleteUserSearch$MutationFromJson(
        Map<String, dynamic> json) =>
    DeleteUserSearch$Mutation()
      ..deleteUserSearch = json['deleteUserSearch'] as bool;

Map<String, dynamic> _$DeleteUserSearch$MutationToJson(
        DeleteUserSearch$Mutation instance) =>
    <String, dynamic>{
      'deleteUserSearch': instance.deleteUserSearch,
    };

DeletePost$Mutation _$DeletePost$MutationFromJson(Map<String, dynamic> json) =>
    DeletePost$Mutation()..deletePost = json['deletePost'] as bool;

Map<String, dynamic> _$DeletePost$MutationToJson(
        DeletePost$Mutation instance) =>
    <String, dynamic>{
      'deletePost': instance.deletePost,
    };

ReplyComment$Mutation$CreateReplyResponse$Reply
    _$ReplyComment$Mutation$CreateReplyResponse$ReplyFromJson(
            Map<String, dynamic> json) =>
        ReplyComment$Mutation$CreateReplyResponse$Reply()
          ..$$typename = json['__typename'] as String?
          ..id = (json['id'] as num).toDouble()
          ..reply = json['reply'] as String
          ..userId = (json['user_id'] as num).toDouble()
          ..commentId = (json['comment_id'] as num).toDouble()
          ..postId = (json['post_id'] as num).toDouble()
          ..createdAt = json['createdAt'] as String
          ..likeCount = json['likeCount'] as int
          ..likeState = json['likeState'] as bool?
          ..user = ReplyFragmentMixin$User.fromJson(
              json['user'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) => ReplyFragmentMixin$ReplyUserTag.fromJson(
                  e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$ReplyComment$Mutation$CreateReplyResponse$ReplyToJson(
        ReplyComment$Mutation$CreateReplyResponse$Reply instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'reply': instance.reply,
      'user_id': instance.userId,
      'comment_id': instance.commentId,
      'post_id': instance.postId,
      'createdAt': instance.createdAt,
      'likeCount': instance.likeCount,
      'likeState': instance.likeState,
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
    };

ReplyComment$Mutation$CreateReplyResponse
    _$ReplyComment$Mutation$CreateReplyResponseFromJson(
            Map<String, dynamic> json) =>
        ReplyComment$Mutation$CreateReplyResponse()
          ..reply = json['reply'] == null
              ? null
              : ReplyComment$Mutation$CreateReplyResponse$Reply.fromJson(
                  json['reply'] as Map<String, dynamic>)
          ..commentId = json['commentId'] as int?
          ..postId = json['postId'] as int?
          ..error = json['error'] as bool?;

Map<String, dynamic> _$ReplyComment$Mutation$CreateReplyResponseToJson(
        ReplyComment$Mutation$CreateReplyResponse instance) =>
    <String, dynamic>{
      'reply': instance.reply?.toJson(),
      'commentId': instance.commentId,
      'postId': instance.postId,
      'error': instance.error,
    };

ReplyComment$Mutation _$ReplyComment$MutationFromJson(
        Map<String, dynamic> json) =>
    ReplyComment$Mutation()
      ..replyComment = ReplyComment$Mutation$CreateReplyResponse.fromJson(
          json['replyComment'] as Map<String, dynamic>);

Map<String, dynamic> _$ReplyComment$MutationToJson(
        ReplyComment$Mutation instance) =>
    <String, dynamic>{
      'replyComment': instance.replyComment.toJson(),
    };

ReplyFragmentMixin$User$FileResponse
    _$ReplyFragmentMixin$User$FileResponseFromJson(Map<String, dynamic> json) =>
        ReplyFragmentMixin$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic> _$ReplyFragmentMixin$User$FileResponseToJson(
        ReplyFragmentMixin$User$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

ReplyFragmentMixin$User _$ReplyFragmentMixin$UserFromJson(
        Map<String, dynamic> json) =>
    ReplyFragmentMixin$User()
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..smallFile = ReplyFragmentMixin$User$FileResponse.fromJson(
          json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic> _$ReplyFragmentMixin$UserToJson(
        ReplyFragmentMixin$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'smallFile': instance.smallFile.toJson(),
    };

ReplyFragmentMixin$ReplyUserTag _$ReplyFragmentMixin$ReplyUserTagFromJson(
        Map<String, dynamic> json) =>
    ReplyFragmentMixin$ReplyUserTag()
      ..replyId = json['reply_id'] as int
      ..userId = json['user_id'] as int
      ..userString = json['user_string'] as String;

Map<String, dynamic> _$ReplyFragmentMixin$ReplyUserTagToJson(
        ReplyFragmentMixin$ReplyUserTag instance) =>
    <String, dynamic>{
      'reply_id': instance.replyId,
      'user_id': instance.userId,
      'user_string': instance.userString,
    };

CreatePost$Mutation$CreatePostResponse$Post
    _$CreatePost$Mutation$CreatePostResponse$PostFromJson(
            Map<String, dynamic> json) =>
        CreatePost$Mutation$CreatePostResponse$Post()
          ..$$typename = json['__typename'] as String?
          ..id = (json['id'] as num).toDouble()
          ..file = PostFragmentMixin$FileResponse.fromJson(
              json['file'] as Map<String, dynamic>)
          ..user = PostFragmentMixin$User.fromJson(
              json['user'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) => PostFragmentMixin$CaptionUserTag.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..likeState = json['likeState'] as bool?
          ..likeCount = json['likeCount'] as int
          ..caption = json['caption'] as String
          ..createdAt = json['createdAt'] as String
          ..commentCount = json['commentCount'] as int
          ..viewsCount = json['viewsCount'] as int
          ..fileWidth = json['fileWidth'] as int
          ..fileHeight = json['fileHeight'] as int;

Map<String, dynamic> _$CreatePost$Mutation$CreatePostResponse$PostToJson(
        CreatePost$Mutation$CreatePostResponse$Post instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'file': instance.file.toJson(),
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
      'likeState': instance.likeState,
      'likeCount': instance.likeCount,
      'caption': instance.caption,
      'createdAt': instance.createdAt,
      'commentCount': instance.commentCount,
      'viewsCount': instance.viewsCount,
      'fileWidth': instance.fileWidth,
      'fileHeight': instance.fileHeight,
    };

CreatePost$Mutation$CreatePostResponse$ErrorResponse
    _$CreatePost$Mutation$CreatePostResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        CreatePost$Mutation$CreatePostResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic>
    _$CreatePost$Mutation$CreatePostResponse$ErrorResponseToJson(
            CreatePost$Mutation$CreatePostResponse$ErrorResponse instance) =>
        <String, dynamic>{
          'field': instance.field,
          'message': instance.message,
        };

CreatePost$Mutation$CreatePostResponse
    _$CreatePost$Mutation$CreatePostResponseFromJson(
            Map<String, dynamic> json) =>
        CreatePost$Mutation$CreatePostResponse()
          ..post = json['post'] == null
              ? null
              : CreatePost$Mutation$CreatePostResponse$Post.fromJson(
                  json['post'] as Map<String, dynamic>)
          ..error = json['error'] == null
              ? null
              : CreatePost$Mutation$CreatePostResponse$ErrorResponse.fromJson(
                  json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$CreatePost$Mutation$CreatePostResponseToJson(
        CreatePost$Mutation$CreatePostResponse instance) =>
    <String, dynamic>{
      'post': instance.post?.toJson(),
      'error': instance.error?.toJson(),
    };

CreatePost$Mutation _$CreatePost$MutationFromJson(Map<String, dynamic> json) =>
    CreatePost$Mutation()
      ..createPost = CreatePost$Mutation$CreatePostResponse.fromJson(
          json['createPost'] as Map<String, dynamic>);

Map<String, dynamic> _$CreatePost$MutationToJson(
        CreatePost$Mutation instance) =>
    <String, dynamic>{
      'createPost': instance.createPost.toJson(),
    };

PostFragmentMixin$FileResponse _$PostFragmentMixin$FileResponseFromJson(
        Map<String, dynamic> json) =>
    PostFragmentMixin$FileResponse()
      ..file = json['file'] as String?
      ..error = json['error'] as String?;

Map<String, dynamic> _$PostFragmentMixin$FileResponseToJson(
        PostFragmentMixin$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

PostFragmentMixin$User$FileResponse
    _$PostFragmentMixin$User$FileResponseFromJson(Map<String, dynamic> json) =>
        PostFragmentMixin$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic> _$PostFragmentMixin$User$FileResponseToJson(
        PostFragmentMixin$User$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

PostFragmentMixin$User _$PostFragmentMixin$UserFromJson(
        Map<String, dynamic> json) =>
    PostFragmentMixin$User()
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..smallFile = PostFragmentMixin$User$FileResponse.fromJson(
          json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic> _$PostFragmentMixin$UserToJson(
        PostFragmentMixin$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'smallFile': instance.smallFile.toJson(),
    };

PostFragmentMixin$CaptionUserTag _$PostFragmentMixin$CaptionUserTagFromJson(
        Map<String, dynamic> json) =>
    PostFragmentMixin$CaptionUserTag()
      ..postId = json['post_id'] as int
      ..userId = json['user_id'] as int
      ..userString = json['user_string'] as String;

Map<String, dynamic> _$PostFragmentMixin$CaptionUserTagToJson(
        PostFragmentMixin$CaptionUserTag instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'user_id': instance.userId,
      'user_string': instance.userString,
    };

FileDimsInput _$FileDimsInputFromJson(Map<String, dynamic> json) =>
    FileDimsInput(
      fileWidth: json['fileWidth'] as int,
      fileHeight: json['fileHeight'] as int,
    );

Map<String, dynamic> _$FileDimsInputToJson(FileDimsInput instance) =>
    <String, dynamic>{
      'fileWidth': instance.fileWidth,
      'fileHeight': instance.fileHeight,
    };

SignOut$Mutation _$SignOut$MutationFromJson(Map<String, dynamic> json) =>
    SignOut$Mutation()..signOut = json['signOut'] as bool;

Map<String, dynamic> _$SignOut$MutationToJson(SignOut$Mutation instance) =>
    <String, dynamic>{
      'signOut': instance.signOut,
    };

AddUserInterests$Mutation _$AddUserInterests$MutationFromJson(
        Map<String, dynamic> json) =>
    AddUserInterests$Mutation()
      ..addUserInterests = json['addUserInterests'] as bool;

Map<String, dynamic> _$AddUserInterests$MutationToJson(
        AddUserInterests$Mutation instance) =>
    <String, dynamic>{
      'addUserInterests': instance.addUserInterests,
    };

FollowUnfollowUser$Mutation$LikeResponse
    _$FollowUnfollowUser$Mutation$LikeResponseFromJson(
            Map<String, dynamic> json) =>
        FollowUnfollowUser$Mutation$LikeResponse()
          ..value = json['value'] as int?
          ..clientId = json['clientId'] as String?;

Map<String, dynamic> _$FollowUnfollowUser$Mutation$LikeResponseToJson(
        FollowUnfollowUser$Mutation$LikeResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'clientId': instance.clientId,
    };

FollowUnfollowUser$Mutation _$FollowUnfollowUser$MutationFromJson(
        Map<String, dynamic> json) =>
    FollowUnfollowUser$Mutation()
      ..followUnfollowUser = FollowUnfollowUser$Mutation$LikeResponse.fromJson(
          json['followUnfollowUser'] as Map<String, dynamic>);

Map<String, dynamic> _$FollowUnfollowUser$MutationToJson(
        FollowUnfollowUser$Mutation instance) =>
    <String, dynamic>{
      'followUnfollowUser': instance.followUnfollowUser.toJson(),
    };

SendResetPasswordEmail$Mutation _$SendResetPasswordEmail$MutationFromJson(
        Map<String, dynamic> json) =>
    SendResetPasswordEmail$Mutation()
      ..sendResetPasswordEmail = json['sendResetPasswordEmail'] as bool;

Map<String, dynamic> _$SendResetPasswordEmail$MutationToJson(
        SendResetPasswordEmail$Mutation instance) =>
    <String, dynamic>{
      'sendResetPasswordEmail': instance.sendResetPasswordEmail,
    };

Comments$Query$CommentResponse$Comment
    _$Comments$Query$CommentResponse$CommentFromJson(
            Map<String, dynamic> json) =>
        Comments$Query$CommentResponse$Comment()
          ..$$typename = json['__typename'] as String?
          ..id = (json['id'] as num).toDouble()
          ..comment = json['comment'] as String
          ..userId = (json['user_id'] as num).toDouble()
          ..postId = (json['post_id'] as num).toDouble()
          ..createdAt = json['createdAt'] as String
          ..replyCount = json['replyCount'] as int
          ..likeCount = json['likeCount'] as int
          ..likeState = json['likeState'] as bool?
          ..user = CommentFragmentMixin$User.fromJson(
              json['user'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) => CommentFragmentMixin$CommentUserTag.fromJson(
                  e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$Comments$Query$CommentResponse$CommentToJson(
        Comments$Query$CommentResponse$Comment instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'comment': instance.comment,
      'user_id': instance.userId,
      'post_id': instance.postId,
      'createdAt': instance.createdAt,
      'replyCount': instance.replyCount,
      'likeCount': instance.likeCount,
      'likeState': instance.likeState,
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
    };

Comments$Query$CommentResponse _$Comments$Query$CommentResponseFromJson(
        Map<String, dynamic> json) =>
    Comments$Query$CommentResponse()
      ..comments = (json['comments'] as List<dynamic>)
          .map((e) => Comments$Query$CommentResponse$Comment.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..hasMore = json['hasMore'] as bool
      ..postId = json['postId'] as int;

Map<String, dynamic> _$Comments$Query$CommentResponseToJson(
        Comments$Query$CommentResponse instance) =>
    <String, dynamic>{
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
      'postId': instance.postId,
    };

Comments$Query _$Comments$QueryFromJson(Map<String, dynamic> json) =>
    Comments$Query()
      ..comments = Comments$Query$CommentResponse.fromJson(
          json['comments'] as Map<String, dynamic>);

Map<String, dynamic> _$Comments$QueryToJson(Comments$Query instance) =>
    <String, dynamic>{
      'comments': instance.comments.toJson(),
    };

User$Query$User$FileResponse _$User$Query$User$FileResponseFromJson(
        Map<String, dynamic> json) =>
    User$Query$User$FileResponse()
      ..file = json['file'] as String?
      ..error = json['error'] as String?;

Map<String, dynamic> _$User$Query$User$FileResponseToJson(
        User$Query$User$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

User$Query$User _$User$Query$UserFromJson(Map<String, dynamic> json) =>
    User$Query$User()
      ..$$typename = json['__typename'] as String?
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..name = json['name'] as String
      ..email = json['email'] as String
      ..bio = json['bio'] as String
      ..file = User$Query$User$FileResponse.fromJson(
          json['file'] as Map<String, dynamic>)
      ..followState = json['followState'] as bool?
      ..followingCount = json['followingCount'] as int
      ..followersCount = json['followersCount'] as int
      ..postCount = json['postCount'] as int;

Map<String, dynamic> _$User$Query$UserToJson(User$Query$User instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'bio': instance.bio,
      'file': instance.file.toJson(),
      'followState': instance.followState,
      'followingCount': instance.followingCount,
      'followersCount': instance.followersCount,
      'postCount': instance.postCount,
    };

User$Query _$User$QueryFromJson(Map<String, dynamic> json) => User$Query()
  ..user = json['user'] == null
      ? null
      : User$Query$User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$User$QueryToJson(User$Query instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

SinglePost$Query$Post _$SinglePost$Query$PostFromJson(
        Map<String, dynamic> json) =>
    SinglePost$Query$Post()
      ..$$typename = json['__typename'] as String?
      ..id = (json['id'] as num).toDouble()
      ..file = PostFragmentMixin$FileResponse.fromJson(
          json['file'] as Map<String, dynamic>)
      ..user =
          PostFragmentMixin$User.fromJson(json['user'] as Map<String, dynamic>)
      ..userTags = (json['userTags'] as List<dynamic>)
          .map((e) => PostFragmentMixin$CaptionUserTag.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..likeState = json['likeState'] as bool?
      ..likeCount = json['likeCount'] as int
      ..caption = json['caption'] as String
      ..createdAt = json['createdAt'] as String
      ..commentCount = json['commentCount'] as int
      ..viewsCount = json['viewsCount'] as int
      ..fileWidth = json['fileWidth'] as int
      ..fileHeight = json['fileHeight'] as int;

Map<String, dynamic> _$SinglePost$Query$PostToJson(
        SinglePost$Query$Post instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'file': instance.file.toJson(),
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
      'likeState': instance.likeState,
      'likeCount': instance.likeCount,
      'caption': instance.caption,
      'createdAt': instance.createdAt,
      'commentCount': instance.commentCount,
      'viewsCount': instance.viewsCount,
      'fileWidth': instance.fileWidth,
      'fileHeight': instance.fileHeight,
    };

SinglePost$Query _$SinglePost$QueryFromJson(Map<String, dynamic> json) =>
    SinglePost$Query()
      ..singlePost = json['singlePost'] == null
          ? null
          : SinglePost$Query$Post.fromJson(
              json['singlePost'] as Map<String, dynamic>);

Map<String, dynamic> _$SinglePost$QueryToJson(SinglePost$Query instance) =>
    <String, dynamic>{
      'singlePost': instance.singlePost?.toJson(),
    };

AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenre
    _$AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenreFromJson(
            Map<String, dynamic> json) =>
        AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenre()
          ..id = json['id'] as int
          ..videogameGenre = json['videogame_genre'] as String;

Map<String, dynamic>
    _$AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenreToJson(
            AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenre
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'videogame_genre': instance.videogameGenre,
        };

AllVideogames$Query$Videogame$VideogameGenreVideogame
    _$AllVideogames$Query$Videogame$VideogameGenreVideogameFromJson(
            Map<String, dynamic> json) =>
        AllVideogames$Query$Videogame$VideogameGenreVideogame()
          ..videogameGenre =
              AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenre
                  .fromJson(json['videogameGenre'] as Map<String, dynamic>);

Map<String, dynamic>
    _$AllVideogames$Query$Videogame$VideogameGenreVideogameToJson(
            AllVideogames$Query$Videogame$VideogameGenreVideogame instance) =>
        <String, dynamic>{
          'videogameGenre': instance.videogameGenre.toJson(),
        };

AllVideogames$Query$Videogame _$AllVideogames$Query$VideogameFromJson(
        Map<String, dynamic> json) =>
    AllVideogames$Query$Videogame()
      ..id = json['id'] as int
      ..name = json['name'] as String
      ..postCount = json['postCount'] as int
      ..tapCount = json['tapCount'] as int
      ..file = VideogameFragmentMixin$FileResponse.fromJson(
          json['file'] as Map<String, dynamic>)
      ..videogameGenre = (json['videogameGenre'] as List<dynamic>)
          .map((e) =>
              AllVideogames$Query$Videogame$VideogameGenreVideogame.fromJson(
                  e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AllVideogames$Query$VideogameToJson(
        AllVideogames$Query$Videogame instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'postCount': instance.postCount,
      'tapCount': instance.tapCount,
      'file': instance.file.toJson(),
      'videogameGenre': instance.videogameGenre.map((e) => e.toJson()).toList(),
    };

AllVideogames$Query _$AllVideogames$QueryFromJson(Map<String, dynamic> json) =>
    AllVideogames$Query()
      ..allVideogames = (json['allVideogames'] as List<dynamic>)
          .map((e) =>
              AllVideogames$Query$Videogame.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AllVideogames$QueryToJson(
        AllVideogames$Query instance) =>
    <String, dynamic>{
      'allVideogames': instance.allVideogames.map((e) => e.toJson()).toList(),
    };

VideogameFragmentMixin$FileResponse
    _$VideogameFragmentMixin$FileResponseFromJson(Map<String, dynamic> json) =>
        VideogameFragmentMixin$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic> _$VideogameFragmentMixin$FileResponseToJson(
        VideogameFragmentMixin$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

AllTapsVideogames$Query$Videogame _$AllTapsVideogames$Query$VideogameFromJson(
        Map<String, dynamic> json) =>
    AllTapsVideogames$Query$Videogame()
      ..id = json['id'] as int
      ..name = json['name'] as String
      ..postCount = json['postCount'] as int
      ..tapCount = json['tapCount'] as int
      ..file = VideogameFragmentMixin$FileResponse.fromJson(
          json['file'] as Map<String, dynamic>);

Map<String, dynamic> _$AllTapsVideogames$Query$VideogameToJson(
        AllTapsVideogames$Query$Videogame instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'postCount': instance.postCount,
      'tapCount': instance.tapCount,
      'file': instance.file.toJson(),
    };

AllTapsVideogames$Query _$AllTapsVideogames$QueryFromJson(
        Map<String, dynamic> json) =>
    AllTapsVideogames$Query()
      ..allTapsVideogames = (json['allTapsVideogames'] as List<dynamic>)
          .map((e) => AllTapsVideogames$Query$Videogame.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AllTapsVideogames$QueryToJson(
        AllTapsVideogames$Query instance) =>
    <String, dynamic>{
      'allTapsVideogames':
          instance.allTapsVideogames.map((e) => e.toJson()).toList(),
    };

Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$LikeFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like()
          ..user =
              Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User
                  .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$LikeToJson(
            Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like
                instance) =>
        <String, dynamic>{
          'user': instance.user.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$PostFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post()
          ..id = (json['id'] as num).toDouble()
          ..likeCount = json['likeCount'] as int
          ..fileImg =
              Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponse
                  .fromJson(json['fileImg'] as Map<String, dynamic>)
          ..likes = (json['likes'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$PostToJson(
            Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'likeCount': instance.likeCount,
          'fileImg': instance.fileImg.toJson(),
          'likes': instance.likes.map((e) => e.toJson()).toList(),
        };

Notifications$Query$PaginatedNotifications$Notification$LikeNotification
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$LikeNotification()
          ..post =
              Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post
                  .fromJson(json['post'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$LikeNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$LikeNotification
                instance) =>
        <String, dynamic>{
          'post': instance.post.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$PostFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post()
          ..id = (json['id'] as num).toDouble()
          ..fileImg =
              Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponse
                  .fromJson(json['fileImg'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$PostToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'fileImg': instance.fileImg.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$CommentFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment()
          ..id = (json['id'] as num).toDouble()
          ..post =
              Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post
                  .fromJson(json['post'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$CommentToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'post': instance.post.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTag
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTagFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTag()
          ..replyId = json['reply_id'] as int
          ..userId = json['user_id'] as int
          ..userString = json['user_string'] as String;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTagToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTag
                instance) =>
        <String, dynamic>{
          'reply_id': instance.replyId,
          'user_id': instance.userId,
          'user_string': instance.userString,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLikeFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike()
          ..user =
              Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User
                  .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLikeToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike
                instance) =>
        <String, dynamic>{
          'user': instance.user.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$ReplyFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply()
          ..id = (json['id'] as num).toDouble()
          ..reply = json['reply'] as String
          ..comment =
              Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment
                  .fromJson(json['comment'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTag
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..likeCount = json['likeCount'] as int
          ..likes = (json['likes'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$ReplyToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'reply': instance.reply,
          'comment': instance.comment.toJson(),
          'userTags': instance.userTags.map((e) => e.toJson()).toList(),
          'likeCount': instance.likeCount,
          'likes': instance.likes.map((e) => e.toJson()).toList(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification()
          ..reply =
              Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply
                  .fromJson(json['reply'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification
                instance) =>
        <String, dynamic>{
          'reply': instance.reply.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTag
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTagFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTag()
          ..commentId = json['comment_id'] as int
          ..userId = json['user_id'] as int
          ..userString = json['user_string'] as String;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTagToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTag
                instance) =>
        <String, dynamic>{
          'comment_id': instance.commentId,
          'user_id': instance.userId,
          'user_string': instance.userString,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$PostFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post()
          ..id = (json['id'] as num).toDouble()
          ..fileImg =
              Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponse
                  .fromJson(json['fileImg'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$PostToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'fileImg': instance.fileImg.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLikeFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike()
          ..user =
              Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User
                  .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLikeToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike
                instance) =>
        <String, dynamic>{
          'user': instance.user.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$CommentFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment()
          ..id = (json['id'] as num).toDouble()
          ..comment = json['comment'] as String
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTag
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..post =
              Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post
                  .fromJson(json['post'] as Map<String, dynamic>)
          ..likeCount = json['likeCount'] as int
          ..likes = (json['likes'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$CommentToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'comment': instance.comment,
          'userTags': instance.userTags.map((e) => e.toJson()).toList(),
          'post': instance.post.toJson(),
          'likeCount': instance.likeCount,
          'likes': instance.likes.map((e) => e.toJson()).toList(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification()
          ..comment =
              Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment
                  .fromJson(json['comment'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification
                instance) =>
        <String, dynamic>{
          'comment': instance.comment.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
          'error': instance.error,
        };

Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User
    _$Notifications$Query$PaginatedNotifications$Notification$FollowNotification$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..followState = json['followState'] as bool?
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$FollowNotification$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'followState': instance.followState,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$FollowNotification
    _$Notifications$Query$PaginatedNotifications$Notification$FollowNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$FollowNotification()
          ..follower =
              Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User
                  .fromJson(json['follower'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$FollowNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$FollowNotification
                instance) =>
        <String, dynamic>{
          'follower': instance.follower.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$PostFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post()
          ..id = (json['id'] as num).toDouble()
          ..fileImg =
              Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponse
                  .fromJson(json['fileImg'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$PostToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'fileImg': instance.fileImg.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTag
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTagFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTag()
          ..commentId = json['comment_id'] as int
          ..userId = json['user_id'] as int
          ..userString = json['user_string'] as String;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTagToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTag
                instance) =>
        <String, dynamic>{
          'comment_id': instance.commentId,
          'user_id': instance.userId,
          'user_string': instance.userString,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$CommentFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment()
          ..id = (json['id'] as num).toDouble()
          ..comment = json['comment'] as String
          ..post =
              Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post
                  .fromJson(json['post'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTag
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..user =
              Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User
                  .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$CommentToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'comment': instance.comment,
          'post': instance.post.toJson(),
          'userTags': instance.userTags.map((e) => e.toJson()).toList(),
          'user': instance.user.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentNotification
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentNotification()
          ..comment =
              Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment
                  .fromJson(json['comment'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentNotification
                instance) =>
        <String, dynamic>{
          'comment': instance.comment.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$PostFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post()
          ..id = (json['id'] as num).toDouble()
          ..fileImg =
              Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponse
                  .fromJson(json['fileImg'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$PostToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'fileImg': instance.fileImg.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$CommentFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment()
          ..id = (json['id'] as num).toDouble()
          ..post =
              Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post
                  .fromJson(json['post'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$CommentToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'post': instance.post.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTag
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTagFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTag()
          ..replyId = json['reply_id'] as int
          ..userId = json['user_id'] as int
          ..userString = json['user_string'] as String;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTagToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTag
                instance) =>
        <String, dynamic>{
          'reply_id': instance.replyId,
          'user_id': instance.userId,
          'user_string': instance.userString,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$ReplyFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply()
          ..id = (json['id'] as num).toDouble()
          ..reply = json['reply'] as String
          ..comment =
              Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment
                  .fromJson(json['comment'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTag
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..user =
              Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User
                  .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$ReplyToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'reply': instance.reply,
          'comment': instance.comment.toJson(),
          'userTags': instance.userTags.map((e) => e.toJson()).toList(),
          'user': instance.user.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyNotification
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyNotification()
          ..reply =
              Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply
                  .fromJson(json['reply'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyNotification
                instance) =>
        <String, dynamic>{
          'reply': instance.reply.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$PostFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post()
          ..id = (json['id'] as num).toDouble()
          ..fileImg =
              Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponse
                  .fromJson(json['fileImg'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$PostToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'fileImg': instance.fileImg.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTag
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTagFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTag()
          ..commentId = json['comment_id'] as int
          ..userId = json['user_id'] as int
          ..userString = json['user_string'] as String;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTagToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTag
                instance) =>
        <String, dynamic>{
          'comment_id': instance.commentId,
          'user_id': instance.userId,
          'user_string': instance.userString,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$CommentFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment()
          ..id = (json['id'] as num).toDouble()
          ..comment = json['comment'] as String
          ..post =
              Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post
                  .fromJson(json['post'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTag
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..user =
              Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User
                  .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$CommentToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'comment': instance.comment,
          'post': instance.post.toJson(),
          'userTags': instance.userTags.map((e) => e.toJson()).toList(),
          'user': instance.user.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification()
          ..comment =
              Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment
                  .fromJson(json['comment'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification
                instance) =>
        <String, dynamic>{
          'comment': instance.comment.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$PostFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post()
          ..id = (json['id'] as num).toDouble()
          ..fileImg =
              Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponse
                  .fromJson(json['fileImg'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$PostToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'fileImg': instance.fileImg.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$CommentFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment()
          ..id = (json['id'] as num).toDouble()
          ..post =
              Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post
                  .fromJson(json['post'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$CommentToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'post': instance.post.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTag
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTagFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTag()
          ..replyId = json['reply_id'] as int
          ..userId = json['user_id'] as int
          ..userString = json['user_string'] as String;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTagToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTag
                instance) =>
        <String, dynamic>{
          'reply_id': instance.replyId,
          'user_id': instance.userId,
          'user_string': instance.userString,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$ReplyFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply()
          ..id = (json['id'] as num).toDouble()
          ..reply = json['reply'] as String
          ..comment =
              Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment
                  .fromJson(json['comment'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTag
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..user =
              Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User
                  .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$ReplyToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'reply': instance.reply,
          'comment': instance.comment.toJson(),
          'userTags': instance.userTags.map((e) => e.toJson()).toList(),
          'user': instance.user.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification()
          ..reply =
              Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply
                  .fromJson(json['reply'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification
                instance) =>
        <String, dynamic>{
          'reply': instance.reply.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTag
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTagFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTag()
          ..postId = json['post_id'] as int
          ..userId = json['user_id'] as int
          ..userString = json['user_string'] as String;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTagToJson(
            Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTag
                instance) =>
        <String, dynamic>{
          'post_id': instance.postId,
          'user_id': instance.userId,
          'user_string': instance.userString,
        };

Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponse
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponse()
          ..file = json['file'] as String?;

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponseToJson(
            Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponse
                instance) =>
        <String, dynamic>{
          'file': instance.file,
        };

Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$UserFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..smallFile =
              Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponse
                  .fromJson(json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$UserToJson(
            Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'smallFile': instance.smallFile.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$PostFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post()
          ..id = (json['id'] as num).toDouble()
          ..fileImg =
              Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponse
                  .fromJson(json['fileImg'] as Map<String, dynamic>)
          ..caption = json['caption'] as String
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTag
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..user =
              Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User
                  .fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$PostToJson(
            Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'fileImg': instance.fileImg.toJson(),
          'caption': instance.caption,
          'userTags': instance.userTags.map((e) => e.toJson()).toList(),
          'user': instance.user.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification()
          ..post =
              Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post
                  .fromJson(json['post'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification
                instance) =>
        <String, dynamic>{
          'post': instance.post.toJson(),
        };

Notifications$Query$PaginatedNotifications$Notification
    _$Notifications$Query$PaginatedNotifications$NotificationFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications$Notification()
          ..type = json['type'] as String
          ..parentId = json['parent_id'] as int
          ..concatenatedId = json['concatenated_id'] as String
          ..updatedAt = json['updatedAt'] as String
          ..createdAt = json['createdAt'] as String
          ..likeNotification = json['likeNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$LikeNotification
                  .fromJson(json['likeNotification'] as Map<String, dynamic>)
          ..likeReplyNotification = json['likeReplyNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification
                  .fromJson(
                      json['likeReplyNotification'] as Map<String, dynamic>)
          ..likeCommentNotification = json['likeCommentNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification
                  .fromJson(
                      json['likeCommentNotification'] as Map<String, dynamic>)
          ..followNotification = json['followNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$FollowNotification
                  .fromJson(json['followNotification'] as Map<String, dynamic>)
          ..commentNotification = json['commentNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$CommentNotification
                  .fromJson(json['commentNotification'] as Map<String, dynamic>)
          ..replyNotification = json['replyNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$ReplyNotification
                  .fromJson(json['replyNotification'] as Map<String, dynamic>)
          ..commentTagNotification = json['commentTagNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification
                  .fromJson(
                      json['commentTagNotification'] as Map<String, dynamic>)
          ..replyTagNotification = json['replyTagNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification
                  .fromJson(
                      json['replyTagNotification'] as Map<String, dynamic>)
          ..captionTagNotification = json['captionTagNotification'] == null
              ? null
              : Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification
                  .fromJson(
                      json['captionTagNotification'] as Map<String, dynamic>);

Map<String, dynamic>
    _$Notifications$Query$PaginatedNotifications$NotificationToJson(
            Notifications$Query$PaginatedNotifications$Notification instance) =>
        <String, dynamic>{
          'type': instance.type,
          'parent_id': instance.parentId,
          'concatenated_id': instance.concatenatedId,
          'updatedAt': instance.updatedAt,
          'createdAt': instance.createdAt,
          'likeNotification': instance.likeNotification?.toJson(),
          'likeReplyNotification': instance.likeReplyNotification?.toJson(),
          'likeCommentNotification': instance.likeCommentNotification?.toJson(),
          'followNotification': instance.followNotification?.toJson(),
          'commentNotification': instance.commentNotification?.toJson(),
          'replyNotification': instance.replyNotification?.toJson(),
          'commentTagNotification': instance.commentTagNotification?.toJson(),
          'replyTagNotification': instance.replyTagNotification?.toJson(),
          'captionTagNotification': instance.captionTagNotification?.toJson(),
        };

Notifications$Query$PaginatedNotifications
    _$Notifications$Query$PaginatedNotificationsFromJson(
            Map<String, dynamic> json) =>
        Notifications$Query$PaginatedNotifications()
          ..notifications = (json['notifications'] as List<dynamic>)
              .map((e) =>
                  Notifications$Query$PaginatedNotifications$Notification
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$Notifications$Query$PaginatedNotificationsToJson(
        Notifications$Query$PaginatedNotifications instance) =>
    <String, dynamic>{
      'notifications': instance.notifications.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

Notifications$Query _$Notifications$QueryFromJson(Map<String, dynamic> json) =>
    Notifications$Query()
      ..notifications = Notifications$Query$PaginatedNotifications.fromJson(
          json['notifications'] as Map<String, dynamic>);

Map<String, dynamic> _$Notifications$QueryToJson(
        Notifications$Query instance) =>
    <String, dynamic>{
      'notifications': instance.notifications.toJson(),
    };

UserFollowers$Query$PaginatedFollow$User$FileResponse
    _$UserFollowers$Query$PaginatedFollow$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        UserFollowers$Query$PaginatedFollow$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic>
    _$UserFollowers$Query$PaginatedFollow$User$FileResponseToJson(
            UserFollowers$Query$PaginatedFollow$User$FileResponse instance) =>
        <String, dynamic>{
          'file': instance.file,
          'error': instance.error,
        };

UserFollowers$Query$PaginatedFollow$User
    _$UserFollowers$Query$PaginatedFollow$UserFromJson(
            Map<String, dynamic> json) =>
        UserFollowers$Query$PaginatedFollow$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..smallFile =
              UserFollowers$Query$PaginatedFollow$User$FileResponse.fromJson(
                  json['smallFile'] as Map<String, dynamic>)
          ..followState = json['followState'] as bool?
          ..createdAt = json['createdAt'] as String;

Map<String, dynamic> _$UserFollowers$Query$PaginatedFollow$UserToJson(
        UserFollowers$Query$PaginatedFollow$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'smallFile': instance.smallFile.toJson(),
      'followState': instance.followState,
      'createdAt': instance.createdAt,
    };

UserFollowers$Query$PaginatedFollow
    _$UserFollowers$Query$PaginatedFollowFromJson(Map<String, dynamic> json) =>
        UserFollowers$Query$PaginatedFollow()
          ..users = (json['users'] as List<dynamic>)
              .map((e) => UserFollowers$Query$PaginatedFollow$User.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool
          ..userId = json['userId'] as int;

Map<String, dynamic> _$UserFollowers$Query$PaginatedFollowToJson(
        UserFollowers$Query$PaginatedFollow instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
      'userId': instance.userId,
    };

UserFollowers$Query _$UserFollowers$QueryFromJson(Map<String, dynamic> json) =>
    UserFollowers$Query()
      ..userFollowers = UserFollowers$Query$PaginatedFollow.fromJson(
          json['userFollowers'] as Map<String, dynamic>);

Map<String, dynamic> _$UserFollowers$QueryToJson(
        UserFollowers$Query instance) =>
    <String, dynamic>{
      'userFollowers': instance.userFollowers.toJson(),
    };

VerifyResetCode$Query _$VerifyResetCode$QueryFromJson(
        Map<String, dynamic> json) =>
    VerifyResetCode$Query()..verifyResetCode = json['verifyResetCode'] as bool;

Map<String, dynamic> _$VerifyResetCode$QueryToJson(
        VerifyResetCode$Query instance) =>
    <String, dynamic>{
      'verifyResetCode': instance.verifyResetCode,
    };

SearchedUsers$Query$UserSearch$User$FileResponse
    _$SearchedUsers$Query$UserSearch$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        SearchedUsers$Query$UserSearch$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic> _$SearchedUsers$Query$UserSearch$User$FileResponseToJson(
        SearchedUsers$Query$UserSearch$User$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

SearchedUsers$Query$UserSearch$User
    _$SearchedUsers$Query$UserSearch$UserFromJson(Map<String, dynamic> json) =>
        SearchedUsers$Query$UserSearch$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..file = SearchedUsers$Query$UserSearch$User$FileResponse.fromJson(
              json['file'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchedUsers$Query$UserSearch$UserToJson(
        SearchedUsers$Query$UserSearch$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'file': instance.file.toJson(),
    };

SearchedUsers$Query$UserSearch _$SearchedUsers$Query$UserSearchFromJson(
        Map<String, dynamic> json) =>
    SearchedUsers$Query$UserSearch()
      ..searchedUserId = json['searchedUserId'] as int
      ..searchedUser = SearchedUsers$Query$UserSearch$User.fromJson(
          json['searchedUser'] as Map<String, dynamic>)
      ..updatedAt = json['updatedAt'] as String;

Map<String, dynamic> _$SearchedUsers$Query$UserSearchToJson(
        SearchedUsers$Query$UserSearch instance) =>
    <String, dynamic>{
      'searchedUserId': instance.searchedUserId,
      'searchedUser': instance.searchedUser.toJson(),
      'updatedAt': instance.updatedAt,
    };

SearchedUsers$Query _$SearchedUsers$QueryFromJson(Map<String, dynamic> json) =>
    SearchedUsers$Query()
      ..searchedUsers = (json['searchedUsers'] as List<dynamic>)
          .map((e) => SearchedUsers$Query$UserSearch.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchedUsers$QueryToJson(
        SearchedUsers$Query instance) =>
    <String, dynamic>{
      'searchedUsers': instance.searchedUsers.map((e) => e.toJson()).toList(),
    };

VideogamePosts$Query$PaginatedPosts$Post
    _$VideogamePosts$Query$PaginatedPosts$PostFromJson(
            Map<String, dynamic> json) =>
        VideogamePosts$Query$PaginatedPosts$Post()
          ..$$typename = json['__typename'] as String?
          ..id = (json['id'] as num).toDouble()
          ..file = PostFragmentMixin$FileResponse.fromJson(
              json['file'] as Map<String, dynamic>)
          ..user = PostFragmentMixin$User.fromJson(
              json['user'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) => PostFragmentMixin$CaptionUserTag.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..likeState = json['likeState'] as bool?
          ..likeCount = json['likeCount'] as int
          ..caption = json['caption'] as String
          ..createdAt = json['createdAt'] as String
          ..commentCount = json['commentCount'] as int
          ..viewsCount = json['viewsCount'] as int
          ..fileWidth = json['fileWidth'] as int
          ..fileHeight = json['fileHeight'] as int;

Map<String, dynamic> _$VideogamePosts$Query$PaginatedPosts$PostToJson(
        VideogamePosts$Query$PaginatedPosts$Post instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'file': instance.file.toJson(),
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
      'likeState': instance.likeState,
      'likeCount': instance.likeCount,
      'caption': instance.caption,
      'createdAt': instance.createdAt,
      'commentCount': instance.commentCount,
      'viewsCount': instance.viewsCount,
      'fileWidth': instance.fileWidth,
      'fileHeight': instance.fileHeight,
    };

VideogamePosts$Query$PaginatedPosts
    _$VideogamePosts$Query$PaginatedPostsFromJson(Map<String, dynamic> json) =>
        VideogamePosts$Query$PaginatedPosts()
          ..posts = (json['posts'] as List<dynamic>)
              .map((e) => VideogamePosts$Query$PaginatedPosts$Post.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$VideogamePosts$Query$PaginatedPostsToJson(
        VideogamePosts$Query$PaginatedPosts instance) =>
    <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

VideogamePosts$Query _$VideogamePosts$QueryFromJson(
        Map<String, dynamic> json) =>
    VideogamePosts$Query()
      ..videogamePosts = VideogamePosts$Query$PaginatedPosts.fromJson(
          json['videogamePosts'] as Map<String, dynamic>);

Map<String, dynamic> _$VideogamePosts$QueryToJson(
        VideogamePosts$Query instance) =>
    <String, dynamic>{
      'videogamePosts': instance.videogamePosts.toJson(),
    };

Me$Query$User$FileResponse _$Me$Query$User$FileResponseFromJson(
        Map<String, dynamic> json) =>
    Me$Query$User$FileResponse()
      ..file = json['file'] as String?
      ..error = json['error'] as String?;

Map<String, dynamic> _$Me$Query$User$FileResponseToJson(
        Me$Query$User$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

Me$Query$User _$Me$Query$UserFromJson(Map<String, dynamic> json) =>
    Me$Query$User()
      ..$$typename = json['__typename'] as String?
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..name = json['name'] as String
      ..email = json['email'] as String
      ..bio = json['bio'] as String
      ..file = Me$Query$User$FileResponse.fromJson(
          json['file'] as Map<String, dynamic>)
      ..smallFile = Me$Query$User$FileResponse.fromJson(
          json['smallFile'] as Map<String, dynamic>)
      ..followState = json['followState'] as bool?
      ..followingCount = json['followingCount'] as int
      ..followersCount = json['followersCount'] as int;

Map<String, dynamic> _$Me$Query$UserToJson(Me$Query$User instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'bio': instance.bio,
      'file': instance.file.toJson(),
      'smallFile': instance.smallFile.toJson(),
      'followState': instance.followState,
      'followingCount': instance.followingCount,
      'followersCount': instance.followersCount,
    };

Me$Query _$Me$QueryFromJson(Map<String, dynamic> json) =>
    Me$Query()..me = Me$Query$User.fromJson(json['me'] as Map<String, dynamic>);

Map<String, dynamic> _$Me$QueryToJson(Me$Query instance) => <String, dynamic>{
      'me': instance.me.toJson(),
    };

AllVideogameGenres$Query$VideogameGenre
    _$AllVideogameGenres$Query$VideogameGenreFromJson(
            Map<String, dynamic> json) =>
        AllVideogameGenres$Query$VideogameGenre()
          ..id = json['id'] as int
          ..videogameGenre = json['videogame_genre'] as String;

Map<String, dynamic> _$AllVideogameGenres$Query$VideogameGenreToJson(
        AllVideogameGenres$Query$VideogameGenre instance) =>
    <String, dynamic>{
      'id': instance.id,
      'videogame_genre': instance.videogameGenre,
    };

AllVideogameGenres$Query _$AllVideogameGenres$QueryFromJson(
        Map<String, dynamic> json) =>
    AllVideogameGenres$Query()
      ..allVideogameGenres = (json['allVideogameGenres'] as List<dynamic>)
          .map((e) => AllVideogameGenres$Query$VideogameGenre.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AllVideogameGenres$QueryToJson(
        AllVideogameGenres$Query instance) =>
    <String, dynamic>{
      'allVideogameGenres':
          instance.allVideogameGenres.map((e) => e.toJson()).toList(),
    };

FollowingPosts$Query$PaginatedPosts$Post
    _$FollowingPosts$Query$PaginatedPosts$PostFromJson(
            Map<String, dynamic> json) =>
        FollowingPosts$Query$PaginatedPosts$Post()
          ..$$typename = json['__typename'] as String?
          ..id = (json['id'] as num).toDouble()
          ..file = PostFragmentMixin$FileResponse.fromJson(
              json['file'] as Map<String, dynamic>)
          ..user = PostFragmentMixin$User.fromJson(
              json['user'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) => PostFragmentMixin$CaptionUserTag.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..likeState = json['likeState'] as bool?
          ..likeCount = json['likeCount'] as int
          ..caption = json['caption'] as String
          ..createdAt = json['createdAt'] as String
          ..commentCount = json['commentCount'] as int
          ..viewsCount = json['viewsCount'] as int
          ..fileWidth = json['fileWidth'] as int
          ..fileHeight = json['fileHeight'] as int;

Map<String, dynamic> _$FollowingPosts$Query$PaginatedPosts$PostToJson(
        FollowingPosts$Query$PaginatedPosts$Post instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'file': instance.file.toJson(),
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
      'likeState': instance.likeState,
      'likeCount': instance.likeCount,
      'caption': instance.caption,
      'createdAt': instance.createdAt,
      'commentCount': instance.commentCount,
      'viewsCount': instance.viewsCount,
      'fileWidth': instance.fileWidth,
      'fileHeight': instance.fileHeight,
    };

FollowingPosts$Query$PaginatedPosts
    _$FollowingPosts$Query$PaginatedPostsFromJson(Map<String, dynamic> json) =>
        FollowingPosts$Query$PaginatedPosts()
          ..posts = (json['posts'] as List<dynamic>)
              .map((e) => FollowingPosts$Query$PaginatedPosts$Post.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$FollowingPosts$Query$PaginatedPostsToJson(
        FollowingPosts$Query$PaginatedPosts instance) =>
    <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

FollowingPosts$Query _$FollowingPosts$QueryFromJson(
        Map<String, dynamic> json) =>
    FollowingPosts$Query()
      ..followingPosts = FollowingPosts$Query$PaginatedPosts.fromJson(
          json['followingPosts'] as Map<String, dynamic>);

Map<String, dynamic> _$FollowingPosts$QueryToJson(
        FollowingPosts$Query instance) =>
    <String, dynamic>{
      'followingPosts': instance.followingPosts.toJson(),
    };

SearchUsers$Query$User$FileResponse
    _$SearchUsers$Query$User$FileResponseFromJson(Map<String, dynamic> json) =>
        SearchUsers$Query$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic> _$SearchUsers$Query$User$FileResponseToJson(
        SearchUsers$Query$User$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

SearchUsers$Query$User _$SearchUsers$Query$UserFromJson(
        Map<String, dynamic> json) =>
    SearchUsers$Query$User()
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..name = json['name'] as String
      ..smallFile = SearchUsers$Query$User$FileResponse.fromJson(
          json['smallFile'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchUsers$Query$UserToJson(
        SearchUsers$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'smallFile': instance.smallFile.toJson(),
    };

SearchUsers$Query _$SearchUsers$QueryFromJson(Map<String, dynamic> json) =>
    SearchUsers$Query()
      ..searchUsers = (json['searchUsers'] as List<dynamic>)
          .map(
              (e) => SearchUsers$Query$User.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchUsers$QueryToJson(SearchUsers$Query instance) =>
    <String, dynamic>{
      'searchUsers': instance.searchUsers.map((e) => e.toJson()).toList(),
    };

UserFollowing$Query$PaginatedFollow$User$FileResponse
    _$UserFollowing$Query$PaginatedFollow$User$FileResponseFromJson(
            Map<String, dynamic> json) =>
        UserFollowing$Query$PaginatedFollow$User$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic>
    _$UserFollowing$Query$PaginatedFollow$User$FileResponseToJson(
            UserFollowing$Query$PaginatedFollow$User$FileResponse instance) =>
        <String, dynamic>{
          'file': instance.file,
          'error': instance.error,
        };

UserFollowing$Query$PaginatedFollow$User
    _$UserFollowing$Query$PaginatedFollow$UserFromJson(
            Map<String, dynamic> json) =>
        UserFollowing$Query$PaginatedFollow$User()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..smallFile =
              UserFollowing$Query$PaginatedFollow$User$FileResponse.fromJson(
                  json['smallFile'] as Map<String, dynamic>)
          ..followState = json['followState'] as bool?
          ..createdAt = json['createdAt'] as String;

Map<String, dynamic> _$UserFollowing$Query$PaginatedFollow$UserToJson(
        UserFollowing$Query$PaginatedFollow$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'smallFile': instance.smallFile.toJson(),
      'followState': instance.followState,
      'createdAt': instance.createdAt,
    };

UserFollowing$Query$PaginatedFollow
    _$UserFollowing$Query$PaginatedFollowFromJson(Map<String, dynamic> json) =>
        UserFollowing$Query$PaginatedFollow()
          ..users = (json['users'] as List<dynamic>)
              .map((e) => UserFollowing$Query$PaginatedFollow$User.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool
          ..userId = json['userId'] as int;

Map<String, dynamic> _$UserFollowing$Query$PaginatedFollowToJson(
        UserFollowing$Query$PaginatedFollow instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
      'userId': instance.userId,
    };

UserFollowing$Query _$UserFollowing$QueryFromJson(Map<String, dynamic> json) =>
    UserFollowing$Query()
      ..userFollowing = UserFollowing$Query$PaginatedFollow.fromJson(
          json['userFollowing'] as Map<String, dynamic>);

Map<String, dynamic> _$UserFollowing$QueryToJson(
        UserFollowing$Query instance) =>
    <String, dynamic>{
      'userFollowing': instance.userFollowing.toJson(),
    };

Replies$Query$ReplyResponse$Reply _$Replies$Query$ReplyResponse$ReplyFromJson(
        Map<String, dynamic> json) =>
    Replies$Query$ReplyResponse$Reply()
      ..$$typename = json['__typename'] as String?
      ..id = (json['id'] as num).toDouble()
      ..reply = json['reply'] as String
      ..userId = (json['user_id'] as num).toDouble()
      ..commentId = (json['comment_id'] as num).toDouble()
      ..postId = (json['post_id'] as num).toDouble()
      ..createdAt = json['createdAt'] as String
      ..likeCount = json['likeCount'] as int
      ..likeState = json['likeState'] as bool?
      ..user =
          ReplyFragmentMixin$User.fromJson(json['user'] as Map<String, dynamic>)
      ..userTags = (json['userTags'] as List<dynamic>)
          .map((e) => ReplyFragmentMixin$ReplyUserTag.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$Replies$Query$ReplyResponse$ReplyToJson(
        Replies$Query$ReplyResponse$Reply instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'reply': instance.reply,
      'user_id': instance.userId,
      'comment_id': instance.commentId,
      'post_id': instance.postId,
      'createdAt': instance.createdAt,
      'likeCount': instance.likeCount,
      'likeState': instance.likeState,
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
    };

Replies$Query$ReplyResponse _$Replies$Query$ReplyResponseFromJson(
        Map<String, dynamic> json) =>
    Replies$Query$ReplyResponse()
      ..replies = (json['replies'] as List<dynamic>)
          .map((e) => Replies$Query$ReplyResponse$Reply.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..hasMore = json['hasMore'] as bool
      ..commentId = json['commentId'] as int
      ..postId = json['postId'] as int;

Map<String, dynamic> _$Replies$Query$ReplyResponseToJson(
        Replies$Query$ReplyResponse instance) =>
    <String, dynamic>{
      'replies': instance.replies.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
      'commentId': instance.commentId,
      'postId': instance.postId,
    };

Replies$Query _$Replies$QueryFromJson(Map<String, dynamic> json) =>
    Replies$Query()
      ..commentReplies = Replies$Query$ReplyResponse.fromJson(
          json['commentReplies'] as Map<String, dynamic>);

Map<String, dynamic> _$Replies$QueryToJson(Replies$Query instance) =>
    <String, dynamic>{
      'commentReplies': instance.commentReplies.toJson(),
    };

UserPosts$Query$PaginatedPosts$Post$FileResponse
    _$UserPosts$Query$PaginatedPosts$Post$FileResponseFromJson(
            Map<String, dynamic> json) =>
        UserPosts$Query$PaginatedPosts$Post$FileResponse()
          ..file = json['file'] as String?
          ..error = json['error'] as String?;

Map<String, dynamic> _$UserPosts$Query$PaginatedPosts$Post$FileResponseToJson(
        UserPosts$Query$PaginatedPosts$Post$FileResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'error': instance.error,
    };

UserPosts$Query$PaginatedPosts$Post
    _$UserPosts$Query$PaginatedPosts$PostFromJson(Map<String, dynamic> json) =>
        UserPosts$Query$PaginatedPosts$Post()
          ..$$typename = json['__typename'] as String?
          ..id = (json['id'] as num).toDouble()
          ..file = PostFragmentMixin$FileResponse.fromJson(
              json['file'] as Map<String, dynamic>)
          ..user = PostFragmentMixin$User.fromJson(
              json['user'] as Map<String, dynamic>)
          ..userTags = (json['userTags'] as List<dynamic>)
              .map((e) => PostFragmentMixin$CaptionUserTag.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..likeState = json['likeState'] as bool?
          ..likeCount = json['likeCount'] as int
          ..caption = json['caption'] as String
          ..createdAt = json['createdAt'] as String
          ..commentCount = json['commentCount'] as int
          ..viewsCount = json['viewsCount'] as int
          ..fileWidth = json['fileWidth'] as int
          ..fileHeight = json['fileHeight'] as int
          ..fileGif = UserPosts$Query$PaginatedPosts$Post$FileResponse.fromJson(
              json['fileGif'] as Map<String, dynamic>);

Map<String, dynamic> _$UserPosts$Query$PaginatedPosts$PostToJson(
        UserPosts$Query$PaginatedPosts$Post instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'file': instance.file.toJson(),
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
      'likeState': instance.likeState,
      'likeCount': instance.likeCount,
      'caption': instance.caption,
      'createdAt': instance.createdAt,
      'commentCount': instance.commentCount,
      'viewsCount': instance.viewsCount,
      'fileWidth': instance.fileWidth,
      'fileHeight': instance.fileHeight,
      'fileGif': instance.fileGif.toJson(),
    };

UserPosts$Query$PaginatedPosts _$UserPosts$Query$PaginatedPostsFromJson(
        Map<String, dynamic> json) =>
    UserPosts$Query$PaginatedPosts()
      ..posts = (json['posts'] as List<dynamic>)
          .map((e) => UserPosts$Query$PaginatedPosts$Post.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$UserPosts$Query$PaginatedPostsToJson(
        UserPosts$Query$PaginatedPosts instance) =>
    <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

UserPosts$Query _$UserPosts$QueryFromJson(Map<String, dynamic> json) =>
    UserPosts$Query()
      ..userPosts = UserPosts$Query$PaginatedPosts.fromJson(
          json['userPosts'] as Map<String, dynamic>);

Map<String, dynamic> _$UserPosts$QueryToJson(UserPosts$Query instance) =>
    <String, dynamic>{
      'userPosts': instance.userPosts.toJson(),
    };

Posts$Query$PaginatedPosts$Post _$Posts$Query$PaginatedPosts$PostFromJson(
        Map<String, dynamic> json) =>
    Posts$Query$PaginatedPosts$Post()
      ..$$typename = json['__typename'] as String?
      ..id = (json['id'] as num).toDouble()
      ..file = PostFragmentMixin$FileResponse.fromJson(
          json['file'] as Map<String, dynamic>)
      ..user =
          PostFragmentMixin$User.fromJson(json['user'] as Map<String, dynamic>)
      ..userTags = (json['userTags'] as List<dynamic>)
          .map((e) => PostFragmentMixin$CaptionUserTag.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..likeState = json['likeState'] as bool?
      ..likeCount = json['likeCount'] as int
      ..caption = json['caption'] as String
      ..createdAt = json['createdAt'] as String
      ..commentCount = json['commentCount'] as int
      ..viewsCount = json['viewsCount'] as int
      ..fileWidth = json['fileWidth'] as int
      ..fileHeight = json['fileHeight'] as int;

Map<String, dynamic> _$Posts$Query$PaginatedPosts$PostToJson(
        Posts$Query$PaginatedPosts$Post instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'file': instance.file.toJson(),
      'user': instance.user.toJson(),
      'userTags': instance.userTags.map((e) => e.toJson()).toList(),
      'likeState': instance.likeState,
      'likeCount': instance.likeCount,
      'caption': instance.caption,
      'createdAt': instance.createdAt,
      'commentCount': instance.commentCount,
      'viewsCount': instance.viewsCount,
      'fileWidth': instance.fileWidth,
      'fileHeight': instance.fileHeight,
    };

Posts$Query$PaginatedPosts _$Posts$Query$PaginatedPostsFromJson(
        Map<String, dynamic> json) =>
    Posts$Query$PaginatedPosts()
      ..posts = (json['posts'] as List<dynamic>)
          .map((e) => Posts$Query$PaginatedPosts$Post.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$Posts$Query$PaginatedPostsToJson(
        Posts$Query$PaginatedPosts instance) =>
    <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

Posts$Query _$Posts$QueryFromJson(Map<String, dynamic> json) => Posts$Query()
  ..posts = Posts$Query$PaginatedPosts.fromJson(
      json['posts'] as Map<String, dynamic>);

Map<String, dynamic> _$Posts$QueryToJson(Posts$Query instance) =>
    <String, dynamic>{
      'posts': instance.posts.toJson(),
    };

RefreshTokensArguments _$RefreshTokensArgumentsFromJson(
        Map<String, dynamic> json) =>
    RefreshTokensArguments(
      token: json['token'] as String,
    );

Map<String, dynamic> _$RefreshTokensArgumentsToJson(
        RefreshTokensArguments instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

LikeUnlikeReplyArguments _$LikeUnlikeReplyArgumentsFromJson(
        Map<String, dynamic> json) =>
    LikeUnlikeReplyArguments(
      replyId: json['replyId'] as int,
      clientId: json['clientId'] as String,
    );

Map<String, dynamic> _$LikeUnlikeReplyArgumentsToJson(
        LikeUnlikeReplyArguments instance) =>
    <String, dynamic>{
      'replyId': instance.replyId,
      'clientId': instance.clientId,
    };

ViewClipArguments _$ViewClipArgumentsFromJson(Map<String, dynamic> json) =>
    ViewClipArguments(
      postId: json['postId'] as int,
    );

Map<String, dynamic> _$ViewClipArgumentsToJson(ViewClipArguments instance) =>
    <String, dynamic>{
      'postId': instance.postId,
    };

LikeUnlikePostArguments _$LikeUnlikePostArgumentsFromJson(
        Map<String, dynamic> json) =>
    LikeUnlikePostArguments(
      postId: json['postId'] as int,
      clientId: json['clientId'] as String,
    );

Map<String, dynamic> _$LikeUnlikePostArgumentsToJson(
        LikeUnlikePostArguments instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'clientId': instance.clientId,
    };

SignInArguments _$SignInArgumentsFromJson(Map<String, dynamic> json) =>
    SignInArguments(
      input: SignInInput.fromJson(json['input'] as Map<String, dynamic>),
      deviceInput:
          DeviceInput.fromJson(json['deviceInput'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInArgumentsToJson(SignInArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
      'deviceInput': instance.deviceInput.toJson(),
    };

AddNewDeviceTokenArguments _$AddNewDeviceTokenArgumentsFromJson(
        Map<String, dynamic> json) =>
    AddNewDeviceTokenArguments(
      deviceInput:
          DeviceInput.fromJson(json['deviceInput'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddNewDeviceTokenArgumentsToJson(
        AddNewDeviceTokenArguments instance) =>
    <String, dynamic>{
      'deviceInput': instance.deviceInput.toJson(),
    };

CommentPostArguments _$CommentPostArgumentsFromJson(
        Map<String, dynamic> json) =>
    CommentPostArguments(
      postId: json['postId'] as int,
      comment: json['comment'] as String,
      userTagsInput: (json['userTagsInput'] as List<dynamic>)
          .map((e) => UserTagInput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentPostArgumentsToJson(
        CommentPostArguments instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'comment': instance.comment,
      'userTagsInput': instance.userTagsInput.map((e) => e.toJson()).toList(),
    };

UserTappedArguments _$UserTappedArgumentsFromJson(Map<String, dynamic> json) =>
    UserTappedArguments(
      id: json['id'] as int,
    );

Map<String, dynamic> _$UserTappedArgumentsToJson(
        UserTappedArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ChangePasswordAndSignInArguments _$ChangePasswordAndSignInArgumentsFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordAndSignInArguments(
      deviceInput:
          DeviceInput.fromJson(json['deviceInput'] as Map<String, dynamic>),
      email: json['email'] as String,
      code: json['code'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$ChangePasswordAndSignInArgumentsToJson(
        ChangePasswordAndSignInArguments instance) =>
    <String, dynamic>{
      'deviceInput': instance.deviceInput.toJson(),
      'email': instance.email,
      'code': instance.code,
      'newPassword': instance.newPassword,
    };

EditProfileArguments _$EditProfileArgumentsFromJson(
        Map<String, dynamic> json) =>
    EditProfileArguments(
      input: UserUpdateInput.fromJson(json['input'] as Map<String, dynamic>),
      file: fromGraphQLUploadNullableToDartCustomMultipartFileNullable(
          json['file'] as CustomMultipartFile?),
      smallFile: fromGraphQLUploadNullableToDartCustomMultipartFileNullable(
          json['smallFile'] as CustomMultipartFile?),
    );

Map<String, dynamic> _$EditProfileArgumentsToJson(
        EditProfileArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
      'file': fromDartCustomMultipartFileNullableToGraphQLUploadNullable(
          instance.file),
      'smallFile': fromDartCustomMultipartFileNullableToGraphQLUploadNullable(
          instance.smallFile),
    };

DeleteCommentArguments _$DeleteCommentArgumentsFromJson(
        Map<String, dynamic> json) =>
    DeleteCommentArguments(
      commentId: json['commentId'] as int,
      isReply: json['isReply'] as bool,
    );

Map<String, dynamic> _$DeleteCommentArgumentsToJson(
        DeleteCommentArguments instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'isReply': instance.isReply,
    };

RegisterArguments _$RegisterArgumentsFromJson(Map<String, dynamic> json) =>
    RegisterArguments(
      input: RegisterInput.fromJson(json['input'] as Map<String, dynamic>),
      deviceInput:
          DeviceInput.fromJson(json['deviceInput'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterArgumentsToJson(RegisterArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
      'deviceInput': instance.deviceInput.toJson(),
    };

LikeUnlikeCommentArguments _$LikeUnlikeCommentArgumentsFromJson(
        Map<String, dynamic> json) =>
    LikeUnlikeCommentArguments(
      commentId: json['commentId'] as int,
      clientId: json['clientId'] as String,
    );

Map<String, dynamic> _$LikeUnlikeCommentArgumentsToJson(
        LikeUnlikeCommentArguments instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'clientId': instance.clientId,
    };

DeleteUserSearchArguments _$DeleteUserSearchArgumentsFromJson(
        Map<String, dynamic> json) =>
    DeleteUserSearchArguments(
      searchedUserId: json['searchedUserId'] as int,
    );

Map<String, dynamic> _$DeleteUserSearchArgumentsToJson(
        DeleteUserSearchArguments instance) =>
    <String, dynamic>{
      'searchedUserId': instance.searchedUserId,
    };

DeletePostArguments _$DeletePostArgumentsFromJson(Map<String, dynamic> json) =>
    DeletePostArguments(
      postId: json['postId'] as int,
    );

Map<String, dynamic> _$DeletePostArgumentsToJson(
        DeletePostArguments instance) =>
    <String, dynamic>{
      'postId': instance.postId,
    };

ReplyCommentArguments _$ReplyCommentArgumentsFromJson(
        Map<String, dynamic> json) =>
    ReplyCommentArguments(
      commentId: json['commentId'] as int,
      postId: json['postId'] as int,
      reply: json['reply'] as String,
      userTagsInput: (json['userTagsInput'] as List<dynamic>)
          .map((e) => UserTagInput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReplyCommentArgumentsToJson(
        ReplyCommentArguments instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'postId': instance.postId,
      'reply': instance.reply,
      'userTagsInput': instance.userTagsInput.map((e) => e.toJson()).toList(),
    };

CreatePostArguments _$CreatePostArgumentsFromJson(Map<String, dynamic> json) =>
    CreatePostArguments(
      caption: json['caption'] as String,
      file: fromGraphQLUploadToDartCustomMultipartFile(
          json['file'] as CustomMultipartFile),
      fileDims:
          FileDimsInput.fromJson(json['fileDims'] as Map<String, dynamic>),
      fileGif: fromGraphQLUploadToDartCustomMultipartFile(
          json['fileGif'] as CustomMultipartFile),
      fileImg: fromGraphQLUploadToDartCustomMultipartFile(
          json['fileImg'] as CustomMultipartFile),
      userTagsInput: (json['userTagsInput'] as List<dynamic>)
          .map((e) => UserTagInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      videogameId: json['videogameId'] as int?,
      videogameGenreIds: (json['videogameGenreIds'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$CreatePostArgumentsToJson(
        CreatePostArguments instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'file': fromDartCustomMultipartFileToGraphQLUpload(instance.file),
      'fileDims': instance.fileDims.toJson(),
      'fileGif': fromDartCustomMultipartFileToGraphQLUpload(instance.fileGif),
      'fileImg': fromDartCustomMultipartFileToGraphQLUpload(instance.fileImg),
      'userTagsInput': instance.userTagsInput.map((e) => e.toJson()).toList(),
      'videogameId': instance.videogameId,
      'videogameGenreIds': instance.videogameGenreIds,
    };

SignOutArguments _$SignOutArgumentsFromJson(Map<String, dynamic> json) =>
    SignOutArguments(
      token: json['token'] as String,
    );

Map<String, dynamic> _$SignOutArgumentsToJson(SignOutArguments instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

AddUserInterestsArguments _$AddUserInterestsArgumentsFromJson(
        Map<String, dynamic> json) =>
    AddUserInterestsArguments(
      videogameGenresIds: (json['videogameGenresIds'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$AddUserInterestsArgumentsToJson(
        AddUserInterestsArguments instance) =>
    <String, dynamic>{
      'videogameGenresIds': instance.videogameGenresIds,
    };

FollowUnfollowUserArguments _$FollowUnfollowUserArgumentsFromJson(
        Map<String, dynamic> json) =>
    FollowUnfollowUserArguments(
      followUserId: json['followUserId'] as int,
      clientId: json['clientId'] as String,
    );

Map<String, dynamic> _$FollowUnfollowUserArgumentsToJson(
        FollowUnfollowUserArguments instance) =>
    <String, dynamic>{
      'followUserId': instance.followUserId,
      'clientId': instance.clientId,
    };

SendResetPasswordEmailArguments _$SendResetPasswordEmailArgumentsFromJson(
        Map<String, dynamic> json) =>
    SendResetPasswordEmailArguments(
      email: json['email'] as String,
    );

Map<String, dynamic> _$SendResetPasswordEmailArgumentsToJson(
        SendResetPasswordEmailArguments instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

CommentsArguments _$CommentsArgumentsFromJson(Map<String, dynamic> json) =>
    CommentsArguments(
      postId: json['postId'] as int,
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$CommentsArgumentsToJson(CommentsArguments instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

UserArguments _$UserArgumentsFromJson(Map<String, dynamic> json) =>
    UserArguments(
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$UserArgumentsToJson(UserArguments instance) =>
    <String, dynamic>{
      'userId': instance.userId,
    };

SinglePostArguments _$SinglePostArgumentsFromJson(Map<String, dynamic> json) =>
    SinglePostArguments(
      id: json['id'] as int,
    );

Map<String, dynamic> _$SinglePostArgumentsToJson(
        SinglePostArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

NotificationsArguments _$NotificationsArgumentsFromJson(
        Map<String, dynamic> json) =>
    NotificationsArguments(
      limit: json['limit'] as int,
      idsList:
          (json['idsList'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$NotificationsArgumentsToJson(
        NotificationsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

UserFollowersArguments _$UserFollowersArgumentsFromJson(
        Map<String, dynamic> json) =>
    UserFollowersArguments(
      followUserId: json['followUserId'] as int,
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
      cursor: json['cursor'] as String?,
    );

Map<String, dynamic> _$UserFollowersArgumentsToJson(
        UserFollowersArguments instance) =>
    <String, dynamic>{
      'followUserId': instance.followUserId,
      'limit': instance.limit,
      'idsList': instance.idsList,
      'cursor': instance.cursor,
    };

VerifyResetCodeArguments _$VerifyResetCodeArgumentsFromJson(
        Map<String, dynamic> json) =>
    VerifyResetCodeArguments(
      email: json['email'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyResetCodeArgumentsToJson(
        VerifyResetCodeArguments instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };

VideogamePostsArguments _$VideogamePostsArgumentsFromJson(
        Map<String, dynamic> json) =>
    VideogamePostsArguments(
      limit: json['limit'] as int,
      videogameId: json['videogameId'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$VideogamePostsArgumentsToJson(
        VideogamePostsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'videogameId': instance.videogameId,
      'idsList': instance.idsList,
    };

FollowingPostsArguments _$FollowingPostsArgumentsFromJson(
        Map<String, dynamic> json) =>
    FollowingPostsArguments(
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$FollowingPostsArgumentsToJson(
        FollowingPostsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

SearchUsersArguments _$SearchUsersArgumentsFromJson(
        Map<String, dynamic> json) =>
    SearchUsersArguments(
      search: json['search'] as String,
    );

Map<String, dynamic> _$SearchUsersArgumentsToJson(
        SearchUsersArguments instance) =>
    <String, dynamic>{
      'search': instance.search,
    };

UserFollowingArguments _$UserFollowingArgumentsFromJson(
        Map<String, dynamic> json) =>
    UserFollowingArguments(
      followUserId: json['followUserId'] as int,
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
      cursor: json['cursor'] as String?,
    );

Map<String, dynamic> _$UserFollowingArgumentsToJson(
        UserFollowingArguments instance) =>
    <String, dynamic>{
      'followUserId': instance.followUserId,
      'limit': instance.limit,
      'idsList': instance.idsList,
      'cursor': instance.cursor,
    };

RepliesArguments _$RepliesArgumentsFromJson(Map<String, dynamic> json) =>
    RepliesArguments(
      commentId: json['commentId'] as int,
      postId: json['postId'] as int,
      limit: json['limit'] as int,
      cursor: json['cursor'] as String?,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$RepliesArgumentsToJson(RepliesArguments instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'postId': instance.postId,
      'limit': instance.limit,
      'cursor': instance.cursor,
      'idsList': instance.idsList,
    };

UserPostsArguments _$UserPostsArgumentsFromJson(Map<String, dynamic> json) =>
    UserPostsArguments(
      userId: json['userId'] as int,
      limit: json['limit'] as int,
      cursor: json['cursor'] as String?,
    );

Map<String, dynamic> _$UserPostsArgumentsToJson(UserPostsArguments instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'limit': instance.limit,
      'cursor': instance.cursor,
    };

PostsArguments _$PostsArgumentsFromJson(Map<String, dynamic> json) =>
    PostsArguments(
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$PostsArgumentsToJson(PostsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'idsList': instance.idsList,
    };
