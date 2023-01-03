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
exports.CommentLikeNotification = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Notification_1 = require("./Notification");
const Comments_1 = require("./Comments");
const User_1 = require("./User");
let CommentLikeNotification = class CommentLikeNotification extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], CommentLikeNotification.prototype, "comment_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], CommentLikeNotification.prototype, "user_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", String)
], CommentLikeNotification.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.OneToOne)(() => Notification_1.Notification, notification => notification.likeNotification, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)([
        { name: "comment_id", referencedColumnName: "parent_id" },
        { name: "user_id", referencedColumnName: "user_id" },
        { name: "type", referencedColumnName: "type" }
    ]),
    __metadata("design:type", Notification_1.Notification)
], CommentLikeNotification.prototype, "notification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Comments_1.Comment),
    (0, typeorm_1.ManyToOne)(() => Comments_1.Comment, comment => comment.likeNotifications, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "comment_id" }),
    __metadata("design:type", Comments_1.Comment)
], CommentLikeNotification.prototype, "comment", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => User_1.User, user => user.commentLikeNotification, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], CommentLikeNotification.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], CommentLikeNotification.prototype, "updatedAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], CommentLikeNotification.prototype, "createdAt", void 0);
CommentLikeNotification = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], CommentLikeNotification);
exports.CommentLikeNotification = CommentLikeNotification;
//# sourceMappingURL=CommentLikeNotification.js.map