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
exports.Comment = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const CommentLike_1 = require("./CommentLike");
const CommentLikeNotification_1 = require("./CommentLikeNotification");
const CommentNotification_1 = require("./CommentNotification");
const CommentTagNotification_1 = require("./CommentTagNotification");
const CommentUserTags_1 = require("./CommentUserTags");
const Post_1 = require("./Post");
const Reply_1 = require("./Reply");
const User_1 = require("./User");
let Comment = class Comment extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], Comment.prototype, "id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Comment.prototype, "user_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Comment.prototype, "post_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Comment.prototype, "comment", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => User_1.User),
    (0, typeorm_1.ManyToOne)(() => User_1.User, (user) => user.comments, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], Comment.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Post_1.Post),
    (0, typeorm_1.ManyToOne)(() => Post_1.Post, (post) => post.comments, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "post_id" }),
    __metadata("design:type", Post_1.Post)
], Comment.prototype, "post", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], Comment.prototype, "replyCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Reply_1.Reply]),
    (0, typeorm_1.OneToMany)(() => Reply_1.Reply, (reply) => reply.comment),
    __metadata("design:type", Array)
], Comment.prototype, "replies", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentLike_1.CommentLike]),
    (0, typeorm_1.OneToMany)(() => CommentLike_1.CommentLike, like => like.comment),
    __metadata("design:type", Array)
], Comment.prototype, "likes", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean, { nullable: true }),
    __metadata("design:type", Boolean)
], Comment.prototype, "likeState", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], Comment.prototype, "likeCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentUserTags_1.CommentUserTag]),
    (0, typeorm_1.OneToMany)(() => CommentUserTags_1.CommentUserTag, userTags => userTags.comment),
    __metadata("design:type", Array)
], Comment.prototype, "userTags", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentLikeNotification_1.CommentLikeNotification]),
    (0, typeorm_1.OneToMany)(() => CommentLikeNotification_1.CommentLikeNotification, (likeNotification) => likeNotification.comment),
    __metadata("design:type", Array)
], Comment.prototype, "likeNotifications", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentNotification_1.CommentNotification]),
    (0, typeorm_1.OneToMany)(() => CommentNotification_1.CommentNotification, (commentNotification) => commentNotification.comment),
    __metadata("design:type", Array)
], Comment.prototype, "commentNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CommentTagNotification_1.CommentTagNotification]),
    (0, typeorm_1.OneToMany)(() => CommentTagNotification_1.CommentTagNotification, (commentTagNotification) => commentTagNotification.comment),
    __metadata("design:type", Array)
], Comment.prototype, "commentTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Comment.prototype, "createdAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Comment.prototype, "updatedAt", void 0);
Comment = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], Comment);
exports.Comment = Comment;
//# sourceMappingURL=Comments.js.map