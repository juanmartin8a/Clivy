// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:untitled_client/src/api/upload_serializer.dart';
part 'graphql_api.graphql.g.dart';

mixin TokensFragmentMixin {
  late String refreshToken;
  late String accessToken;
}
mixin UserFragmentMixin {
  late double id;
  late String username;
  late UserFragmentMixin$FileResponse file;
}
mixin FileFragmentMixin {
  String? file;
  String? error;
}
mixin CommentFragmentMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late double id;
  late String comment;
  @JsonKey(name: 'user_id')
  late double userId;
  @JsonKey(name: 'post_id')
  late double postId;
  late String createdAt;
  late int replyCount;
  late int likeCount;
  bool? likeState;
  late CommentFragmentMixin$User user;
  late List<CommentFragmentMixin$CommentUserTag> userTags;
}
mixin ReplyFragmentMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late double id;
  late String reply;
  @JsonKey(name: 'user_id')
  late double userId;
  @JsonKey(name: 'comment_id')
  late double commentId;
  @JsonKey(name: 'post_id')
  late double postId;
  late String createdAt;
  late int likeCount;
  bool? likeState;
  late ReplyFragmentMixin$User user;
  late List<ReplyFragmentMixin$ReplyUserTag> userTags;
}
mixin PostFragmentMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late double id;
  late PostFragmentMixin$FileResponse file;
  late PostFragmentMixin$User user;
  late List<PostFragmentMixin$CaptionUserTag> userTags;
  bool? likeState;
  late int likeCount;
  late String caption;
  late String createdAt;
  late int commentCount;
  late int viewsCount;
  late int fileWidth;
  late int fileHeight;
}
mixin VideogameFragmentMixin {
  late int id;
  late String name;
  late int postCount;
  late int tapCount;
  late VideogameFragmentMixin$FileResponse file;
}

