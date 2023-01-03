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
exports.LikeNotification = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Post_1 = require("./Post");
const Notification_1 = require("./Notification");
const User_1 = require("./User");
let LikeNotification = class LikeNotification extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], LikeNotification.prototype, "post_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], LikeNotification.prototype, "user_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", String)
], LikeNotification.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.OneToOne)(() => Notification_1.Notification, notification => notification.likeNotification, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)([
        { name: "post_id", referencedColumnName: "parent_id" },
        { name: "user_id", referencedColumnName: "user_id" },
        { name: "type", referencedColumnName: "type" }
    ]),
    __metadata("design:type", Notification_1.Notification)
], LikeNotification.prototype, "notification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Post_1.Post),
    (0, typeorm_1.ManyToOne)(() => Post_1.Post, post => post.likeNotifications, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "post_id" }),
    __metadata("design:type", Post_1.Post)
], LikeNotification.prototype, "post", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => User_1.User, user => user.commentLikeNotification, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], LikeNotification.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], LikeNotification.prototype, "updatedAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], LikeNotification.prototype, "createdAt", void 0);
LikeNotification = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], LikeNotification);
exports.LikeNotification = LikeNotification;
//# sourceMappingURL=LikeNotification.js.map