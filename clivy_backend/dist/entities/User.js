"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.User = void 0;
const globalInput_1 = require("../utils/global/globalInput");
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Comments_1 = require("./Comments");
const Like_1 = require("./Like");
const Post_1 = require("./Post");
const Reply_1 = require("./Reply");
const UserSearches_1 = require("./UserSearches");
const Follow_1 = require("./Follow");
const CommentLike_1 = require("./CommentLike");
const ReplyLike_1 = require("./ReplyLike");
const CommentUserTags_1 = require("./CommentUserTags");
const ReplyUserTags_1 = require("./ReplyUserTags");
const CaptionUserTags_1 = require("./CaptionUserTags");
const PostView_1 = require("./PostView");
const VideogameUserPreferences_1 = require("./VideogameUserPreferences");
const VideogameGenreUserPreferences_1 = require("./VideogameGenreUserPreferences");
const DeviceToken_1 = require("./DeviceToken");
const Notification_1 = require("./Notification");
const LikeNotification_1 = require("./LikeNotification");
const CommentLikeNotification_1 = require("./CommentLikeNotification");
const ReplyLikeNotification_1 = require("./ReplyLikeNotification");
const FollowNotification_1 = require("./FollowNotification");
const CommentNotification_1 = require("./CommentNotification");
const ReplyNotification_1 = require("./ReplyNotification");
const CommentTagNotification_1 = require("./CommentTagNotification");
const ReplyTagNotification_1 = require("./ReplyTagNotification");
const CaptionTagNotification_1 = require("./CaptionTagNotification");
let User = class User extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], User.prototype, "id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], User.prototype, "name", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)({ unique: true }),
    __metadata("design:type", String)
], User.prototype, "username", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)({ unique: true }),
    __metadata("design:type", String)
], User.prototype, "email", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)({ default: "" }),
    __metadata("design:type", String)
], User.prototype, "bio", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], User.prototype, "file_key", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => globalInput_1.FileResponse),
    __metadata("design:type", globalInput_1.FileResponse)
], User.prototype, "file", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], User.prototype, "small_file_key", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => globalInput_1.FileResponse),
    __metadata("design:type", globalInput_1.FileResponse)
], User.prototype, "smallFile", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], User.prototype, "password", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: "int", default: 0 }),
    __metadata("design:type", Number)
], User.prototype, "postCount", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => Post_1.Post, post => post.user),
    __metadata("design:type", Array)
], User.prototype, "posts", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => Like_1.Like, like => like.user),
    __metadata("design:type", Array)
], User.prototype, "likes", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => CommentLike_1.CommentLike, like => like.user),
    __metadata("design:type", Array)
], User.prototype, "commentLikes", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => ReplyLike_1.ReplyLike, like => like.user),
    __metadata("design:type", Array)
], User.prototype, "replyLikes", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => Comments_1.Comment, comment => comment.user),
    __metadata("design:type", Array)
], User.prototype, "comments", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Reply_1.Reply]),
    (0, typeorm_1.OneToMany)(() => Reply_1.Reply, (reply) => reply.user),
    __metadata("design:type", Array)
], User.prototype, "replies", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [UserSearches_1.UserSearch]),
    (0, typeorm_1.OneToMany)(() => UserSearches_1.UserSearch, (reply) => reply.user),
    __metadata("design:type", Array)
], User.prototype, "searchedUsers", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [UserSearches_1.UserSearch]),
    (0, typeorm_1.OneToMany)(() => UserSearches_1.UserSearch, (reply) => reply.searchedUser),
    __metadata("design:type", Array)
], User.prototype, "searchedBy", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Follow_1.Follow]),
    (0, typeorm_1.OneToMany)(() => Follow_1.Follow, (follow) => follow.follower),
    __metadata("design:type", Array)
], User.prototype, "followers", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], User.prototype, "followersCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Follow_1.Follow]),
    (0, typeorm_1.OneToMany)(() => Follow_1.Follow, (follow) => follow.following),
    __metadata("design:type", Array)
], User.prototype, "following", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], User.prototype, "followingCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean, { nullable: true }),
    __metadata("design:type", Boolean)
], User.prototype, "followState", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentUserTags_1.CommentUserTag]),
    (0, typeorm_1.OneToMany)(() => CommentUserTags_1.CommentUserTag, (userTags) => userTags.user),
    __metadata("design:type", Array)
], User.prototype, "commentUserTags", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyUserTags_1.ReplyUserTag]),
    (0, typeorm_1.OneToMany)(() => ReplyUserTags_1.ReplyUserTag, (userTags) => userTags.user),
    __metadata("design:type", Array)
], User.prototype, "replyUserTags", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CaptionUserTags_1.CaptionUserTag]),
    (0, typeorm_1.OneToMany)(() => CaptionUserTags_1.CaptionUserTag, (userTags) => userTags.user),
    __metadata("design:type", Array)
], User.prototype, "captionUserTags", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [PostView_1.PostView]),
    (0, typeorm_1.OneToMany)(() => PostView_1.PostView, (postViews) => postViews.user),
    __metadata("design:type", Array)
], User.prototype, "postViews", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [VideogameUserPreferences_1.VideogameUserPreferences]),
    (0, typeorm_1.OneToMany)(() => VideogameUserPreferences_1.VideogameUserPreferences, (vup) => vup.user),
    __metadata("design:type", Array)
], User.prototype, "videogameUserPreference", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [VideogameGenreUserPreferences_1.VideogameGenreUserPreferences]),
    (0, typeorm_1.OneToMany)(() => VideogameGenreUserPreferences_1.VideogameGenreUserPreferences, (vgup) => vgup.user),
    __metadata("design:type", Array)
], User.prototype, "videogameGenreUserPreference", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [DeviceToken_1.DeviceToken]),
    (0, typeorm_1.OneToMany)(() => DeviceToken_1.DeviceToken, (deviceToken) => deviceToken.user),
    __metadata("design:type", Array)
], User.prototype, "deviceToken", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Notification_1.Notification]),
    (0, typeorm_1.OneToMany)(() => Notification_1.Notification, (notification) => notification.user),
    __metadata("design:type", Array)
], User.prototype, "notification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [LikeNotification_1.LikeNotification]),
    (0, typeorm_1.OneToMany)(() => LikeNotification_1.LikeNotification, (likeNotification) => likeNotification.user),
    __metadata("design:type", Array)
], User.prototype, "likeNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentLikeNotification_1.CommentLikeNotification]),
    (0, typeorm_1.OneToMany)(() => CommentLikeNotification_1.CommentLikeNotification, (likeNotification) => likeNotification.user),
    __metadata("design:type", Array)
], User.prototype, "commentLikeNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyLikeNotification_1.ReplyLikeNotification]),
    (0, typeorm_1.OneToMany)(() => ReplyLikeNotification_1.ReplyLikeNotification, (likeNotification) => likeNotification.user),
    __metadata("design:type", Array)
], User.prototype, "replyLikeNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [FollowNotification_1.FollowNotification]),
    (0, typeorm_1.OneToMany)(() => FollowNotification_1.FollowNotification, (followNotification) => followNotification.follower),
    __metadata("design:type", Array)
], User.prototype, "followerNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [FollowNotification_1.FollowNotification]),
    (0, typeorm_1.OneToMany)(() => FollowNotification_1.FollowNotification, (followNotification) => followNotification.user),
    __metadata("design:type", Array)
], User.prototype, "followNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentNotification_1.CommentNotification]),
    (0, typeorm_1.OneToMany)(() => CommentNotification_1.CommentNotification, (commentNotification) => commentNotification.user),
    __metadata("design:type", Array)
], User.prototype, "commentNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyNotification_1.ReplyNotification]),
    (0, typeorm_1.OneToMany)(() => ReplyNotification_1.ReplyNotification, (replyNotification) => replyNotification.user),
    __metadata("design:type", Array)
], User.prototype, "replyNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentTagNotification_1.CommentTagNotification]),
    (0, typeorm_1.OneToMany)(() => CommentTagNotification_1.CommentTagNotification, (commentTagNotification) => commentTagNotification.user),
    __metadata("design:type", Array)
], User.prototype, "commentTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyTagNotification_1.ReplyTagNotification]),
    (0, typeorm_1.OneToMany)(() => ReplyTagNotification_1.ReplyTagNotification, (replyTagNotification) => replyTagNotification.user),
    __metadata("design:type", Array)
], User.prototype, "replyTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CaptionTagNotification_1.CaptionTagNotification]),
    (0, typeorm_1.OneToMany)(() => CaptionTagNotification_1.CaptionTagNotification, (captionTagNotification) => captionTagNotification.user),
    __metadata("design:type", Array)
], User.prototype, "captionTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.Column)({ type: 'date' }),
    __metadata("design:type", Date)
], User.prototype, "birthday", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], User.prototype, "createdAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], User.prototype, "updatedAt", void 0);
User = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], User);
exports.User = User;
//# sourceMappingURL=User.js.map