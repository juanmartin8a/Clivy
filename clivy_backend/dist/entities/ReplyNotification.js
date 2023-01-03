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
exports.ReplyNotification = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Notification_1 = require("./Notification");
const Reply_1 = require("./Reply");
const User_1 = require("./User");
let ReplyNotification = class ReplyNotification extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], ReplyNotification.prototype, "reply_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], ReplyNotification.prototype, "user_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", String)
], ReplyNotification.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.OneToOne)(() => Notification_1.Notification, notification => notification.replyNotification, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)([
        { name: "reply_id", referencedColumnName: "parent_id" },
        { name: "user_id", referencedColumnName: "user_id" },
        { name: "type", referencedColumnName: "type" }
    ]),
    __metadata("design:type", Notification_1.Notification)
], ReplyNotification.prototype, "notification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Reply_1.Reply),
    (0, typeorm_1.ManyToOne)(() => Reply_1.Reply, reply => reply.replyNotification, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "reply_id" }),
    __metadata("design:type", Reply_1.Reply)
], ReplyNotification.prototype, "reply", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => User_1.User, user => user.replyNotification, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], ReplyNotification.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], ReplyNotification.prototype, "updatedAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], ReplyNotification.prototype, "createdAt", void 0);
ReplyNotification = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], ReplyNotification);
exports.ReplyNotification = ReplyNotification;
//# sourceMappingURL=ReplyNotification.js.map