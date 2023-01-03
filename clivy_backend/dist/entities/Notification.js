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
exports.Notification = exports.NotificationType = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const CaptionTagNotification_1 = require("./CaptionTagNotification");
const CommentLikeNotification_1 = require("./CommentLikeNotification");
const CommentNotification_1 = require("./CommentNotification");
const CommentTagNotification_1 = require("./CommentTagNotification");
const FollowNotification_1 = require("./FollowNotification");
const LikeNotification_1 = require("./LikeNotification");
const ReplyLikeNotification_1 = require("./ReplyLikeNotification");
const ReplyNotification_1 = require("./ReplyNotification");
const ReplyTagNotification_1 = require("./ReplyTagNotification");
const User_1 = require("./User");
var NotificationType;
(function (NotificationType) {
    NotificationType["like"] = "like";
    NotificationType["commentLike"] = "comment_like";
    NotificationType["replyLike"] = "reply_like";
    NotificationType["follow"] = "follow";
    NotificationType["comment"] = "comment";
    NotificationType["reply"] = "reply";
    NotificationType["commentTag"] = "comment_tag";
    NotificationType["replyTag"] = "reply_tag";
    NotificationType["capTag"] = "caption_tag";
})(NotificationType = exports.NotificationType || (exports.NotificationType = {}));
let Notification = class Notification extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], Notification.prototype, "parent_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], Notification.prototype, "user_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", String)
], Notification.prototype, "type", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    __metadata("design:type", String)
], Notification.prototype, "concatenated_id", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => User_1.User, user => user.notification, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], Notification.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => LikeNotification_1.LikeNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => LikeNotification_1.LikeNotification, (likeNofication) => likeNofication.notification),
    __metadata("design:type", LikeNotification_1.LikeNotification)
], Notification.prototype, "likeNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => CommentLikeNotification_1.CommentLikeNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => CommentLikeNotification_1.CommentLikeNotification, (likeNofication) => likeNofication.notification),
    __metadata("design:type", CommentLikeNotification_1.CommentLikeNotification)
], Notification.prototype, "likeCommentNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => ReplyLikeNotification_1.ReplyLikeNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => ReplyLikeNotification_1.ReplyLikeNotification, (likeNofication) => likeNofication.notification),
    __metadata("design:type", ReplyLikeNotification_1.ReplyLikeNotification)
], Notification.prototype, "likeReplyNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => FollowNotification_1.FollowNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => FollowNotification_1.FollowNotification, (followNofication) => followNofication.notification),
    __metadata("design:type", FollowNotification_1.FollowNotification)
], Notification.prototype, "followNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => CommentNotification_1.CommentNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => CommentNotification_1.CommentNotification, (followNofication) => followNofication.notification, { nullable: true }),
    __metadata("design:type", CommentNotification_1.CommentNotification)
], Notification.prototype, "commentNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => ReplyNotification_1.ReplyNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => ReplyNotification_1.ReplyNotification, (replyNofication) => replyNofication.notification),
    __metadata("design:type", ReplyNotification_1.ReplyNotification)
], Notification.prototype, "replyNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => CommentTagNotification_1.CommentTagNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => CommentTagNotification_1.CommentTagNotification, (commentTagNofication) => commentTagNofication.notification),
    __metadata("design:type", CommentTagNotification_1.CommentTagNotification)
], Notification.prototype, "commentTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => ReplyTagNotification_1.ReplyTagNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => ReplyTagNotification_1.ReplyTagNotification, (replyTagNofication) => replyTagNofication.notification),
    __metadata("design:type", ReplyTagNotification_1.ReplyTagNotification)
], Notification.prototype, "replyTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => CaptionTagNotification_1.CaptionTagNotification, { nullable: true }),
    (0, typeorm_1.OneToOne)(() => CaptionTagNotification_1.CaptionTagNotification, (captionTagNofication) => captionTagNofication.notification),
    __metadata("design:type", CaptionTagNotification_1.CaptionTagNotification)
], Notification.prototype, "captionTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Notification.prototype, "updatedAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Notification.prototype, "createdAt", void 0);
Notification = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], Notification);
exports.Notification = Notification;
//# sourceMappingURL=Notification.js.map