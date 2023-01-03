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
exports.Reply = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Comments_1 = require("./Comments");
const ReplyLike_1 = require("./ReplyLike");
const ReplyLikeNotification_1 = require("./ReplyLikeNotification");
const ReplyNotification_1 = require("./ReplyNotification");
const ReplyTagNotification_1 = require("./ReplyTagNotification");
const ReplyUserTags_1 = require("./ReplyUserTags");
const User_1 = require("./User");
let Reply = class Reply extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], Reply.prototype, "id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Reply.prototype, "user_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Reply.prototype, "comment_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Reply.prototype, "post_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Reply.prototype, "reply", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => User_1.User),
    (0, typeorm_1.ManyToOne)(() => User_1.User, (user) => user.replies, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], Reply.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Comments_1.Comment),
    (0, typeorm_1.ManyToOne)(() => Comments_1.Comment, (comment) => comment.replies, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "comment_id" }),
    __metadata("design:type", Comments_1.Comment)
], Reply.prototype, "comment", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyLike_1.ReplyLike]),
    (0, typeorm_1.OneToMany)(() => ReplyLike_1.ReplyLike, like => like.reply),
    __metadata("design:type", Array)
], Reply.prototype, "likes", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean, { nullable: true }),
    __metadata("design:type", Boolean)
], Reply.prototype, "likeState", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], Reply.prototype, "likeCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyUserTags_1.ReplyUserTag]),
    (0, typeorm_1.OneToMany)(() => ReplyUserTags_1.ReplyUserTag, userTags => userTags.reply),
    __metadata("design:type", Array)
], Reply.prototype, "userTags", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyLikeNotification_1.ReplyLikeNotification]),
    (0, typeorm_1.OneToMany)(() => ReplyLikeNotification_1.ReplyLikeNotification, (likeNotification) => likeNotification.reply),
    __metadata("design:type", Array)
], Reply.prototype, "likeNotifications", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyNotification_1.ReplyNotification]),
    (0, typeorm_1.OneToMany)(() => ReplyNotification_1.ReplyNotification, (replyNotification) => replyNotification.reply),
    __metadata("design:type", Array)
], Reply.prototype, "replyNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [ReplyTagNotification_1.ReplyTagNotification]),
    (0, typeorm_1.OneToMany)(() => ReplyTagNotification_1.ReplyTagNotification, (replyTagNotification) => replyTagNotification.reply),
    __metadata("design:type", Array)
], Reply.prototype, "replyTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Reply.prototype, "createdAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Reply.prototype, "updatedAt", void 0);
Reply = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], Reply);
exports.Reply = Reply;
//# sourceMappingURL=Reply.js.map