@JsonSerializable(explicitToJson: true)
class RefreshTokens$Mutation$TokenResponse extends JsonSerializable
    with EquatableMixin, TokensFragmentMixin {
  RefreshTokens$Mutation$TokenResponse();

  factory RefreshTokens$Mutation$TokenResponse.fromJson(
          Map<String, dynamic> json) =>
      _$RefreshTokens$Mutation$TokenResponseFromJson(json);

  @override
  List<Object?> get props => [refreshToken, accessToken];
  @override
  Map<String, dynamic> toJson() =>
      _$RefreshTokens$Mutation$TokenResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RefreshTokens$Mutation extends JsonSerializable with EquatableMixin {
  RefreshTokens$Mutation();

  factory RefreshTokens$Mutation.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokens$MutationFromJson(json);

  late RefreshTokens$Mutation$TokenResponse refreshToken;

  @override
  List<Object?> get props => [refreshToken];
  @override
  Map<String, dynamic> toJson() => _$RefreshTokens$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikeReply$Mutation$LikeResponse extends JsonSerializable
    with EquatableMixin {
  LikeUnlikeReply$Mutation$LikeResponse();

  factory LikeUnlikeReply$Mutation$LikeResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LikeUnlikeReply$Mutation$LikeResponseFromJson(json);

  int? value;

  String? clientId;

  @override
  List<Object?> get props => [value, clientId];
  @override
  Map<String, dynamic> toJson() =>
      _$LikeUnlikeReply$Mutation$LikeResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikeReply$Mutation extends JsonSerializable with EquatableMixin {
  LikeUnlikeReply$Mutation();

  factory LikeUnlikeReply$Mutation.fromJson(Map<String, dynamic> json) =>
      _$LikeUnlikeReply$MutationFromJson(json);

  late LikeUnlikeReply$Mutation$LikeResponse likeUnlikeReply;

  @override
  List<Object?> get props => [likeUnlikeReply];
  @override
  Map<String, dynamic> toJson() => _$LikeUnlikeReply$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ViewClip$Mutation extends JsonSerializable with EquatableMixin {
  ViewClip$Mutation();

  factory ViewClip$Mutation.fromJson(Map<String, dynamic> json) =>
      _$ViewClip$MutationFromJson(json);

  late bool viewClip;

  @override
  List<Object?> get props => [viewClip];
  @override
  Map<String, dynamic> toJson() => _$ViewClip$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikePost$Mutation$LikeResponse extends JsonSerializable
    with EquatableMixin {
  LikeUnlikePost$Mutation$LikeResponse();

  factory LikeUnlikePost$Mutation$LikeResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LikeUnlikePost$Mutation$LikeResponseFromJson(json);

  int? value;

  String? clientId;

  @override
  List<Object?> get props => [value, clientId];
  @override
  Map<String, dynamic> toJson() =>
      _$LikeUnlikePost$Mutation$LikeResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikePost$Mutation extends JsonSerializable with EquatableMixin {
  LikeUnlikePost$Mutation();

  factory LikeUnlikePost$Mutation.fromJson(Map<String, dynamic> json) =>
      _$LikeUnlikePost$MutationFromJson(json);

  late LikeUnlikePost$Mutation$LikeResponse likeUnlikePost;

  @override
  List<Object?> get props => [likeUnlikePost];
  @override
  Map<String, dynamic> toJson() => _$LikeUnlikePost$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$UserMutationResponse$ErrorResponse
    extends JsonSerializable with EquatableMixin {
  SignIn$Mutation$UserMutationResponse$ErrorResponse();

  factory SignIn$Mutation$UserMutationResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$UserMutationResponse$ErrorResponseFromJson(json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$UserMutationResponse$ErrorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$UserMutationResponse$User extends JsonSerializable
    with EquatableMixin, UserFragmentMixin {
  SignIn$Mutation$UserMutationResponse$User();

  factory SignIn$Mutation$UserMutationResponse$User.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$UserMutationResponse$UserFromJson(json);

  @override
  List<Object?> get props => [id, username, file];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$UserMutationResponse$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$UserMutationResponse$TokenResponse
    extends JsonSerializable with EquatableMixin, TokensFragmentMixin {
  SignIn$Mutation$UserMutationResponse$TokenResponse();

  factory SignIn$Mutation$UserMutationResponse$TokenResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$UserMutationResponse$TokenResponseFromJson(json);

  @override
  List<Object?> get props => [refreshToken, accessToken];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$UserMutationResponse$TokenResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$UserMutationResponse extends JsonSerializable
    with EquatableMixin {
  SignIn$Mutation$UserMutationResponse();

  factory SignIn$Mutation$UserMutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$UserMutationResponseFromJson(json);

  List<SignIn$Mutation$UserMutationResponse$ErrorResponse>? errors;

  SignIn$Mutation$UserMutationResponse$User? user;

  SignIn$Mutation$UserMutationResponse$TokenResponse? tokens;

  @override
  List<Object?> get props => [errors, user, tokens];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$UserMutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation extends JsonSerializable with EquatableMixin {
  SignIn$Mutation();

  factory SignIn$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SignIn$MutationFromJson(json);

  late SignIn$Mutation$UserMutationResponse signIn;

  @override
  List<Object?> get props => [signIn];
  @override
  Map<String, dynamic> toJson() => _$SignIn$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFragmentMixin$FileResponse extends JsonSerializable
    with EquatableMixin, FileFragmentMixin {
  UserFragmentMixin$FileResponse();

  factory UserFragmentMixin$FileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserFragmentMixin$FileResponseFromJson(json);

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() => _$UserFragmentMixin$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignInInput extends JsonSerializable with EquatableMixin {
  SignInInput({required this.usernameOrEmail, required this.password});

  factory SignInInput.fromJson(Map<String, dynamic> json) =>
      _$SignInInputFromJson(json);

  late String usernameOrEmail;

  late String password;

  @override
  List<Object?> get props => [usernameOrEmail, password];
  @override
  Map<String, dynamic> toJson() => _$SignInInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeviceInput extends JsonSerializable with EquatableMixin {
  DeviceInput({this.deviceToken, this.platformIsIOS});

  factory DeviceInput.fromJson(Map<String, dynamic> json) =>
      _$DeviceInputFromJson(json);

  String? deviceToken;

  bool? platformIsIOS;

  @override
  List<Object?> get props => [deviceToken, platformIsIOS];
  @override
  Map<String, dynamic> toJson() => _$DeviceInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddNewDeviceToken$Mutation extends JsonSerializable with EquatableMixin {
  AddNewDeviceToken$Mutation();

  factory AddNewDeviceToken$Mutation.fromJson(Map<String, dynamic> json) =>
      _$AddNewDeviceToken$MutationFromJson(json);

  late bool addNewDeviceToken;

  @override
  List<Object?> get props => [addNewDeviceToken];
  @override
  Map<String, dynamic> toJson() => _$AddNewDeviceToken$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommentPost$Mutation$CreateCommentResponse$Comment
    extends JsonSerializable with EquatableMixin, CommentFragmentMixin {
  CommentPost$Mutation$CreateCommentResponse$Comment();

  factory CommentPost$Mutation$CreateCommentResponse$Comment.fromJson(
          Map<String, dynamic> json) =>
      _$CommentPost$Mutation$CreateCommentResponse$CommentFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        comment,
        userId,
        postId,
        createdAt,
        replyCount,
        likeCount,
        likeState,
        user,
        userTags
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$CommentPost$Mutation$CreateCommentResponse$CommentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommentPost$Mutation$CreateCommentResponse extends JsonSerializable
    with EquatableMixin {
  CommentPost$Mutation$CreateCommentResponse();

  factory CommentPost$Mutation$CreateCommentResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CommentPost$Mutation$CreateCommentResponseFromJson(json);

  CommentPost$Mutation$CreateCommentResponse$Comment? comment;

  int? postId;

  bool? error;

  @override
  List<Object?> get props => [comment, postId, error];
  @override
  Map<String, dynamic> toJson() =>
      _$CommentPost$Mutation$CreateCommentResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommentPost$Mutation extends JsonSerializable with EquatableMixin {
  CommentPost$Mutation();

  factory CommentPost$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CommentPost$MutationFromJson(json);

  late CommentPost$Mutation$CreateCommentResponse commentPost;

  @override
  List<Object?> get props => [commentPost];
  @override
  Map<String, dynamic> toJson() => _$CommentPost$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommentFragmentMixin$User$FileResponse extends JsonSerializable
    with EquatableMixin {
  CommentFragmentMixin$User$FileResponse();

  factory CommentFragmentMixin$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CommentFragmentMixin$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$CommentFragmentMixin$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommentFragmentMixin$User extends JsonSerializable with EquatableMixin {
  CommentFragmentMixin$User();

  factory CommentFragmentMixin$User.fromJson(Map<String, dynamic> json) =>
      _$CommentFragmentMixin$UserFromJson(json);

  late double id;

  late String username;

  late CommentFragmentMixin$User$FileResponse smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() => _$CommentFragmentMixin$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommentFragmentMixin$CommentUserTag extends JsonSerializable
    with EquatableMixin {
  CommentFragmentMixin$CommentUserTag();

  factory CommentFragmentMixin$CommentUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$CommentFragmentMixin$CommentUserTagFromJson(json);

  @JsonKey(name: 'comment_id')
  late int commentId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [commentId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$CommentFragmentMixin$CommentUserTagToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserTagInput extends JsonSerializable with EquatableMixin {
  UserTagInput({required this.userString, required this.userId});

  factory UserTagInput.fromJson(Map<String, dynamic> json) =>
      _$UserTagInputFromJson(json);

  late String userString;

  late int userId;

  @override
  List<Object?> get props => [userString, userId];
  @override
  Map<String, dynamic> toJson() => _$UserTagInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserTapped$Mutation$User$FileResponse extends JsonSerializable
    with EquatableMixin {
  UserTapped$Mutation$User$FileResponse();

  factory UserTapped$Mutation$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UserTapped$Mutation$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$UserTapped$Mutation$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserTapped$Mutation$User extends JsonSerializable with EquatableMixin {
  UserTapped$Mutation$User();

  factory UserTapped$Mutation$User.fromJson(Map<String, dynamic> json) =>
      _$UserTapped$Mutation$UserFromJson(json);

  late double id;

  late String username;

  late String name;

  late UserTapped$Mutation$User$FileResponse file;

  @override
  List<Object?> get props => [id, username, name, file];
  @override
  Map<String, dynamic> toJson() => _$UserTapped$Mutation$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserTapped$Mutation extends JsonSerializable with EquatableMixin {
  UserTapped$Mutation();

  factory UserTapped$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UserTapped$MutationFromJson(json);

  UserTapped$Mutation$User? userTapped;

  @override
  List<Object?> get props => [userTapped];
  @override
  Map<String, dynamic> toJson() => _$UserTapped$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteUser$Mutation extends JsonSerializable with EquatableMixin {
  DeleteUser$Mutation();

  factory DeleteUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteUser$MutationFromJson(json);

  late bool deleteUser;

  @override
  List<Object?> get props => [deleteUser];
  @override
  Map<String, dynamic> toJson() => _$DeleteUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse
    extends JsonSerializable with EquatableMixin {
  ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse();

  factory ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponseFromJson(
          json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordAndSignIn$Mutation$UserMutationResponse$User
    extends JsonSerializable with EquatableMixin, UserFragmentMixin {
  ChangePasswordAndSignIn$Mutation$UserMutationResponse$User();

  factory ChangePasswordAndSignIn$Mutation$UserMutationResponse$User.fromJson(
          Map<String, dynamic> json) =>
      _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$UserFromJson(
          json);

  @override
  List<Object?> get props => [id, username, file];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponse
    extends JsonSerializable with EquatableMixin, TokensFragmentMixin {
  ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponse();

  factory ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponseFromJson(
          json);

  @override
  List<Object?> get props => [refreshToken, accessToken];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordAndSignIn$Mutation$UserMutationResponse
    extends JsonSerializable with EquatableMixin {
  ChangePasswordAndSignIn$Mutation$UserMutationResponse();

  factory ChangePasswordAndSignIn$Mutation$UserMutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChangePasswordAndSignIn$Mutation$UserMutationResponseFromJson(json);

  List<ChangePasswordAndSignIn$Mutation$UserMutationResponse$ErrorResponse>?
      errors;

  ChangePasswordAndSignIn$Mutation$UserMutationResponse$User? user;

  ChangePasswordAndSignIn$Mutation$UserMutationResponse$TokenResponse? tokens;

  @override
  List<Object?> get props => [errors, user, tokens];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangePasswordAndSignIn$Mutation$UserMutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordAndSignIn$Mutation extends JsonSerializable
    with EquatableMixin {
  ChangePasswordAndSignIn$Mutation();

  factory ChangePasswordAndSignIn$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$ChangePasswordAndSignIn$MutationFromJson(json);

  late ChangePasswordAndSignIn$Mutation$UserMutationResponse
      changePasswordAndSignIn;

  @override
  List<Object?> get props => [changePasswordAndSignIn];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangePasswordAndSignIn$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditProfile$Mutation$UserMutationResponse$ErrorResponse
    extends JsonSerializable with EquatableMixin {
  EditProfile$Mutation$UserMutationResponse$ErrorResponse();

  factory EditProfile$Mutation$UserMutationResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$EditProfile$Mutation$UserMutationResponse$ErrorResponseFromJson(json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$EditProfile$Mutation$UserMutationResponse$ErrorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditProfile$Mutation$UserMutationResponse$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  EditProfile$Mutation$UserMutationResponse$User$FileResponse();

  factory EditProfile$Mutation$UserMutationResponse$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$EditProfile$Mutation$UserMutationResponse$User$FileResponseFromJson(
          json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$EditProfile$Mutation$UserMutationResponse$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditProfile$Mutation$UserMutationResponse$User extends JsonSerializable
    with EquatableMixin {
  EditProfile$Mutation$UserMutationResponse$User();

  factory EditProfile$Mutation$UserMutationResponse$User.fromJson(
          Map<String, dynamic> json) =>
      _$EditProfile$Mutation$UserMutationResponse$UserFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late double id;

  late String name;

  late String username;

  late String email;

  late String bio;

  late EditProfile$Mutation$UserMutationResponse$User$FileResponse file;

  late int followingCount;

  late int followersCount;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        name,
        username,
        email,
        bio,
        file,
        followingCount,
        followersCount
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$EditProfile$Mutation$UserMutationResponse$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditProfile$Mutation$UserMutationResponse extends JsonSerializable
    with EquatableMixin {
  EditProfile$Mutation$UserMutationResponse();

  factory EditProfile$Mutation$UserMutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$EditProfile$Mutation$UserMutationResponseFromJson(json);

  List<EditProfile$Mutation$UserMutationResponse$ErrorResponse>? errors;

  EditProfile$Mutation$UserMutationResponse$User? user;

  @override
  List<Object?> get props => [errors, user];
  @override
  Map<String, dynamic> toJson() =>
      _$EditProfile$Mutation$UserMutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditProfile$Mutation extends JsonSerializable with EquatableMixin {
  EditProfile$Mutation();

  factory EditProfile$Mutation.fromJson(Map<String, dynamic> json) =>
      _$EditProfile$MutationFromJson(json);

  late EditProfile$Mutation$UserMutationResponse editUser;

  @override
  List<Object?> get props => [editUser];
  @override
  Map<String, dynamic> toJson() => _$EditProfile$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserUpdateInput extends JsonSerializable with EquatableMixin {
  UserUpdateInput({this.name, this.username, this.bio});

  factory UserUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateInputFromJson(json);

  String? name;

  String? username;

  String? bio;

  @override
  List<Object?> get props => [name, username, bio];
  @override
  Map<String, dynamic> toJson() => _$UserUpdateInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteComment$Mutation extends JsonSerializable with EquatableMixin {
  DeleteComment$Mutation();

  factory DeleteComment$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteComment$MutationFromJson(json);

  late bool deleteComment;

  @override
  List<Object?> get props => [deleteComment];
  @override
  Map<String, dynamic> toJson() => _$DeleteComment$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Register$Mutation$UserMutationResponse$ErrorResponse
    extends JsonSerializable with EquatableMixin {
  Register$Mutation$UserMutationResponse$ErrorResponse();

  factory Register$Mutation$UserMutationResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Register$Mutation$UserMutationResponse$ErrorResponseFromJson(json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$Register$Mutation$UserMutationResponse$ErrorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Register$Mutation$UserMutationResponse$User extends JsonSerializable
    with EquatableMixin, UserFragmentMixin {
  Register$Mutation$UserMutationResponse$User();

  factory Register$Mutation$UserMutationResponse$User.fromJson(
          Map<String, dynamic> json) =>
      _$Register$Mutation$UserMutationResponse$UserFromJson(json);

  @override
  List<Object?> get props => [id, username, file];
  @override
  Map<String, dynamic> toJson() =>
      _$Register$Mutation$UserMutationResponse$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Register$Mutation$UserMutationResponse$TokenResponse
    extends JsonSerializable with EquatableMixin, TokensFragmentMixin {
  Register$Mutation$UserMutationResponse$TokenResponse();

  factory Register$Mutation$UserMutationResponse$TokenResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Register$Mutation$UserMutationResponse$TokenResponseFromJson(json);

  @override
  List<Object?> get props => [refreshToken, accessToken];
  @override
  Map<String, dynamic> toJson() =>
      _$Register$Mutation$UserMutationResponse$TokenResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Register$Mutation$UserMutationResponse extends JsonSerializable
    with EquatableMixin {
  Register$Mutation$UserMutationResponse();

  factory Register$Mutation$UserMutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Register$Mutation$UserMutationResponseFromJson(json);

  List<Register$Mutation$UserMutationResponse$ErrorResponse>? errors;

  Register$Mutation$UserMutationResponse$User? user;

  Register$Mutation$UserMutationResponse$TokenResponse? tokens;

  @override
  List<Object?> get props => [errors, user, tokens];
  @override
  Map<String, dynamic> toJson() =>
      _$Register$Mutation$UserMutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Register$Mutation extends JsonSerializable with EquatableMixin {
  Register$Mutation();

  factory Register$Mutation.fromJson(Map<String, dynamic> json) =>
      _$Register$MutationFromJson(json);

  late Register$Mutation$UserMutationResponse register;

  @override
  List<Object?> get props => [register];
  @override
  Map<String, dynamic> toJson() => _$Register$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisterInput extends JsonSerializable with EquatableMixin {
  RegisterInput(
      {required this.name,
      required this.username,
      required this.email,
      required this.password,
      required this.birthday});

  factory RegisterInput.fromJson(Map<String, dynamic> json) =>
      _$RegisterInputFromJson(json);

  late String name;

  late String username;

  late String email;

  late String password;

  late String birthday;

  @override
  List<Object?> get props => [name, username, email, password, birthday];
  @override
  Map<String, dynamic> toJson() => _$RegisterInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikeComment$Mutation$LikeResponse extends JsonSerializable
    with EquatableMixin {
  LikeUnlikeComment$Mutation$LikeResponse();

  factory LikeUnlikeComment$Mutation$LikeResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LikeUnlikeComment$Mutation$LikeResponseFromJson(json);

  int? value;

  String? clientId;

  @override
  List<Object?> get props => [value, clientId];
  @override
  Map<String, dynamic> toJson() =>
      _$LikeUnlikeComment$Mutation$LikeResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikeComment$Mutation extends JsonSerializable with EquatableMixin {
  LikeUnlikeComment$Mutation();

  factory LikeUnlikeComment$Mutation.fromJson(Map<String, dynamic> json) =>
      _$LikeUnlikeComment$MutationFromJson(json);

  late LikeUnlikeComment$Mutation$LikeResponse likeUnlikeComment;

  @override
  List<Object?> get props => [likeUnlikeComment];
  @override
  Map<String, dynamic> toJson() => _$LikeUnlikeComment$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteUserSearch$Mutation extends JsonSerializable with EquatableMixin {
  DeleteUserSearch$Mutation();

  factory DeleteUserSearch$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserSearch$MutationFromJson(json);

  late bool deleteUserSearch;

  @override
  List<Object?> get props => [deleteUserSearch];
  @override
  Map<String, dynamic> toJson() => _$DeleteUserSearch$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeletePost$Mutation extends JsonSerializable with EquatableMixin {
  DeletePost$Mutation();

  factory DeletePost$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeletePost$MutationFromJson(json);

  late bool deletePost;

  @override
  List<Object?> get props => [deletePost];
  @override
  Map<String, dynamic> toJson() => _$DeletePost$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReplyComment$Mutation$CreateReplyResponse$Reply extends JsonSerializable
    with EquatableMixin, ReplyFragmentMixin {
  ReplyComment$Mutation$CreateReplyResponse$Reply();

  factory ReplyComment$Mutation$CreateReplyResponse$Reply.fromJson(
          Map<String, dynamic> json) =>
      _$ReplyComment$Mutation$CreateReplyResponse$ReplyFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        reply,
        userId,
        commentId,
        postId,
        createdAt,
        likeCount,
        likeState,
        user,
        userTags
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$ReplyComment$Mutation$CreateReplyResponse$ReplyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReplyComment$Mutation$CreateReplyResponse extends JsonSerializable
    with EquatableMixin {
  ReplyComment$Mutation$CreateReplyResponse();

  factory ReplyComment$Mutation$CreateReplyResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ReplyComment$Mutation$CreateReplyResponseFromJson(json);

  ReplyComment$Mutation$CreateReplyResponse$Reply? reply;

  int? commentId;

  int? postId;

  bool? error;

  @override
  List<Object?> get props => [reply, commentId, postId, error];
  @override
  Map<String, dynamic> toJson() =>
      _$ReplyComment$Mutation$CreateReplyResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReplyComment$Mutation extends JsonSerializable with EquatableMixin {
  ReplyComment$Mutation();

  factory ReplyComment$Mutation.fromJson(Map<String, dynamic> json) =>
      _$ReplyComment$MutationFromJson(json);

  late ReplyComment$Mutation$CreateReplyResponse replyComment;

  @override
  List<Object?> get props => [replyComment];
  @override
  Map<String, dynamic> toJson() => _$ReplyComment$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReplyFragmentMixin$User$FileResponse extends JsonSerializable
    with EquatableMixin {
  ReplyFragmentMixin$User$FileResponse();

  factory ReplyFragmentMixin$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ReplyFragmentMixin$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$ReplyFragmentMixin$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReplyFragmentMixin$User extends JsonSerializable with EquatableMixin {
  ReplyFragmentMixin$User();

  factory ReplyFragmentMixin$User.fromJson(Map<String, dynamic> json) =>
      _$ReplyFragmentMixin$UserFromJson(json);

  late double id;

  late String username;

  late ReplyFragmentMixin$User$FileResponse smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() => _$ReplyFragmentMixin$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReplyFragmentMixin$ReplyUserTag extends JsonSerializable
    with EquatableMixin {
  ReplyFragmentMixin$ReplyUserTag();

  factory ReplyFragmentMixin$ReplyUserTag.fromJson(Map<String, dynamic> json) =>
      _$ReplyFragmentMixin$ReplyUserTagFromJson(json);

  @JsonKey(name: 'reply_id')
  late int replyId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [replyId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$ReplyFragmentMixin$ReplyUserTagToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreatePost$Mutation$CreatePostResponse$Post extends JsonSerializable
    with EquatableMixin, PostFragmentMixin {
  CreatePost$Mutation$CreatePostResponse$Post();

  factory CreatePost$Mutation$CreatePostResponse$Post.fromJson(
          Map<String, dynamic> json) =>
      _$CreatePost$Mutation$CreatePostResponse$PostFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        file,
        user,
        userTags,
        likeState,
        likeCount,
        caption,
        createdAt,
        commentCount,
        viewsCount,
        fileWidth,
        fileHeight
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$CreatePost$Mutation$CreatePostResponse$PostToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreatePost$Mutation$CreatePostResponse$ErrorResponse
    extends JsonSerializable with EquatableMixin {
  CreatePost$Mutation$CreatePostResponse$ErrorResponse();

  factory CreatePost$Mutation$CreatePostResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreatePost$Mutation$CreatePostResponse$ErrorResponseFromJson(json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$CreatePost$Mutation$CreatePostResponse$ErrorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreatePost$Mutation$CreatePostResponse extends JsonSerializable
    with EquatableMixin {
  CreatePost$Mutation$CreatePostResponse();

  factory CreatePost$Mutation$CreatePostResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreatePost$Mutation$CreatePostResponseFromJson(json);

  CreatePost$Mutation$CreatePostResponse$Post? post;

  CreatePost$Mutation$CreatePostResponse$ErrorResponse? error;

  @override
  List<Object?> get props => [post, error];
  @override
  Map<String, dynamic> toJson() =>
      _$CreatePost$Mutation$CreatePostResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreatePost$Mutation extends JsonSerializable with EquatableMixin {
  CreatePost$Mutation();

  factory CreatePost$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreatePost$MutationFromJson(json);

  late CreatePost$Mutation$CreatePostResponse createPost;

  @override
  List<Object?> get props => [createPost];
  @override
  Map<String, dynamic> toJson() => _$CreatePost$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostFragmentMixin$FileResponse extends JsonSerializable
    with EquatableMixin {
  PostFragmentMixin$FileResponse();

  factory PostFragmentMixin$FileResponse.fromJson(Map<String, dynamic> json) =>
      _$PostFragmentMixin$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() => _$PostFragmentMixin$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostFragmentMixin$User$FileResponse extends JsonSerializable
    with EquatableMixin {
  PostFragmentMixin$User$FileResponse();

  factory PostFragmentMixin$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PostFragmentMixin$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$PostFragmentMixin$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostFragmentMixin$User extends JsonSerializable with EquatableMixin {
  PostFragmentMixin$User();

  factory PostFragmentMixin$User.fromJson(Map<String, dynamic> json) =>
      _$PostFragmentMixin$UserFromJson(json);

  late double id;

  late String username;

  late PostFragmentMixin$User$FileResponse smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() => _$PostFragmentMixin$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostFragmentMixin$CaptionUserTag extends JsonSerializable
    with EquatableMixin {
  PostFragmentMixin$CaptionUserTag();

  factory PostFragmentMixin$CaptionUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$PostFragmentMixin$CaptionUserTagFromJson(json);

  @JsonKey(name: 'post_id')
  late int postId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [postId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$PostFragmentMixin$CaptionUserTagToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FileDimsInput extends JsonSerializable with EquatableMixin {
  FileDimsInput({required this.fileWidth, required this.fileHeight});

  factory FileDimsInput.fromJson(Map<String, dynamic> json) =>
      _$FileDimsInputFromJson(json);

  late int fileWidth;

  late int fileHeight;

  @override
  List<Object?> get props => [fileWidth, fileHeight];
  @override
  Map<String, dynamic> toJson() => _$FileDimsInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignOut$Mutation extends JsonSerializable with EquatableMixin {
  SignOut$Mutation();

  factory SignOut$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SignOut$MutationFromJson(json);

  late bool signOut;

  @override
  List<Object?> get props => [signOut];
  @override
  Map<String, dynamic> toJson() => _$SignOut$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddUserInterests$Mutation extends JsonSerializable with EquatableMixin {
  AddUserInterests$Mutation();

  factory AddUserInterests$Mutation.fromJson(Map<String, dynamic> json) =>
      _$AddUserInterests$MutationFromJson(json);

  late bool addUserInterests;

  @override
  List<Object?> get props => [addUserInterests];
  @override
  Map<String, dynamic> toJson() => _$AddUserInterests$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FollowUnfollowUser$Mutation$LikeResponse extends JsonSerializable
    with EquatableMixin {
  FollowUnfollowUser$Mutation$LikeResponse();

  factory FollowUnfollowUser$Mutation$LikeResponse.fromJson(
          Map<String, dynamic> json) =>
      _$FollowUnfollowUser$Mutation$LikeResponseFromJson(json);

  int? value;

  String? clientId;

  @override
  List<Object?> get props => [value, clientId];
  @override
  Map<String, dynamic> toJson() =>
      _$FollowUnfollowUser$Mutation$LikeResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FollowUnfollowUser$Mutation extends JsonSerializable with EquatableMixin {
  FollowUnfollowUser$Mutation();

  factory FollowUnfollowUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$FollowUnfollowUser$MutationFromJson(json);

  late FollowUnfollowUser$Mutation$LikeResponse followUnfollowUser;

  @override
  List<Object?> get props => [followUnfollowUser];
  @override
  Map<String, dynamic> toJson() => _$FollowUnfollowUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendResetPasswordEmail$Mutation extends JsonSerializable
    with EquatableMixin {
  SendResetPasswordEmail$Mutation();

  factory SendResetPasswordEmail$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SendResetPasswordEmail$MutationFromJson(json);

  late bool sendResetPasswordEmail;

  @override
  List<Object?> get props => [sendResetPasswordEmail];
  @override
  Map<String, dynamic> toJson() =>
      _$SendResetPasswordEmail$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Comments$Query$CommentResponse$Comment extends JsonSerializable
    with EquatableMixin, CommentFragmentMixin {
  Comments$Query$CommentResponse$Comment();

  factory Comments$Query$CommentResponse$Comment.fromJson(
          Map<String, dynamic> json) =>
      _$Comments$Query$CommentResponse$CommentFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        comment,
        userId,
        postId,
        createdAt,
        replyCount,
        likeCount,
        likeState,
        user,
        userTags
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$Comments$Query$CommentResponse$CommentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Comments$Query$CommentResponse extends JsonSerializable
    with EquatableMixin {
  Comments$Query$CommentResponse();

  factory Comments$Query$CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$Comments$Query$CommentResponseFromJson(json);

  late List<Comments$Query$CommentResponse$Comment> comments;

  late bool hasMore;

  late int postId;

  @override
  List<Object?> get props => [comments, hasMore, postId];
  @override
  Map<String, dynamic> toJson() => _$Comments$Query$CommentResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Comments$Query extends JsonSerializable with EquatableMixin {
  Comments$Query();

  factory Comments$Query.fromJson(Map<String, dynamic> json) =>
      _$Comments$QueryFromJson(json);

  late Comments$Query$CommentResponse comments;

  @override
  List<Object?> get props => [comments];
  @override
  Map<String, dynamic> toJson() => _$Comments$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User$Query$User$FileResponse extends JsonSerializable
    with EquatableMixin {
  User$Query$User$FileResponse();

  factory User$Query$User$FileResponse.fromJson(Map<String, dynamic> json) =>
      _$User$Query$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() => _$User$Query$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User$Query$User extends JsonSerializable with EquatableMixin {
  User$Query$User();

  factory User$Query$User.fromJson(Map<String, dynamic> json) =>
      _$User$Query$UserFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late double id;

  late String username;

  late String name;

  late String email;

  late String bio;

  late User$Query$User$FileResponse file;

  bool? followState;

  late int followingCount;

  late int followersCount;

  late int postCount;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        username,
        name,
        email,
        bio,
        file,
        followState,
        followingCount,
        followersCount,
        postCount
      ];
  @override
  Map<String, dynamic> toJson() => _$User$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User$Query extends JsonSerializable with EquatableMixin {
  User$Query();

  factory User$Query.fromJson(Map<String, dynamic> json) =>
      _$User$QueryFromJson(json);

  User$Query$User? user;

  @override
  List<Object?> get props => [user];
  @override
  Map<String, dynamic> toJson() => _$User$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SinglePost$Query$Post extends JsonSerializable
    with EquatableMixin, PostFragmentMixin {
  SinglePost$Query$Post();

  factory SinglePost$Query$Post.fromJson(Map<String, dynamic> json) =>
      _$SinglePost$Query$PostFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        file,
        user,
        userTags,
        likeState,
        likeCount,
        caption,
        createdAt,
        commentCount,
        viewsCount,
        fileWidth,
        fileHeight
      ];
  @override
  Map<String, dynamic> toJson() => _$SinglePost$Query$PostToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SinglePost$Query extends JsonSerializable with EquatableMixin {
  SinglePost$Query();

  factory SinglePost$Query.fromJson(Map<String, dynamic> json) =>
      _$SinglePost$QueryFromJson(json);

  SinglePost$Query$Post? singlePost;

  @override
  List<Object?> get props => [singlePost];
  @override
  Map<String, dynamic> toJson() => _$SinglePost$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenre
    extends JsonSerializable with EquatableMixin {
  AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenre();

  factory AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenre.fromJson(
          Map<String, dynamic> json) =>
      _$AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenreFromJson(
          json);

  late int id;

  @JsonKey(name: 'videogame_genre')
  late String videogameGenre;

  @override
  List<Object?> get props => [id, videogameGenre];
  @override
  Map<String, dynamic> toJson() =>
      _$AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenreToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class AllVideogames$Query$Videogame$VideogameGenreVideogame
    extends JsonSerializable with EquatableMixin {
  AllVideogames$Query$Videogame$VideogameGenreVideogame();

  factory AllVideogames$Query$Videogame$VideogameGenreVideogame.fromJson(
          Map<String, dynamic> json) =>
      _$AllVideogames$Query$Videogame$VideogameGenreVideogameFromJson(json);

  late AllVideogames$Query$Videogame$VideogameGenreVideogame$VideogameGenre
      videogameGenre;

  @override
  List<Object?> get props => [videogameGenre];
  @override
  Map<String, dynamic> toJson() =>
      _$AllVideogames$Query$Videogame$VideogameGenreVideogameToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllVideogames$Query$Videogame extends JsonSerializable
    with EquatableMixin, VideogameFragmentMixin {
  AllVideogames$Query$Videogame();

  factory AllVideogames$Query$Videogame.fromJson(Map<String, dynamic> json) =>
      _$AllVideogames$Query$VideogameFromJson(json);

  late List<AllVideogames$Query$Videogame$VideogameGenreVideogame>
      videogameGenre;

  @override
  List<Object?> get props =>
      [id, name, postCount, tapCount, file, videogameGenre];
  @override
  Map<String, dynamic> toJson() => _$AllVideogames$Query$VideogameToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllVideogames$Query extends JsonSerializable with EquatableMixin {
  AllVideogames$Query();

  factory AllVideogames$Query.fromJson(Map<String, dynamic> json) =>
      _$AllVideogames$QueryFromJson(json);

  late List<AllVideogames$Query$Videogame> allVideogames;

  @override
  List<Object?> get props => [allVideogames];
  @override
  Map<String, dynamic> toJson() => _$AllVideogames$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VideogameFragmentMixin$FileResponse extends JsonSerializable
    with EquatableMixin {
  VideogameFragmentMixin$FileResponse();

  factory VideogameFragmentMixin$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$VideogameFragmentMixin$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$VideogameFragmentMixin$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllTapsVideogames$Query$Videogame extends JsonSerializable
    with EquatableMixin, VideogameFragmentMixin {
  AllTapsVideogames$Query$Videogame();

  factory AllTapsVideogames$Query$Videogame.fromJson(
          Map<String, dynamic> json) =>
      _$AllTapsVideogames$Query$VideogameFromJson(json);

  @override
  List<Object?> get props => [id, name, postCount, tapCount, file];
  @override
  Map<String, dynamic> toJson() =>
      _$AllTapsVideogames$Query$VideogameToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllTapsVideogames$Query extends JsonSerializable with EquatableMixin {
  AllTapsVideogames$Query();

  factory AllTapsVideogames$Query.fromJson(Map<String, dynamic> json) =>
      _$AllTapsVideogames$QueryFromJson(json);

  late List<AllTapsVideogames$Query$Videogame> allTapsVideogames;

  @override
  List<Object?> get props => [allTapsVideogames];
  @override
  Map<String, dynamic> toJson() => _$AllTapsVideogames$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User();

  factory Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$UserFromJson(
          json);

  late double id;

  late String username;

  late Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like();

  factory Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$LikeFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like$User
      user;

  @override
  List<Object?> get props => [user];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$LikeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post();

  factory Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$PostFromJson(
          json);

  late double id;

  late int likeCount;

  late Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$FileResponse
      fileImg;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post$Like>
      likes;

  @override
  List<Object?> get props => [id, likeCount, fileImg, likes];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotification$PostToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$LikeNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$LikeNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$LikeNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$LikeNotification$Post
      post;

  @override
  List<Object?> get props => [post];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$LikeNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$PostFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post$FileResponse
      fileImg;

  @override
  List<Object?> get props => [id, fileImg];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$PostToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$CommentFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment$Post
      post;

  @override
  List<Object?> get props => [id, post];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$CommentToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTag
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTag();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTagFromJson(
          json);

  @JsonKey(name: 'reply_id')
  late int replyId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [replyId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTagToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$UserFromJson(
          json);

  late double id;

  late String username;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLikeFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike$User
      user;

  @override
  List<Object?> get props => [user];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLikeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$ReplyFromJson(
          json);

  late double id;

  late String reply;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$Comment
      comment;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyUserTag>
      userTags;

  late int likeCount;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply$ReplyLike>
      likes;

  @override
  List<Object?> get props => [id, reply, comment, userTags, likeCount, likes];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$ReplyToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification$Reply
      reply;

  @override
  List<Object?> get props => [reply];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTag
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTag();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTagFromJson(
          json);

  @JsonKey(name: 'comment_id')
  late int commentId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [commentId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTagToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$PostFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post$FileResponse
      fileImg;

  @override
  List<Object?> get props => [id, fileImg];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$PostToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$UserFromJson(
          json);

  late double id;

  late String username;

  late Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLikeFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike$User
      user;

  @override
  List<Object?> get props => [user];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLikeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$CommentFromJson(
          json);

  late double id;

  late String comment;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentUserTag>
      userTags;

  late Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$Post
      post;

  late int likeCount;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment$CommentLike>
      likes;

  @override
  List<Object?> get props => [id, comment, userTags, post, likeCount, likes];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$CommentToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification$Comment
      comment;

  @override
  List<Object?> get props => [comment];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponseFromJson(
          json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User();

  factory Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$FollowNotification$UserFromJson(
          json);

  late double id;

  late String username;

  bool? followState;

  late Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, followState, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$FollowNotification$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$FollowNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$FollowNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$FollowNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$FollowNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$FollowNotification$User
      follower;

  @override
  List<Object?> get props => [follower];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$FollowNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$PostFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post$FileResponse
      fileImg;

  @override
  List<Object?> get props => [id, fileImg];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$PostToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTag
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTag();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTagFromJson(
          json);

  @JsonKey(name: 'comment_id')
  late int commentId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [commentId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTagToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$UserFromJson(
          json);

  late double id;

  late String username;

  late Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$CommentFromJson(
          json);

  late double id;

  late String comment;

  late Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$Post
      post;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$CommentUserTag>
      userTags;

  late Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment$User
      user;

  @override
  List<Object?> get props => [id, comment, post, userTags, user];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotification$CommentToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$CommentNotification$Comment
      comment;

  @override
  List<Object?> get props => [comment];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$PostFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post$FileResponse
      fileImg;

  @override
  List<Object?> get props => [id, fileImg];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$PostToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$CommentFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment$Post
      post;

  @override
  List<Object?> get props => [id, post];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$CommentToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTag
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTag();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTagFromJson(
          json);

  @JsonKey(name: 'reply_id')
  late int replyId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [replyId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTagToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$UserFromJson(
          json);

  late double id;

  late String username;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$ReplyFromJson(
          json);

  late double id;

  late String reply;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$Comment
      comment;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$ReplyUserTag>
      userTags;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply$User
      user;

  @override
  List<Object?> get props => [id, reply, comment, userTags, user];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$ReplyToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$ReplyNotification$Reply
      reply;

  @override
  List<Object?> get props => [reply];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$PostFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post$FileResponse
      fileImg;

  @override
  List<Object?> get props => [id, fileImg];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$PostToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTag
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTag();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTagFromJson(
          json);

  @JsonKey(name: 'comment_id')
  late int commentId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [commentId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTagToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$UserFromJson(
          json);

  late double id;

  late String username;

  late Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$CommentFromJson(
          json);

  late double id;

  late String comment;

  late Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$Post
      post;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$CommentUserTag>
      userTags;

  late Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment$User
      user;

  @override
  List<Object?> get props => [id, comment, post, userTags, user];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$CommentToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification$Comment
      comment;

  @override
  List<Object?> get props => [comment];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CommentTagNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$PostFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post$FileResponse
      fileImg;

  @override
  List<Object?> get props => [id, fileImg];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$PostToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$CommentFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment$Post
      post;

  @override
  List<Object?> get props => [id, post];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$CommentToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTag
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTag();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTagFromJson(
          json);

  @JsonKey(name: 'reply_id')
  late int replyId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [replyId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTagToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$UserFromJson(
          json);

  late double id;

  late String username;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$ReplyFromJson(
          json);

  late double id;

  late String reply;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$Comment
      comment;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$ReplyUserTag>
      userTags;

  late Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply$User
      user;

  @override
  List<Object?> get props => [id, reply, comment, userTags, user];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$ReplyToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification$Reply
      reply;

  @override
  List<Object?> get props => [reply];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTag
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTag();

  factory Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTag.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTagFromJson(
          json);

  @JsonKey(name: 'post_id')
  late int postId;

  @JsonKey(name: 'user_id')
  late int userId;

  @JsonKey(name: 'user_string')
  late String userString;

  @override
  List<Object?> get props => [postId, userId, userString];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTagToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponse();

  factory Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponseFromJson(
          json);

  String? file;

  @override
  List<Object?> get props => [file];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponseToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User();

  factory Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$UserFromJson(
          json);

  late double id;

  late String username;

  late Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User$FileResponse
      smallFile;

  @override
  List<Object?> get props => [id, username, smallFile];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post();

  factory Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$PostFromJson(
          json);

  late double id;

  late Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$FileResponse
      fileImg;

  late String caption;

  late List<
          Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$CaptionUserTag>
      userTags;

  late Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post$User
      user;

  @override
  List<Object?> get props => [id, fileImg, caption, userTags, user];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$PostToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification();

  factory Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotificationFromJson(
          json);

  late Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification$Post
      post;

  @override
  List<Object?> get props => [post];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotificationToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications$Notification
    extends JsonSerializable with EquatableMixin {
  Notifications$Query$PaginatedNotifications$Notification();

  factory Notifications$Query$PaginatedNotifications$Notification.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotifications$NotificationFromJson(json);

  late String type;

  @JsonKey(name: 'parent_id')
  late int parentId;

  @JsonKey(name: 'concatenated_id')
  late String concatenatedId;

  late String updatedAt;

  late String createdAt;

  Notifications$Query$PaginatedNotifications$Notification$LikeNotification?
      likeNotification;

  Notifications$Query$PaginatedNotifications$Notification$ReplyLikeNotification?
      likeReplyNotification;

  Notifications$Query$PaginatedNotifications$Notification$CommentLikeNotification?
      likeCommentNotification;

  Notifications$Query$PaginatedNotifications$Notification$FollowNotification?
      followNotification;

  Notifications$Query$PaginatedNotifications$Notification$CommentNotification?
      commentNotification;

  Notifications$Query$PaginatedNotifications$Notification$ReplyNotification?
      replyNotification;

  Notifications$Query$PaginatedNotifications$Notification$CommentTagNotification?
      commentTagNotification;

  Notifications$Query$PaginatedNotifications$Notification$ReplyTagNotification?
      replyTagNotification;

  Notifications$Query$PaginatedNotifications$Notification$CaptionTagNotification?
      captionTagNotification;

  @override
  List<Object?> get props => [
        type,
        parentId,
        concatenatedId,
        updatedAt,
        createdAt,
        likeNotification,
        likeReplyNotification,
        likeCommentNotification,
        followNotification,
        commentNotification,
        replyNotification,
        commentTagNotification,
        replyTagNotification,
        captionTagNotification
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotifications$NotificationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query$PaginatedNotifications extends JsonSerializable
    with EquatableMixin {
  Notifications$Query$PaginatedNotifications();

  factory Notifications$Query$PaginatedNotifications.fromJson(
          Map<String, dynamic> json) =>
      _$Notifications$Query$PaginatedNotificationsFromJson(json);

  late List<Notifications$Query$PaginatedNotifications$Notification>
      notifications;

  late bool hasMore;

  @override
  List<Object?> get props => [notifications, hasMore];
  @override
  Map<String, dynamic> toJson() =>
      _$Notifications$Query$PaginatedNotificationsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Notifications$Query extends JsonSerializable with EquatableMixin {
  Notifications$Query();

  factory Notifications$Query.fromJson(Map<String, dynamic> json) =>
      _$Notifications$QueryFromJson(json);

  late Notifications$Query$PaginatedNotifications notifications;

  @override
  List<Object?> get props => [notifications];
  @override
  Map<String, dynamic> toJson() => _$Notifications$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowers$Query$PaginatedFollow$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  UserFollowers$Query$PaginatedFollow$User$FileResponse();

  factory UserFollowers$Query$PaginatedFollow$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UserFollowers$Query$PaginatedFollow$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$UserFollowers$Query$PaginatedFollow$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowers$Query$PaginatedFollow$User extends JsonSerializable
    with EquatableMixin {
  UserFollowers$Query$PaginatedFollow$User();

  factory UserFollowers$Query$PaginatedFollow$User.fromJson(
          Map<String, dynamic> json) =>
      _$UserFollowers$Query$PaginatedFollow$UserFromJson(json);

  late double id;

  late String username;

  late String name;

  late UserFollowers$Query$PaginatedFollow$User$FileResponse smallFile;

  bool? followState;

  late String createdAt;

  @override
  List<Object?> get props =>
      [id, username, name, smallFile, followState, createdAt];
  @override
  Map<String, dynamic> toJson() =>
      _$UserFollowers$Query$PaginatedFollow$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowers$Query$PaginatedFollow extends JsonSerializable
    with EquatableMixin {
  UserFollowers$Query$PaginatedFollow();

  factory UserFollowers$Query$PaginatedFollow.fromJson(
          Map<String, dynamic> json) =>
      _$UserFollowers$Query$PaginatedFollowFromJson(json);

  late List<UserFollowers$Query$PaginatedFollow$User> users;

  late bool hasMore;

  late int userId;

  @override
  List<Object?> get props => [users, hasMore, userId];
  @override
  Map<String, dynamic> toJson() =>
      _$UserFollowers$Query$PaginatedFollowToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowers$Query extends JsonSerializable with EquatableMixin {
  UserFollowers$Query();

  factory UserFollowers$Query.fromJson(Map<String, dynamic> json) =>
      _$UserFollowers$QueryFromJson(json);

  late UserFollowers$Query$PaginatedFollow userFollowers;

  @override
  List<Object?> get props => [userFollowers];
  @override
  Map<String, dynamic> toJson() => _$UserFollowers$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VerifyResetCode$Query extends JsonSerializable with EquatableMixin {
  VerifyResetCode$Query();

  factory VerifyResetCode$Query.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCode$QueryFromJson(json);

  late bool verifyResetCode;

  @override
  List<Object?> get props => [verifyResetCode];
  @override
  Map<String, dynamic> toJson() => _$VerifyResetCode$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchedUsers$Query$UserSearch$User$FileResponse extends JsonSerializable
    with EquatableMixin {
  SearchedUsers$Query$UserSearch$User$FileResponse();

  factory SearchedUsers$Query$UserSearch$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SearchedUsers$Query$UserSearch$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$SearchedUsers$Query$UserSearch$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchedUsers$Query$UserSearch$User extends JsonSerializable
    with EquatableMixin {
  SearchedUsers$Query$UserSearch$User();

  factory SearchedUsers$Query$UserSearch$User.fromJson(
          Map<String, dynamic> json) =>
      _$SearchedUsers$Query$UserSearch$UserFromJson(json);

  late double id;

  late String username;

  late String name;

  late SearchedUsers$Query$UserSearch$User$FileResponse file;

  @override
  List<Object?> get props => [id, username, name, file];
  @override
  Map<String, dynamic> toJson() =>
      _$SearchedUsers$Query$UserSearch$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchedUsers$Query$UserSearch extends JsonSerializable
    with EquatableMixin {
  SearchedUsers$Query$UserSearch();

  factory SearchedUsers$Query$UserSearch.fromJson(Map<String, dynamic> json) =>
      _$SearchedUsers$Query$UserSearchFromJson(json);

  late int searchedUserId;

  late SearchedUsers$Query$UserSearch$User searchedUser;

  late String updatedAt;

  @override
  List<Object?> get props => [searchedUserId, searchedUser, updatedAt];
  @override
  Map<String, dynamic> toJson() => _$SearchedUsers$Query$UserSearchToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchedUsers$Query extends JsonSerializable with EquatableMixin {
  SearchedUsers$Query();

  factory SearchedUsers$Query.fromJson(Map<String, dynamic> json) =>
      _$SearchedUsers$QueryFromJson(json);

  late List<SearchedUsers$Query$UserSearch> searchedUsers;

  @override
  List<Object?> get props => [searchedUsers];
  @override
  Map<String, dynamic> toJson() => _$SearchedUsers$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VideogamePosts$Query$PaginatedPosts$Post extends JsonSerializable
    with EquatableMixin, PostFragmentMixin {
  VideogamePosts$Query$PaginatedPosts$Post();

  factory VideogamePosts$Query$PaginatedPosts$Post.fromJson(
          Map<String, dynamic> json) =>
      _$VideogamePosts$Query$PaginatedPosts$PostFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        file,
        user,
        userTags,
        likeState,
        likeCount,
        caption,
        createdAt,
        commentCount,
        viewsCount,
        fileWidth,
        fileHeight
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$VideogamePosts$Query$PaginatedPosts$PostToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VideogamePosts$Query$PaginatedPosts extends JsonSerializable
    with EquatableMixin {
  VideogamePosts$Query$PaginatedPosts();

  factory VideogamePosts$Query$PaginatedPosts.fromJson(
          Map<String, dynamic> json) =>
      _$VideogamePosts$Query$PaginatedPostsFromJson(json);

  late List<VideogamePosts$Query$PaginatedPosts$Post> posts;

  late bool hasMore;

  @override
  List<Object?> get props => [posts, hasMore];
  @override
  Map<String, dynamic> toJson() =>
      _$VideogamePosts$Query$PaginatedPostsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VideogamePosts$Query extends JsonSerializable with EquatableMixin {
  VideogamePosts$Query();

  factory VideogamePosts$Query.fromJson(Map<String, dynamic> json) =>
      _$VideogamePosts$QueryFromJson(json);

  late VideogamePosts$Query$PaginatedPosts videogamePosts;

  @override
  List<Object?> get props => [videogamePosts];
  @override
  Map<String, dynamic> toJson() => _$VideogamePosts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Me$Query$User$FileResponse extends JsonSerializable with EquatableMixin {
  Me$Query$User$FileResponse();

  factory Me$Query$User$FileResponse.fromJson(Map<String, dynamic> json) =>
      _$Me$Query$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() => _$Me$Query$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Me$Query$User extends JsonSerializable with EquatableMixin {
  Me$Query$User();

  factory Me$Query$User.fromJson(Map<String, dynamic> json) =>
      _$Me$Query$UserFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late double id;

  late String username;

  late String name;

  late String email;

  late String bio;

  late Me$Query$User$FileResponse file;

  late Me$Query$User$FileResponse smallFile;

  bool? followState;

  late int followingCount;

  late int followersCount;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        username,
        name,
        email,
        bio,
        file,
        smallFile,
        followState,
        followingCount,
        followersCount
      ];
  @override
  Map<String, dynamic> toJson() => _$Me$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Me$Query extends JsonSerializable with EquatableMixin {
  Me$Query();

  factory Me$Query.fromJson(Map<String, dynamic> json) =>
      _$Me$QueryFromJson(json);

  late Me$Query$User me;

  @override
  List<Object?> get props => [me];
  @override
  Map<String, dynamic> toJson() => _$Me$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllVideogameGenres$Query$VideogameGenre extends JsonSerializable
    with EquatableMixin {
  AllVideogameGenres$Query$VideogameGenre();

  factory AllVideogameGenres$Query$VideogameGenre.fromJson(
          Map<String, dynamic> json) =>
      _$AllVideogameGenres$Query$VideogameGenreFromJson(json);

  late int id;

  @JsonKey(name: 'videogame_genre')
  late String videogameGenre;

  @override
  List<Object?> get props => [id, videogameGenre];
  @override
  Map<String, dynamic> toJson() =>
      _$AllVideogameGenres$Query$VideogameGenreToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllVideogameGenres$Query extends JsonSerializable with EquatableMixin {
  AllVideogameGenres$Query();

  factory AllVideogameGenres$Query.fromJson(Map<String, dynamic> json) =>
      _$AllVideogameGenres$QueryFromJson(json);

  late List<AllVideogameGenres$Query$VideogameGenre> allVideogameGenres;

  @override
  List<Object?> get props => [allVideogameGenres];
  @override
  Map<String, dynamic> toJson() => _$AllVideogameGenres$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FollowingPosts$Query$PaginatedPosts$Post extends JsonSerializable
    with EquatableMixin, PostFragmentMixin {
  FollowingPosts$Query$PaginatedPosts$Post();

  factory FollowingPosts$Query$PaginatedPosts$Post.fromJson(
          Map<String, dynamic> json) =>
      _$FollowingPosts$Query$PaginatedPosts$PostFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        file,
        user,
        userTags,
        likeState,
        likeCount,
        caption,
        createdAt,
        commentCount,
        viewsCount,
        fileWidth,
        fileHeight
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$FollowingPosts$Query$PaginatedPosts$PostToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FollowingPosts$Query$PaginatedPosts extends JsonSerializable
    with EquatableMixin {
  FollowingPosts$Query$PaginatedPosts();

  factory FollowingPosts$Query$PaginatedPosts.fromJson(
          Map<String, dynamic> json) =>
      _$FollowingPosts$Query$PaginatedPostsFromJson(json);

  late List<FollowingPosts$Query$PaginatedPosts$Post> posts;

  late bool hasMore;

  @override
  List<Object?> get props => [posts, hasMore];
  @override
  Map<String, dynamic> toJson() =>
      _$FollowingPosts$Query$PaginatedPostsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FollowingPosts$Query extends JsonSerializable with EquatableMixin {
  FollowingPosts$Query();

  factory FollowingPosts$Query.fromJson(Map<String, dynamic> json) =>
      _$FollowingPosts$QueryFromJson(json);

  late FollowingPosts$Query$PaginatedPosts followingPosts;

  @override
  List<Object?> get props => [followingPosts];
  @override
  Map<String, dynamic> toJson() => _$FollowingPosts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchUsers$Query$User$FileResponse extends JsonSerializable
    with EquatableMixin {
  SearchUsers$Query$User$FileResponse();

  factory SearchUsers$Query$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SearchUsers$Query$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$SearchUsers$Query$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchUsers$Query$User extends JsonSerializable with EquatableMixin {
  SearchUsers$Query$User();

  factory SearchUsers$Query$User.fromJson(Map<String, dynamic> json) =>
      _$SearchUsers$Query$UserFromJson(json);

  late double id;

  late String username;

  late String name;

  late SearchUsers$Query$User$FileResponse smallFile;

  @override
  List<Object?> get props => [id, username, name, smallFile];
  @override
  Map<String, dynamic> toJson() => _$SearchUsers$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchUsers$Query extends JsonSerializable with EquatableMixin {
  SearchUsers$Query();

  factory SearchUsers$Query.fromJson(Map<String, dynamic> json) =>
      _$SearchUsers$QueryFromJson(json);

  late List<SearchUsers$Query$User> searchUsers;

  @override
  List<Object?> get props => [searchUsers];
  @override
  Map<String, dynamic> toJson() => _$SearchUsers$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowing$Query$PaginatedFollow$User$FileResponse
    extends JsonSerializable with EquatableMixin {
  UserFollowing$Query$PaginatedFollow$User$FileResponse();

  factory UserFollowing$Query$PaginatedFollow$User$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UserFollowing$Query$PaginatedFollow$User$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$UserFollowing$Query$PaginatedFollow$User$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowing$Query$PaginatedFollow$User extends JsonSerializable
    with EquatableMixin {
  UserFollowing$Query$PaginatedFollow$User();

  factory UserFollowing$Query$PaginatedFollow$User.fromJson(
          Map<String, dynamic> json) =>
      _$UserFollowing$Query$PaginatedFollow$UserFromJson(json);

  late double id;

  late String username;

  late String name;

  late UserFollowing$Query$PaginatedFollow$User$FileResponse smallFile;

  bool? followState;

  late String createdAt;

  @override
  List<Object?> get props =>
      [id, username, name, smallFile, followState, createdAt];
  @override
  Map<String, dynamic> toJson() =>
      _$UserFollowing$Query$PaginatedFollow$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowing$Query$PaginatedFollow extends JsonSerializable
    with EquatableMixin {
  UserFollowing$Query$PaginatedFollow();

  factory UserFollowing$Query$PaginatedFollow.fromJson(
          Map<String, dynamic> json) =>
      _$UserFollowing$Query$PaginatedFollowFromJson(json);

  late List<UserFollowing$Query$PaginatedFollow$User> users;

  late bool hasMore;

  late int userId;

  @override
  List<Object?> get props => [users, hasMore, userId];
  @override
  Map<String, dynamic> toJson() =>
      _$UserFollowing$Query$PaginatedFollowToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFollowing$Query extends JsonSerializable with EquatableMixin {
  UserFollowing$Query();

  factory UserFollowing$Query.fromJson(Map<String, dynamic> json) =>
      _$UserFollowing$QueryFromJson(json);

  late UserFollowing$Query$PaginatedFollow userFollowing;

  @override
  List<Object?> get props => [userFollowing];
  @override
  Map<String, dynamic> toJson() => _$UserFollowing$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Replies$Query$ReplyResponse$Reply extends JsonSerializable
    with EquatableMixin, ReplyFragmentMixin {
  Replies$Query$ReplyResponse$Reply();

  factory Replies$Query$ReplyResponse$Reply.fromJson(
          Map<String, dynamic> json) =>
      _$Replies$Query$ReplyResponse$ReplyFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        reply,
        userId,
        commentId,
        postId,
        createdAt,
        likeCount,
        likeState,
        user,
        userTags
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$Replies$Query$ReplyResponse$ReplyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Replies$Query$ReplyResponse extends JsonSerializable with EquatableMixin {
  Replies$Query$ReplyResponse();

  factory Replies$Query$ReplyResponse.fromJson(Map<String, dynamic> json) =>
      _$Replies$Query$ReplyResponseFromJson(json);

  late List<Replies$Query$ReplyResponse$Reply> replies;

  late bool hasMore;

  late int commentId;

  late int postId;

  @override
  List<Object?> get props => [replies, hasMore, commentId, postId];
  @override
  Map<String, dynamic> toJson() => _$Replies$Query$ReplyResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Replies$Query extends JsonSerializable with EquatableMixin {
  Replies$Query();

  factory Replies$Query.fromJson(Map<String, dynamic> json) =>
      _$Replies$QueryFromJson(json);

  late Replies$Query$ReplyResponse commentReplies;

  @override
  List<Object?> get props => [commentReplies];
  @override
  Map<String, dynamic> toJson() => _$Replies$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserPosts$Query$PaginatedPosts$Post$FileResponse extends JsonSerializable
    with EquatableMixin {
  UserPosts$Query$PaginatedPosts$Post$FileResponse();

  factory UserPosts$Query$PaginatedPosts$Post$FileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UserPosts$Query$PaginatedPosts$Post$FileResponseFromJson(json);

  String? file;

  String? error;

  @override
  List<Object?> get props => [file, error];
  @override
  Map<String, dynamic> toJson() =>
      _$UserPosts$Query$PaginatedPosts$Post$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserPosts$Query$PaginatedPosts$Post extends JsonSerializable
    with EquatableMixin, PostFragmentMixin {
  UserPosts$Query$PaginatedPosts$Post();

  factory UserPosts$Query$PaginatedPosts$Post.fromJson(
          Map<String, dynamic> json) =>
      _$UserPosts$Query$PaginatedPosts$PostFromJson(json);

  late UserPosts$Query$PaginatedPosts$Post$FileResponse fileGif;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        file,
        user,
        userTags,
        likeState,
        likeCount,
        caption,
        createdAt,
        commentCount,
        viewsCount,
        fileWidth,
        fileHeight,
        fileGif
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$UserPosts$Query$PaginatedPosts$PostToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserPosts$Query$PaginatedPosts extends JsonSerializable
    with EquatableMixin {
  UserPosts$Query$PaginatedPosts();

  factory UserPosts$Query$PaginatedPosts.fromJson(Map<String, dynamic> json) =>
      _$UserPosts$Query$PaginatedPostsFromJson(json);

  late List<UserPosts$Query$PaginatedPosts$Post> posts;

  late bool hasMore;

  @override
  List<Object?> get props => [posts, hasMore];
  @override
  Map<String, dynamic> toJson() => _$UserPosts$Query$PaginatedPostsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserPosts$Query extends JsonSerializable with EquatableMixin {
  UserPosts$Query();

  factory UserPosts$Query.fromJson(Map<String, dynamic> json) =>
      _$UserPosts$QueryFromJson(json);

  late UserPosts$Query$PaginatedPosts userPosts;

  @override
  List<Object?> get props => [userPosts];
  @override
  Map<String, dynamic> toJson() => _$UserPosts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Posts$Query$PaginatedPosts$Post extends JsonSerializable
    with EquatableMixin, PostFragmentMixin {
  Posts$Query$PaginatedPosts$Post();

  factory Posts$Query$PaginatedPosts$Post.fromJson(Map<String, dynamic> json) =>
      _$Posts$Query$PaginatedPosts$PostFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        file,
        user,
        userTags,
        likeState,
        likeCount,
        caption,
        createdAt,
        commentCount,
        viewsCount,
        fileWidth,
        fileHeight
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$Posts$Query$PaginatedPosts$PostToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Posts$Query$PaginatedPosts extends JsonSerializable with EquatableMixin {
  Posts$Query$PaginatedPosts();

  factory Posts$Query$PaginatedPosts.fromJson(Map<String, dynamic> json) =>
      _$Posts$Query$PaginatedPostsFromJson(json);

  late List<Posts$Query$PaginatedPosts$Post> posts;

  late bool hasMore;

  @override
  List<Object?> get props => [posts, hasMore];
  @override
  Map<String, dynamic> toJson() => _$Posts$Query$PaginatedPostsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Posts$Query extends JsonSerializable with EquatableMixin {
  Posts$Query();

  factory Posts$Query.fromJson(Map<String, dynamic> json) =>
      _$Posts$QueryFromJson(json);

  late Posts$Query$PaginatedPosts posts;

  @override
  List<Object?> get props => [posts];
  @override
  Map<String, dynamic> toJson() => _$Posts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RefreshTokensArguments extends JsonSerializable with EquatableMixin {
  RefreshTokensArguments({required this.token});

  @override
  factory RefreshTokensArguments.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokensArgumentsFromJson(json);

  late String token;

  @override
  List<Object?> get props => [token];
  @override
  Map<String, dynamic> toJson() => _$RefreshTokensArgumentsToJson(this);
}

final REFRESH_TOKENS_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RefreshTokens'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'token')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'refreshToken'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'token'),
                  value: VariableNode(name: NameNode(value: 'token')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'TokensFragment'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'TokensFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'TokenResponse'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'refreshToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'accessToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class RefreshTokensMutation
    extends GraphQLQuery<RefreshTokens$Mutation, RefreshTokensArguments> {
  RefreshTokensMutation({required this.variables});

  @override
  final DocumentNode document = REFRESH_TOKENS_MUTATION_DOCUMENT;

  @override
  final String operationName = 'RefreshTokens';

  @override
  final RefreshTokensArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  RefreshTokens$Mutation parse(Map<String, dynamic> json) =>
      RefreshTokens$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikeReplyArguments extends JsonSerializable with EquatableMixin {
  LikeUnlikeReplyArguments({required this.replyId, required this.clientId});

  @override
  factory LikeUnlikeReplyArguments.fromJson(Map<String, dynamic> json) =>
      _$LikeUnlikeReplyArgumentsFromJson(json);

  late int replyId;

  late String clientId;

  @override
  List<Object?> get props => [replyId, clientId];
  @override
  Map<String, dynamic> toJson() => _$LikeUnlikeReplyArgumentsToJson(this);
}

final LIKE_UNLIKE_REPLY_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'LikeUnlikeReply'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'replyId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'clientId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'likeUnlikeReply'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'replyId'),
                  value: VariableNode(name: NameNode(value: 'replyId'))),
              ArgumentNode(
                  name: NameNode(value: 'clientId'),
                  value: VariableNode(name: NameNode(value: 'clientId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'value'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'clientId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class LikeUnlikeReplyMutation
    extends GraphQLQuery<LikeUnlikeReply$Mutation, LikeUnlikeReplyArguments> {
  LikeUnlikeReplyMutation({required this.variables});

  @override
  final DocumentNode document = LIKE_UNLIKE_REPLY_MUTATION_DOCUMENT;

  @override
  final String operationName = 'LikeUnlikeReply';

  @override
  final LikeUnlikeReplyArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  LikeUnlikeReply$Mutation parse(Map<String, dynamic> json) =>
      LikeUnlikeReply$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ViewClipArguments extends JsonSerializable with EquatableMixin {
  ViewClipArguments({required this.postId});

  @override
  factory ViewClipArguments.fromJson(Map<String, dynamic> json) =>
      _$ViewClipArgumentsFromJson(json);

  late int postId;

  @override
  List<Object?> get props => [postId];
  @override
  Map<String, dynamic> toJson() => _$ViewClipArgumentsToJson(this);
}

final VIEW_CLIP_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ViewClip'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'postId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'viewClip'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'postId'),
                  value: VariableNode(name: NameNode(value: 'postId')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class ViewClipMutation
    extends GraphQLQuery<ViewClip$Mutation, ViewClipArguments> {
  ViewClipMutation({required this.variables});

  @override
  final DocumentNode document = VIEW_CLIP_MUTATION_DOCUMENT;

  @override
  final String operationName = 'ViewClip';

  @override
  final ViewClipArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ViewClip$Mutation parse(Map<String, dynamic> json) =>
      ViewClip$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikePostArguments extends JsonSerializable with EquatableMixin {
  LikeUnlikePostArguments({required this.postId, required this.clientId});

  @override
  factory LikeUnlikePostArguments.fromJson(Map<String, dynamic> json) =>
      _$LikeUnlikePostArgumentsFromJson(json);

  late int postId;

  late String clientId;

  @override
  List<Object?> get props => [postId, clientId];
  @override
  Map<String, dynamic> toJson() => _$LikeUnlikePostArgumentsToJson(this);
}

final LIKE_UNLIKE_POST_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'LikeUnlikePost'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'postId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'clientId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'likeUnlikePost'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'postId'),
                  value: VariableNode(name: NameNode(value: 'postId'))),
              ArgumentNode(
                  name: NameNode(value: 'clientId'),
                  value: VariableNode(name: NameNode(value: 'clientId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'value'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'clientId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class LikeUnlikePostMutation
    extends GraphQLQuery<LikeUnlikePost$Mutation, LikeUnlikePostArguments> {
  LikeUnlikePostMutation({required this.variables});

  @override
  final DocumentNode document = LIKE_UNLIKE_POST_MUTATION_DOCUMENT;

  @override
  final String operationName = 'LikeUnlikePost';

  @override
  final LikeUnlikePostArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  LikeUnlikePost$Mutation parse(Map<String, dynamic> json) =>
      LikeUnlikePost$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SignInArguments extends JsonSerializable with EquatableMixin {
  SignInArguments({required this.input, required this.deviceInput});

  @override
  factory SignInArguments.fromJson(Map<String, dynamic> json) =>
      _$SignInArgumentsFromJson(json);

  late SignInInput input;

  late DeviceInput deviceInput;

  @override
  List<Object?> get props => [input, deviceInput];
  @override
  Map<String, dynamic> toJson() => _$SignInArgumentsToJson(this);
}

final SIGN_IN_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SignIn'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'SignInInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'deviceInput')),
            type: NamedTypeNode(
                name: NameNode(value: 'DeviceInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'signIn'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input'))),
              ArgumentNode(
                  name: NameNode(value: 'deviceInput'),
                  value: VariableNode(name: NameNode(value: 'deviceInput')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'errors'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'tokens'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'TokensFragment'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'username'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'FileFragment'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'FileFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'FileResponse'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'error'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'TokensFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'TokenResponse'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'refreshToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'accessToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class SignInMutation extends GraphQLQuery<SignIn$Mutation, SignInArguments> {
  SignInMutation({required this.variables});

  @override
  final DocumentNode document = SIGN_IN_MUTATION_DOCUMENT;

  @override
  final String operationName = 'SignIn';

  @override
  final SignInArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SignIn$Mutation parse(Map<String, dynamic> json) =>
      SignIn$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class AddNewDeviceTokenArguments extends JsonSerializable with EquatableMixin {
  AddNewDeviceTokenArguments({required this.deviceInput});

  @override
  factory AddNewDeviceTokenArguments.fromJson(Map<String, dynamic> json) =>
      _$AddNewDeviceTokenArgumentsFromJson(json);

  late DeviceInput deviceInput;

  @override
  List<Object?> get props => [deviceInput];
  @override
  Map<String, dynamic> toJson() => _$AddNewDeviceTokenArgumentsToJson(this);
}

final ADD_NEW_DEVICE_TOKEN_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddNewDeviceToken'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'deviceInput')),
            type: NamedTypeNode(
                name: NameNode(value: 'DeviceInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'addNewDeviceToken'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'deviceInput'),
                  value: VariableNode(name: NameNode(value: 'deviceInput')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class AddNewDeviceTokenMutation extends GraphQLQuery<AddNewDeviceToken$Mutation,
    AddNewDeviceTokenArguments> {
  AddNewDeviceTokenMutation({required this.variables});

  @override
  final DocumentNode document = ADD_NEW_DEVICE_TOKEN_MUTATION_DOCUMENT;

  @override
  final String operationName = 'AddNewDeviceToken';

  @override
  final AddNewDeviceTokenArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  AddNewDeviceToken$Mutation parse(Map<String, dynamic> json) =>
      AddNewDeviceToken$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CommentPostArguments extends JsonSerializable with EquatableMixin {
  CommentPostArguments(
      {required this.postId,
      required this.comment,
      required this.userTagsInput});

  @override
  factory CommentPostArguments.fromJson(Map<String, dynamic> json) =>
      _$CommentPostArgumentsFromJson(json);

  late int postId;

  late String comment;

  late List<UserTagInput> userTagsInput;

  @override
  List<Object?> get props => [postId, comment, userTagsInput];
  @override
  Map<String, dynamic> toJson() => _$CommentPostArgumentsToJson(this);
}

final COMMENT_POST_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CommentPost'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'postId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'comment')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userTagsInput')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'UserTagInput'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'commentPost'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'postId'),
                  value: VariableNode(name: NameNode(value: 'postId'))),
              ArgumentNode(
                  name: NameNode(value: 'comment'),
                  value: VariableNode(name: NameNode(value: 'comment'))),
              ArgumentNode(
                  name: NameNode(value: 'userTagsInput'),
                  value: VariableNode(name: NameNode(value: 'userTagsInput')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'comment'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'CommentFragment'),
                        directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'postId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'CommentFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Comment'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'comment'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'post_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'replyCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'comment_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class CommentPostMutation
    extends GraphQLQuery<CommentPost$Mutation, CommentPostArguments> {
  CommentPostMutation({required this.variables});

  @override
  final DocumentNode document = COMMENT_POST_MUTATION_DOCUMENT;

  @override
  final String operationName = 'CommentPost';

  @override
  final CommentPostArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CommentPost$Mutation parse(Map<String, dynamic> json) =>
      CommentPost$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserTappedArguments extends JsonSerializable with EquatableMixin {
  UserTappedArguments({required this.id});

  @override
  factory UserTappedArguments.fromJson(Map<String, dynamic> json) =>
      _$UserTappedArgumentsFromJson(json);

  late int id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$UserTappedArgumentsToJson(this);
}

final USER_TAPPED_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'userTapped'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userTapped'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class UserTappedMutation
    extends GraphQLQuery<UserTapped$Mutation, UserTappedArguments> {
  UserTappedMutation({required this.variables});

  @override
  final DocumentNode document = USER_TAPPED_MUTATION_DOCUMENT;

  @override
  final String operationName = 'userTapped';

  @override
  final UserTappedArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UserTapped$Mutation parse(Map<String, dynamic> json) =>
      UserTapped$Mutation.fromJson(json);
}

final DELETE_USER_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteUser'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'deleteUser'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class DeleteUserMutation
    extends GraphQLQuery<DeleteUser$Mutation, JsonSerializable> {
  DeleteUserMutation();

  @override
  final DocumentNode document = DELETE_USER_MUTATION_DOCUMENT;

  @override
  final String operationName = 'DeleteUser';

  @override
  List<Object?> get props => [document, operationName];
  @override
  DeleteUser$Mutation parse(Map<String, dynamic> json) =>
      DeleteUser$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordAndSignInArguments extends JsonSerializable
    with EquatableMixin {
  ChangePasswordAndSignInArguments(
      {required this.deviceInput,
      required this.email,
      required this.code,
      required this.newPassword});

  @override
  factory ChangePasswordAndSignInArguments.fromJson(
          Map<String, dynamic> json) =>
      _$ChangePasswordAndSignInArgumentsFromJson(json);

  late DeviceInput deviceInput;

  late String email;

  late String code;

  late String newPassword;

  @override
  List<Object?> get props => [deviceInput, email, code, newPassword];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangePasswordAndSignInArgumentsToJson(this);
}

final CHANGE_PASSWORD_AND_SIGN_IN_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ChangePasswordAndSignIn'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'deviceInput')),
            type: NamedTypeNode(
                name: NameNode(value: 'DeviceInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'email')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'code')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'newPassword')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'changePasswordAndSignIn'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'deviceInput'),
                  value: VariableNode(name: NameNode(value: 'deviceInput'))),
              ArgumentNode(
                  name: NameNode(value: 'email'),
                  value: VariableNode(name: NameNode(value: 'email'))),
              ArgumentNode(
                  name: NameNode(value: 'code'),
                  value: VariableNode(name: NameNode(value: 'code'))),
              ArgumentNode(
                  name: NameNode(value: 'newPassword'),
                  value: VariableNode(name: NameNode(value: 'newPassword')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'errors'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'tokens'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'TokensFragment'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'username'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'FileFragment'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'FileFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'FileResponse'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'error'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'TokensFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'TokenResponse'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'refreshToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'accessToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class ChangePasswordAndSignInMutation extends GraphQLQuery<
    ChangePasswordAndSignIn$Mutation, ChangePasswordAndSignInArguments> {
  ChangePasswordAndSignInMutation({required this.variables});

  @override
  final DocumentNode document = CHANGE_PASSWORD_AND_SIGN_IN_MUTATION_DOCUMENT;

  @override
  final String operationName = 'ChangePasswordAndSignIn';

  @override
  final ChangePasswordAndSignInArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ChangePasswordAndSignIn$Mutation parse(Map<String, dynamic> json) =>
      ChangePasswordAndSignIn$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class EditProfileArguments extends JsonSerializable with EquatableMixin {
  EditProfileArguments({required this.input, this.file, this.smallFile});

  @override
  factory EditProfileArguments.fromJson(Map<String, dynamic> json) =>
      _$EditProfileArgumentsFromJson(json);

  late UserUpdateInput input;

  @JsonKey(
      fromJson: fromGraphQLUploadNullableToDartCustomMultipartFileNullable,
      toJson: fromDartCustomMultipartFileNullableToGraphQLUploadNullable)
  final CustomMultipartFile? file;

  @JsonKey(
      fromJson: fromGraphQLUploadNullableToDartCustomMultipartFileNullable,
      toJson: fromDartCustomMultipartFileNullableToGraphQLUploadNullable)
  final CustomMultipartFile? smallFile;

  @override
  List<Object?> get props => [input, file, smallFile];
  @override
  Map<String, dynamic> toJson() => _$EditProfileArgumentsToJson(this);
}

final EDIT_PROFILE_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'EditProfile'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'UserUpdateInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'file')),
            type: NamedTypeNode(
                name: NameNode(value: 'Upload'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'smallFile')),
            type: NamedTypeNode(
                name: NameNode(value: 'Upload'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'editUser'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input'))),
              ArgumentNode(
                  name: NameNode(value: 'file'),
                  value: VariableNode(name: NameNode(value: 'file'))),
              ArgumentNode(
                  name: NameNode(value: 'smallFile'),
                  value: VariableNode(name: NameNode(value: 'smallFile')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'errors'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'email'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'bio'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'file'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'error'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'followingCount'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'followersCount'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class EditProfileMutation
    extends GraphQLQuery<EditProfile$Mutation, EditProfileArguments> {
  EditProfileMutation({required this.variables});

  @override
  final DocumentNode document = EDIT_PROFILE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'EditProfile';

  @override
  final EditProfileArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  EditProfile$Mutation parse(Map<String, dynamic> json) =>
      EditProfile$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteCommentArguments extends JsonSerializable with EquatableMixin {
  DeleteCommentArguments({required this.commentId, required this.isReply});

  @override
  factory DeleteCommentArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteCommentArgumentsFromJson(json);

  late int commentId;

  late bool isReply;

  @override
  List<Object?> get props => [commentId, isReply];
  @override
  Map<String, dynamic> toJson() => _$DeleteCommentArgumentsToJson(this);
}

final DELETE_COMMENT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteComment'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'commentId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'isReply')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'deleteComment'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'commentId'),
                  value: VariableNode(name: NameNode(value: 'commentId'))),
              ArgumentNode(
                  name: NameNode(value: 'isReply'),
                  value: VariableNode(name: NameNode(value: 'isReply')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class DeleteCommentMutation
    extends GraphQLQuery<DeleteComment$Mutation, DeleteCommentArguments> {
  DeleteCommentMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_COMMENT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'DeleteComment';

  @override
  final DeleteCommentArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteComment$Mutation parse(Map<String, dynamic> json) =>
      DeleteComment$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class RegisterArguments extends JsonSerializable with EquatableMixin {
  RegisterArguments({required this.input, required this.deviceInput});

  @override
  factory RegisterArguments.fromJson(Map<String, dynamic> json) =>
      _$RegisterArgumentsFromJson(json);

  late RegisterInput input;

  late DeviceInput deviceInput;

  @override
  List<Object?> get props => [input, deviceInput];
  @override
  Map<String, dynamic> toJson() => _$RegisterArgumentsToJson(this);
}

final REGISTER_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'Register'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'RegisterInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'deviceInput')),
            type: NamedTypeNode(
                name: NameNode(value: 'DeviceInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'register'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input'))),
              ArgumentNode(
                  name: NameNode(value: 'deviceInput'),
                  value: VariableNode(name: NameNode(value: 'deviceInput')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'errors'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'tokens'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'TokensFragment'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'username'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'FileFragment'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'FileFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'FileResponse'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'error'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'TokensFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'TokenResponse'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'refreshToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'accessToken'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class RegisterMutation
    extends GraphQLQuery<Register$Mutation, RegisterArguments> {
  RegisterMutation({required this.variables});

  @override
  final DocumentNode document = REGISTER_MUTATION_DOCUMENT;

  @override
  final String operationName = 'Register';

  @override
  final RegisterArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Register$Mutation parse(Map<String, dynamic> json) =>
      Register$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class LikeUnlikeCommentArguments extends JsonSerializable with EquatableMixin {
  LikeUnlikeCommentArguments({required this.commentId, required this.clientId});

  @override
  factory LikeUnlikeCommentArguments.fromJson(Map<String, dynamic> json) =>
      _$LikeUnlikeCommentArgumentsFromJson(json);

  late int commentId;

  late String clientId;

  @override
  List<Object?> get props => [commentId, clientId];
  @override
  Map<String, dynamic> toJson() => _$LikeUnlikeCommentArgumentsToJson(this);
}

final LIKE_UNLIKE_COMMENT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'LikeUnlikeComment'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'commentId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'clientId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'likeUnlikeComment'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'commentId'),
                  value: VariableNode(name: NameNode(value: 'commentId'))),
              ArgumentNode(
                  name: NameNode(value: 'clientId'),
                  value: VariableNode(name: NameNode(value: 'clientId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'value'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'clientId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class LikeUnlikeCommentMutation extends GraphQLQuery<LikeUnlikeComment$Mutation,
    LikeUnlikeCommentArguments> {
  LikeUnlikeCommentMutation({required this.variables});

  @override
  final DocumentNode document = LIKE_UNLIKE_COMMENT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'LikeUnlikeComment';

  @override
  final LikeUnlikeCommentArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  LikeUnlikeComment$Mutation parse(Map<String, dynamic> json) =>
      LikeUnlikeComment$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteUserSearchArguments extends JsonSerializable with EquatableMixin {
  DeleteUserSearchArguments({required this.searchedUserId});

  @override
  factory DeleteUserSearchArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserSearchArgumentsFromJson(json);

  late int searchedUserId;

  @override
  List<Object?> get props => [searchedUserId];
  @override
  Map<String, dynamic> toJson() => _$DeleteUserSearchArgumentsToJson(this);
}

final DELETE_USER_SEARCH_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteUserSearch'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'searchedUserId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'deleteUserSearch'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'searchedUserId'),
                  value: VariableNode(name: NameNode(value: 'searchedUserId')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class DeleteUserSearchMutation
    extends GraphQLQuery<DeleteUserSearch$Mutation, DeleteUserSearchArguments> {
  DeleteUserSearchMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_USER_SEARCH_MUTATION_DOCUMENT;

  @override
  final String operationName = 'DeleteUserSearch';

  @override
  final DeleteUserSearchArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteUserSearch$Mutation parse(Map<String, dynamic> json) =>
      DeleteUserSearch$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeletePostArguments extends JsonSerializable with EquatableMixin {
  DeletePostArguments({required this.postId});

  @override
  factory DeletePostArguments.fromJson(Map<String, dynamic> json) =>
      _$DeletePostArgumentsFromJson(json);

  late int postId;

  @override
  List<Object?> get props => [postId];
  @override
  Map<String, dynamic> toJson() => _$DeletePostArgumentsToJson(this);
}

final DELETE_POST_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeletePost'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'postId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'deletePost'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'postId'),
                  value: VariableNode(name: NameNode(value: 'postId')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class DeletePostMutation
    extends GraphQLQuery<DeletePost$Mutation, DeletePostArguments> {
  DeletePostMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_POST_MUTATION_DOCUMENT;

  @override
  final String operationName = 'DeletePost';

  @override
  final DeletePostArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeletePost$Mutation parse(Map<String, dynamic> json) =>
      DeletePost$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ReplyCommentArguments extends JsonSerializable with EquatableMixin {
  ReplyCommentArguments(
      {required this.commentId,
      required this.postId,
      required this.reply,
      required this.userTagsInput});

  @override
  factory ReplyCommentArguments.fromJson(Map<String, dynamic> json) =>
      _$ReplyCommentArgumentsFromJson(json);

  late int commentId;

  late int postId;

  late String reply;

  late List<UserTagInput> userTagsInput;

  @override
  List<Object?> get props => [commentId, postId, reply, userTagsInput];
  @override
  Map<String, dynamic> toJson() => _$ReplyCommentArgumentsToJson(this);
}

final REPLY_COMMENT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'replyComment'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'commentId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'postId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'reply')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userTagsInput')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'UserTagInput'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'replyComment'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'commentId'),
                  value: VariableNode(name: NameNode(value: 'commentId'))),
              ArgumentNode(
                  name: NameNode(value: 'postId'),
                  value: VariableNode(name: NameNode(value: 'postId'))),
              ArgumentNode(
                  name: NameNode(value: 'reply'),
                  value: VariableNode(name: NameNode(value: 'reply'))),
              ArgumentNode(
                  name: NameNode(value: 'userTagsInput'),
                  value: VariableNode(name: NameNode(value: 'userTagsInput')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'reply'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ReplyFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'commentId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'postId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ReplyFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Reply'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'reply'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'comment_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'post_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'reply_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class ReplyCommentMutation
    extends GraphQLQuery<ReplyComment$Mutation, ReplyCommentArguments> {
  ReplyCommentMutation({required this.variables});

  @override
  final DocumentNode document = REPLY_COMMENT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'replyComment';

  @override
  final ReplyCommentArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ReplyComment$Mutation parse(Map<String, dynamic> json) =>
      ReplyComment$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreatePostArguments extends JsonSerializable with EquatableMixin {
  CreatePostArguments(
      {required this.caption,
      required this.file,
      required this.fileDims,
      required this.fileGif,
      required this.fileImg,
      required this.userTagsInput,
      this.videogameId,
      required this.videogameGenreIds});

  @override
  factory CreatePostArguments.fromJson(Map<String, dynamic> json) =>
      _$CreatePostArgumentsFromJson(json);

  late String caption;

  @JsonKey(
      fromJson: fromGraphQLUploadToDartCustomMultipartFile,
      toJson: fromDartCustomMultipartFileToGraphQLUpload)
  late CustomMultipartFile file;

  late FileDimsInput fileDims;

  @JsonKey(
      fromJson: fromGraphQLUploadToDartCustomMultipartFile,
      toJson: fromDartCustomMultipartFileToGraphQLUpload)
  late CustomMultipartFile fileGif;

  @JsonKey(
      fromJson: fromGraphQLUploadToDartCustomMultipartFile,
      toJson: fromDartCustomMultipartFileToGraphQLUpload)
  late CustomMultipartFile fileImg;

  late List<UserTagInput> userTagsInput;

  final int? videogameId;

  late List<int> videogameGenreIds;

  @override
  List<Object?> get props => [
        caption,
        file,
        fileDims,
        fileGif,
        fileImg,
        userTagsInput,
        videogameId,
        videogameGenreIds
      ];
  @override
  Map<String, dynamic> toJson() => _$CreatePostArgumentsToJson(this);
}

final CREATE_POST_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CreatePost'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'caption')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'file')),
            type:
                NamedTypeNode(name: NameNode(value: 'Upload'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'fileDims')),
            type: NamedTypeNode(
                name: NameNode(value: 'FileDimsInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'fileGif')),
            type:
                NamedTypeNode(name: NameNode(value: 'Upload'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'fileImg')),
            type:
                NamedTypeNode(name: NameNode(value: 'Upload'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userTagsInput')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'UserTagInput'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'videogameId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'videogameGenreIds')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createPost'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'file'),
                  value: VariableNode(name: NameNode(value: 'file'))),
              ArgumentNode(
                  name: NameNode(value: 'caption'),
                  value: VariableNode(name: NameNode(value: 'caption'))),
              ArgumentNode(
                  name: NameNode(value: 'fileDims'),
                  value: VariableNode(name: NameNode(value: 'fileDims'))),
              ArgumentNode(
                  name: NameNode(value: 'fileGif'),
                  value: VariableNode(name: NameNode(value: 'fileGif'))),
              ArgumentNode(
                  name: NameNode(value: 'fileImg'),
                  value: VariableNode(name: NameNode(value: 'fileImg'))),
              ArgumentNode(
                  name: NameNode(value: 'userTagsInput'),
                  value: VariableNode(name: NameNode(value: 'userTagsInput'))),
              ArgumentNode(
                  name: NameNode(value: 'videogameId'),
                  value: VariableNode(name: NameNode(value: 'videogameId'))),
              ArgumentNode(
                  name: NameNode(value: 'videogameGenreIds'),
                  value:
                      VariableNode(name: NameNode(value: 'videogameGenreIds')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'post'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'PostFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'PostFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Post'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'post_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'caption'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'commentCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'viewsCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileWidth'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileHeight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreatePostMutation
    extends GraphQLQuery<CreatePost$Mutation, CreatePostArguments> {
  CreatePostMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_POST_MUTATION_DOCUMENT;

  @override
  final String operationName = 'CreatePost';

  @override
  final CreatePostArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreatePost$Mutation parse(Map<String, dynamic> json) =>
      CreatePost$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SignOutArguments extends JsonSerializable with EquatableMixin {
  SignOutArguments({required this.token});

  @override
  factory SignOutArguments.fromJson(Map<String, dynamic> json) =>
      _$SignOutArgumentsFromJson(json);

  late String token;

  @override
  List<Object?> get props => [token];
  @override
  Map<String, dynamic> toJson() => _$SignOutArgumentsToJson(this);
}

final SIGN_OUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SignOut'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'token')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'signOut'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'token'),
                  value: VariableNode(name: NameNode(value: 'token')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class SignOutMutation extends GraphQLQuery<SignOut$Mutation, SignOutArguments> {
  SignOutMutation({required this.variables});

  @override
  final DocumentNode document = SIGN_OUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'SignOut';

  @override
  final SignOutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SignOut$Mutation parse(Map<String, dynamic> json) =>
      SignOut$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class AddUserInterestsArguments extends JsonSerializable with EquatableMixin {
  AddUserInterestsArguments({required this.videogameGenresIds});

  @override
  factory AddUserInterestsArguments.fromJson(Map<String, dynamic> json) =>
      _$AddUserInterestsArgumentsFromJson(json);

  late List<int> videogameGenresIds;

  @override
  List<Object?> get props => [videogameGenresIds];
  @override
  Map<String, dynamic> toJson() => _$AddUserInterestsArgumentsToJson(this);
}

final ADD_USER_INTERESTS_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddUserInterests'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'videogameGenresIds')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'addUserInterests'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'videogameGenresIds'),
                  value:
                      VariableNode(name: NameNode(value: 'videogameGenresIds')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class AddUserInterestsMutation
    extends GraphQLQuery<AddUserInterests$Mutation, AddUserInterestsArguments> {
  AddUserInterestsMutation({required this.variables});

  @override
  final DocumentNode document = ADD_USER_INTERESTS_MUTATION_DOCUMENT;

  @override
  final String operationName = 'AddUserInterests';

  @override
  final AddUserInterestsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  AddUserInterests$Mutation parse(Map<String, dynamic> json) =>
      AddUserInterests$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class FollowUnfollowUserArguments extends JsonSerializable with EquatableMixin {
  FollowUnfollowUserArguments(
      {required this.followUserId, required this.clientId});

  @override
  factory FollowUnfollowUserArguments.fromJson(Map<String, dynamic> json) =>
      _$FollowUnfollowUserArgumentsFromJson(json);

  late int followUserId;

  late String clientId;

  @override
  List<Object?> get props => [followUserId, clientId];
  @override
  Map<String, dynamic> toJson() => _$FollowUnfollowUserArgumentsToJson(this);
}

final FOLLOW_UNFOLLOW_USER_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'FollowUnfollowUser'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'followUserId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'clientId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'followUnfollowUser'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'followUserId'),
                  value: VariableNode(name: NameNode(value: 'followUserId'))),
              ArgumentNode(
                  name: NameNode(value: 'clientId'),
                  value: VariableNode(name: NameNode(value: 'clientId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'value'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'clientId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class FollowUnfollowUserMutation extends GraphQLQuery<
    FollowUnfollowUser$Mutation, FollowUnfollowUserArguments> {
  FollowUnfollowUserMutation({required this.variables});

  @override
  final DocumentNode document = FOLLOW_UNFOLLOW_USER_MUTATION_DOCUMENT;

  @override
  final String operationName = 'FollowUnfollowUser';

  @override
  final FollowUnfollowUserArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  FollowUnfollowUser$Mutation parse(Map<String, dynamic> json) =>
      FollowUnfollowUser$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SendResetPasswordEmailArguments extends JsonSerializable
    with EquatableMixin {
  SendResetPasswordEmailArguments({required this.email});

  @override
  factory SendResetPasswordEmailArguments.fromJson(Map<String, dynamic> json) =>
      _$SendResetPasswordEmailArgumentsFromJson(json);

  late String email;

  @override
  List<Object?> get props => [email];
  @override
  Map<String, dynamic> toJson() =>
      _$SendResetPasswordEmailArgumentsToJson(this);
}

final SEND_RESET_PASSWORD_EMAIL_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SendResetPasswordEmail'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'email')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'sendResetPasswordEmail'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'email'),
                  value: VariableNode(name: NameNode(value: 'email')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class SendResetPasswordEmailMutation extends GraphQLQuery<
    SendResetPasswordEmail$Mutation, SendResetPasswordEmailArguments> {
  SendResetPasswordEmailMutation({required this.variables});

  @override
  final DocumentNode document = SEND_RESET_PASSWORD_EMAIL_MUTATION_DOCUMENT;

  @override
  final String operationName = 'SendResetPasswordEmail';

  @override
  final SendResetPasswordEmailArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SendResetPasswordEmail$Mutation parse(Map<String, dynamic> json) =>
      SendResetPasswordEmail$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CommentsArguments extends JsonSerializable with EquatableMixin {
  CommentsArguments(
      {required this.postId, required this.limit, required this.idsList});

  @override
  factory CommentsArguments.fromJson(Map<String, dynamic> json) =>
      _$CommentsArgumentsFromJson(json);

  late int postId;

  late int limit;

  late List<int> idsList;

  @override
  List<Object?> get props => [postId, limit, idsList];
  @override
  Map<String, dynamic> toJson() => _$CommentsArgumentsToJson(this);
}

final COMMENTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Comments'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'postId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'comments'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'postId'),
                  value: VariableNode(name: NameNode(value: 'postId'))),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'comments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'CommentFragment'),
                        directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'postId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'CommentFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Comment'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'comment'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'post_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'replyCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'comment_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class CommentsQuery extends GraphQLQuery<Comments$Query, CommentsArguments> {
  CommentsQuery({required this.variables});

  @override
  final DocumentNode document = COMMENTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'Comments';

  @override
  final CommentsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Comments$Query parse(Map<String, dynamic> json) =>
      Comments$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserArguments extends JsonSerializable with EquatableMixin {
  UserArguments({required this.userId});

  @override
  factory UserArguments.fromJson(Map<String, dynamic> json) =>
      _$UserArgumentsFromJson(json);

  late int userId;

  @override
  List<Object?> get props => [userId];
  @override
  Map<String, dynamic> toJson() => _$UserArgumentsToJson(this);
}

final USER_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'User'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'userId'),
                  value: VariableNode(name: NameNode(value: 'userId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'email'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'bio'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'followState'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'followingCount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'followersCount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'postCount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class UserQuery extends GraphQLQuery<User$Query, UserArguments> {
  UserQuery({required this.variables});

  @override
  final DocumentNode document = USER_QUERY_DOCUMENT;

  @override
  final String operationName = 'User';

  @override
  final UserArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  User$Query parse(Map<String, dynamic> json) => User$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SinglePostArguments extends JsonSerializable with EquatableMixin {
  SinglePostArguments({required this.id});

  @override
  factory SinglePostArguments.fromJson(Map<String, dynamic> json) =>
      _$SinglePostArgumentsFromJson(json);

  late int id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$SinglePostArgumentsToJson(this);
}

final SINGLE_POST_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SinglePost'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'singlePost'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'PostFragment'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'PostFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Post'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'post_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'caption'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'commentCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'viewsCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileWidth'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileHeight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class SinglePostQuery
    extends GraphQLQuery<SinglePost$Query, SinglePostArguments> {
  SinglePostQuery({required this.variables});

  @override
  final DocumentNode document = SINGLE_POST_QUERY_DOCUMENT;

  @override
  final String operationName = 'SinglePost';

  @override
  final SinglePostArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SinglePost$Query parse(Map<String, dynamic> json) =>
      SinglePost$Query.fromJson(json);
}

final ALL_VIDEOGAMES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllVideogames'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'allVideogames'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'VideogameFragment'), directives: []),
              FieldNode(
                  name: NameNode(value: 'videogameGenre'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'videogameGenre'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'videogame_genre'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'VideogameFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Videogame'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'postCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'tapCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class AllVideogamesQuery
    extends GraphQLQuery<AllVideogames$Query, JsonSerializable> {
  AllVideogamesQuery();

  @override
  final DocumentNode document = ALL_VIDEOGAMES_QUERY_DOCUMENT;

  @override
  final String operationName = 'AllVideogames';

  @override
  List<Object?> get props => [document, operationName];
  @override
  AllVideogames$Query parse(Map<String, dynamic> json) =>
      AllVideogames$Query.fromJson(json);
}

final ALL_TAPS_VIDEOGAMES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllTapsVideogames'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'allTapsVideogames'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'VideogameFragment'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'VideogameFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Videogame'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'postCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'tapCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class AllTapsVideogamesQuery
    extends GraphQLQuery<AllTapsVideogames$Query, JsonSerializable> {
  AllTapsVideogamesQuery();

  @override
  final DocumentNode document = ALL_TAPS_VIDEOGAMES_QUERY_DOCUMENT;

  @override
  final String operationName = 'AllTapsVideogames';

  @override
  List<Object?> get props => [document, operationName];
  @override
  AllTapsVideogames$Query parse(Map<String, dynamic> json) =>
      AllTapsVideogames$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class NotificationsArguments extends JsonSerializable with EquatableMixin {
  NotificationsArguments({required this.limit, required this.idsList});

  @override
  factory NotificationsArguments.fromJson(Map<String, dynamic> json) =>
      _$NotificationsArgumentsFromJson(json);

  late int limit;

  late List<String> idsList;

  @override
  List<Object?> get props => [limit, idsList];
  @override
  Map<String, dynamic> toJson() => _$NotificationsArgumentsToJson(this);
}

final NOTIFICATIONS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Notifications'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'String'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'notifications'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'notifications'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'type'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'parent_id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'concatenated_id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'updatedAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'createdAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'likeNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'post'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'likeCount'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'fileImg'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'file'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'likes'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'user'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'id'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name:
                                                    NameNode(value: 'username'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name: NameNode(
                                                    value: 'smallFile'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'file'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null)
                                                    ]))
                                          ]))
                                    ]))
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'likeReplyNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'reply'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'reply'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'comment'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'post'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'id'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name:
                                                    NameNode(value: 'fileImg'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'file'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null)
                                                    ]))
                                          ]))
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'userTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'reply_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_string'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'likeCount'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'likes'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'user'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'id'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name:
                                                    NameNode(value: 'username'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name: NameNode(
                                                    value: 'smallFile'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'file'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null)
                                                    ]))
                                          ]))
                                    ]))
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'likeCommentNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'comment'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'comment'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'userTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'comment_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_string'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'post'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'fileImg'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'file'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null)
                                          ]))
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'likeCount'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'likes'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'user'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'id'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name:
                                                    NameNode(value: 'username'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name: NameNode(
                                                    value: 'smallFile'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'file'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null)
                                                    ]))
                                          ]))
                                    ]))
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'followNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'follower'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'username'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'followState'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'smallFile'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'file'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'error'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ]))
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'commentNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'comment'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'comment'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'post'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'fileImg'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'file'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null)
                                          ]))
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'userTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'comment_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_string'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'user'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'username'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'smallFile'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'file'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null)
                                          ]))
                                    ]))
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'replyNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'reply'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'reply'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'comment'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'post'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'id'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name:
                                                    NameNode(value: 'fileImg'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'file'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null)
                                                    ]))
                                          ]))
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'userTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'reply_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_string'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'user'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'username'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'smallFile'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'file'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null)
                                          ]))
                                    ]))
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'commentTagNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'comment'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'comment'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'post'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'fileImg'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'file'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null)
                                          ]))
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'userTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'comment_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_string'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'user'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'username'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'smallFile'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'file'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null)
                                          ]))
                                    ]))
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'replyTagNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'reply'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'reply'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'comment'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'post'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'id'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name:
                                                    NameNode(value: 'fileImg'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'file'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null)
                                                    ]))
                                          ]))
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'userTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'reply_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_string'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'user'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'username'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'smallFile'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'file'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null)
                                          ]))
                                    ]))
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'captionTagNotification'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'post'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'id'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'fileImg'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'file'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'caption'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'userTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'post_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'user_string'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null)
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'user'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'id'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'username'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'smallFile'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'file'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null)
                                          ]))
                                    ]))
                              ]))
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class NotificationsQuery
    extends GraphQLQuery<Notifications$Query, NotificationsArguments> {
  NotificationsQuery({required this.variables});

  @override
  final DocumentNode document = NOTIFICATIONS_QUERY_DOCUMENT;

  @override
  final String operationName = 'Notifications';

  @override
  final NotificationsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Notifications$Query parse(Map<String, dynamic> json) =>
      Notifications$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserFollowersArguments extends JsonSerializable with EquatableMixin {
  UserFollowersArguments(
      {required this.followUserId,
      required this.limit,
      required this.idsList,
      this.cursor});

  @override
  factory UserFollowersArguments.fromJson(Map<String, dynamic> json) =>
      _$UserFollowersArgumentsFromJson(json);

  late int followUserId;

  late int limit;

  late List<int> idsList;

  final String? cursor;

  @override
  List<Object?> get props => [followUserId, limit, idsList, cursor];
  @override
  Map<String, dynamic> toJson() => _$UserFollowersArgumentsToJson(this);
}

final USER_FOLLOWERS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'UserFollowers'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'followUserId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'cursor')),
            type: NamedTypeNode(
                name: NameNode(value: 'String'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userFollowers'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'followUserId'),
                  value: VariableNode(name: NameNode(value: 'followUserId'))),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList'))),
              ArgumentNode(
                  name: NameNode(value: 'cursor'),
                  value: VariableNode(name: NameNode(value: 'cursor')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'users'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'smallFile'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'file'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'error'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'followState'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'createdAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'userId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class UserFollowersQuery
    extends GraphQLQuery<UserFollowers$Query, UserFollowersArguments> {
  UserFollowersQuery({required this.variables});

  @override
  final DocumentNode document = USER_FOLLOWERS_QUERY_DOCUMENT;

  @override
  final String operationName = 'UserFollowers';

  @override
  final UserFollowersArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UserFollowers$Query parse(Map<String, dynamic> json) =>
      UserFollowers$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class VerifyResetCodeArguments extends JsonSerializable with EquatableMixin {
  VerifyResetCodeArguments({required this.email, required this.code});

  @override
  factory VerifyResetCodeArguments.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeArgumentsFromJson(json);

  late String email;

  late String code;

  @override
  List<Object?> get props => [email, code];
  @override
  Map<String, dynamic> toJson() => _$VerifyResetCodeArgumentsToJson(this);
}

final VERIFY_RESET_CODE_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'VerifyResetCode'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'email')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'code')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'verifyResetCode'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'email'),
                  value: VariableNode(name: NameNode(value: 'email'))),
              ArgumentNode(
                  name: NameNode(value: 'code'),
                  value: VariableNode(name: NameNode(value: 'code')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class VerifyResetCodeQuery
    extends GraphQLQuery<VerifyResetCode$Query, VerifyResetCodeArguments> {
  VerifyResetCodeQuery({required this.variables});

  @override
  final DocumentNode document = VERIFY_RESET_CODE_QUERY_DOCUMENT;

  @override
  final String operationName = 'VerifyResetCode';

  @override
  final VerifyResetCodeArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  VerifyResetCode$Query parse(Map<String, dynamic> json) =>
      VerifyResetCode$Query.fromJson(json);
}

final SEARCHED_USERS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SearchedUsers'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'searchedUsers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'searchedUserId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'searchedUser'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'file'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'error'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'updatedAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class SearchedUsersQuery
    extends GraphQLQuery<SearchedUsers$Query, JsonSerializable> {
  SearchedUsersQuery();

  @override
  final DocumentNode document = SEARCHED_USERS_QUERY_DOCUMENT;

  @override
  final String operationName = 'SearchedUsers';

  @override
  List<Object?> get props => [document, operationName];
  @override
  SearchedUsers$Query parse(Map<String, dynamic> json) =>
      SearchedUsers$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class VideogamePostsArguments extends JsonSerializable with EquatableMixin {
  VideogamePostsArguments(
      {required this.limit, required this.videogameId, required this.idsList});

  @override
  factory VideogamePostsArguments.fromJson(Map<String, dynamic> json) =>
      _$VideogamePostsArgumentsFromJson(json);

  late int limit;

  late int videogameId;

  late List<int> idsList;

  @override
  List<Object?> get props => [limit, videogameId, idsList];
  @override
  Map<String, dynamic> toJson() => _$VideogamePostsArgumentsToJson(this);
}

final VIDEOGAME_POSTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'VideogamePosts'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'videogameId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'videogamePosts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'videogameId'),
                  value: VariableNode(name: NameNode(value: 'videogameId'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'posts'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'PostFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'PostFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Post'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'post_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'caption'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'commentCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'viewsCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileWidth'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileHeight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class VideogamePostsQuery
    extends GraphQLQuery<VideogamePosts$Query, VideogamePostsArguments> {
  VideogamePostsQuery({required this.variables});

  @override
  final DocumentNode document = VIDEOGAME_POSTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'VideogamePosts';

  @override
  final VideogamePostsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  VideogamePosts$Query parse(Map<String, dynamic> json) =>
      VideogamePosts$Query.fromJson(json);
}

final ME_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Me'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'me'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'email'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'bio'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'followState'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'followingCount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'followersCount'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class MeQuery extends GraphQLQuery<Me$Query, JsonSerializable> {
  MeQuery();

  @override
  final DocumentNode document = ME_QUERY_DOCUMENT;

  @override
  final String operationName = 'Me';

  @override
  List<Object?> get props => [document, operationName];
  @override
  Me$Query parse(Map<String, dynamic> json) => Me$Query.fromJson(json);
}

final ALL_VIDEOGAME_GENRES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllVideogameGenres'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'allVideogameGenres'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'videogame_genre'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class AllVideogameGenresQuery
    extends GraphQLQuery<AllVideogameGenres$Query, JsonSerializable> {
  AllVideogameGenresQuery();

  @override
  final DocumentNode document = ALL_VIDEOGAME_GENRES_QUERY_DOCUMENT;

  @override
  final String operationName = 'AllVideogameGenres';

  @override
  List<Object?> get props => [document, operationName];
  @override
  AllVideogameGenres$Query parse(Map<String, dynamic> json) =>
      AllVideogameGenres$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class FollowingPostsArguments extends JsonSerializable with EquatableMixin {
  FollowingPostsArguments({required this.limit, required this.idsList});

  @override
  factory FollowingPostsArguments.fromJson(Map<String, dynamic> json) =>
      _$FollowingPostsArgumentsFromJson(json);

  late int limit;

  late List<int> idsList;

  @override
  List<Object?> get props => [limit, idsList];
  @override
  Map<String, dynamic> toJson() => _$FollowingPostsArgumentsToJson(this);
}

final FOLLOWING_POSTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'FollowingPosts'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'followingPosts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'posts'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'PostFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'PostFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Post'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'post_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'caption'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'commentCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'viewsCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileWidth'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileHeight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class FollowingPostsQuery
    extends GraphQLQuery<FollowingPosts$Query, FollowingPostsArguments> {
  FollowingPostsQuery({required this.variables});

  @override
  final DocumentNode document = FOLLOWING_POSTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'FollowingPosts';

  @override
  final FollowingPostsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  FollowingPosts$Query parse(Map<String, dynamic> json) =>
      FollowingPosts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SearchUsersArguments extends JsonSerializable with EquatableMixin {
  SearchUsersArguments({required this.search});

  @override
  factory SearchUsersArguments.fromJson(Map<String, dynamic> json) =>
      _$SearchUsersArgumentsFromJson(json);

  late String search;

  @override
  List<Object?> get props => [search];
  @override
  Map<String, dynamic> toJson() => _$SearchUsersArgumentsToJson(this);
}

final SEARCH_USERS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SearchUsers'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'search')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'searchUsers'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'search'),
                  value: VariableNode(name: NameNode(value: 'search')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class SearchUsersQuery
    extends GraphQLQuery<SearchUsers$Query, SearchUsersArguments> {
  SearchUsersQuery({required this.variables});

  @override
  final DocumentNode document = SEARCH_USERS_QUERY_DOCUMENT;

  @override
  final String operationName = 'SearchUsers';

  @override
  final SearchUsersArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SearchUsers$Query parse(Map<String, dynamic> json) =>
      SearchUsers$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserFollowingArguments extends JsonSerializable with EquatableMixin {
  UserFollowingArguments(
      {required this.followUserId,
      required this.limit,
      required this.idsList,
      this.cursor});

  @override
  factory UserFollowingArguments.fromJson(Map<String, dynamic> json) =>
      _$UserFollowingArgumentsFromJson(json);

  late int followUserId;

  late int limit;

  late List<int> idsList;

  final String? cursor;

  @override
  List<Object?> get props => [followUserId, limit, idsList, cursor];
  @override
  Map<String, dynamic> toJson() => _$UserFollowingArgumentsToJson(this);
}

final USER_FOLLOWING_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'UserFollowing'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'followUserId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'cursor')),
            type: NamedTypeNode(
                name: NameNode(value: 'String'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userFollowing'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'followUserId'),
                  value: VariableNode(name: NameNode(value: 'followUserId'))),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList'))),
              ArgumentNode(
                  name: NameNode(value: 'cursor'),
                  value: VariableNode(name: NameNode(value: 'cursor')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'users'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'smallFile'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'file'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'error'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'followState'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'createdAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'userId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class UserFollowingQuery
    extends GraphQLQuery<UserFollowing$Query, UserFollowingArguments> {
  UserFollowingQuery({required this.variables});

  @override
  final DocumentNode document = USER_FOLLOWING_QUERY_DOCUMENT;

  @override
  final String operationName = 'UserFollowing';

  @override
  final UserFollowingArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UserFollowing$Query parse(Map<String, dynamic> json) =>
      UserFollowing$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class RepliesArguments extends JsonSerializable with EquatableMixin {
  RepliesArguments(
      {required this.commentId,
      required this.postId,
      required this.limit,
      this.cursor,
      required this.idsList});

  @override
  factory RepliesArguments.fromJson(Map<String, dynamic> json) =>
      _$RepliesArgumentsFromJson(json);

  late int commentId;

  late int postId;

  late int limit;

  final String? cursor;

  late List<int> idsList;

  @override
  List<Object?> get props => [commentId, postId, limit, cursor, idsList];
  @override
  Map<String, dynamic> toJson() => _$RepliesArgumentsToJson(this);
}

final REPLIES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Replies'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'commentId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'postId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'cursor')),
            type: NamedTypeNode(
                name: NameNode(value: 'String'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'commentReplies'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'commentId'),
                  value: VariableNode(name: NameNode(value: 'commentId'))),
              ArgumentNode(
                  name: NameNode(value: 'postId'),
                  value: VariableNode(name: NameNode(value: 'postId'))),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'cursor'),
                  value: VariableNode(name: NameNode(value: 'cursor'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'replies'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ReplyFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'commentId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'postId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ReplyFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Reply'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'reply'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'comment_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'post_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'reply_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class RepliesQuery extends GraphQLQuery<Replies$Query, RepliesArguments> {
  RepliesQuery({required this.variables});

  @override
  final DocumentNode document = REPLIES_QUERY_DOCUMENT;

  @override
  final String operationName = 'Replies';

  @override
  final RepliesArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Replies$Query parse(Map<String, dynamic> json) =>
      Replies$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserPostsArguments extends JsonSerializable with EquatableMixin {
  UserPostsArguments({required this.userId, required this.limit, this.cursor});

  @override
  factory UserPostsArguments.fromJson(Map<String, dynamic> json) =>
      _$UserPostsArgumentsFromJson(json);

  late int userId;

  late int limit;

  final String? cursor;

  @override
  List<Object?> get props => [userId, limit, cursor];
  @override
  Map<String, dynamic> toJson() => _$UserPostsArgumentsToJson(this);
}

final USER_POSTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'UserPosts'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'cursor')),
            type: NamedTypeNode(
                name: NameNode(value: 'String'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userPosts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'userId'),
                  value: VariableNode(name: NameNode(value: 'userId'))),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'cursor'),
                  value: VariableNode(name: NameNode(value: 'cursor')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'posts'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'PostFragment'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'fileGif'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'file'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'error'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'PostFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Post'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'post_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'caption'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'commentCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'viewsCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileWidth'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileHeight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UserPostsQuery extends GraphQLQuery<UserPosts$Query, UserPostsArguments> {
  UserPostsQuery({required this.variables});

  @override
  final DocumentNode document = USER_POSTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'UserPosts';

  @override
  final UserPostsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UserPosts$Query parse(Map<String, dynamic> json) =>
      UserPosts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class PostsArguments extends JsonSerializable with EquatableMixin {
  PostsArguments({required this.limit, required this.idsList});

  @override
  factory PostsArguments.fromJson(Map<String, dynamic> json) =>
      _$PostsArgumentsFromJson(json);

  late int limit;

  late List<int> idsList;

  @override
  List<Object?> get props => [limit, idsList];
  @override
  Map<String, dynamic> toJson() => _$PostsArgumentsToJson(this);
}

final POSTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Posts'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'posts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'posts'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'PostFragment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'PostFragment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Post'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'file'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'file'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'error'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'smallFile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'file'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'error'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'userTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'post_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user_string'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'likeState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'caption'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'commentCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'viewsCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileWidth'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'fileHeight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class PostsQuery extends GraphQLQuery<Posts$Query, PostsArguments> {
  PostsQuery({required this.variables});

  @override
  final DocumentNode document = POSTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'Posts';

  @override
  final PostsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Posts$Query parse(Map<String, dynamic> json) => Posts$Query.fromJson(json);
}
