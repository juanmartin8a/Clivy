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
exports.CommentLike = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Comments_1 = require("./Comments");
const User_1 = require("./User");
let CommentLike = class CommentLike extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], CommentLike.prototype, "user_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], CommentLike.prototype, "comment_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => User_1.User),
    (0, typeorm_1.ManyToOne)(() => User_1.User, user => user.commentLikes, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], CommentLike.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Comments_1.Comment),
    (0, typeorm_1.ManyToOne)(() => Comments_1.Comment, comment => comment.likes, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "comment_id" }),
    __metadata("design:type", Comments_1.Comment)
], CommentLike.prototype, "comment", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], CommentLike.prototype, "createdAt", void 0);
CommentLike = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], CommentLike);
exports.CommentLike = CommentLike;
//# sourceMappingURL=CommentLike.js.map