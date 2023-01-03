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
exports.UserTagInput = exports.ReplyResponse = exports.CommentResponse = exports.CreateReplyResponse = exports.CreateCommentResponse = void 0;
const Comments_1 = require("../../entities/Comments");
const type_graphql_1 = require("type-graphql");
const Reply_1 = require("../../entities/Reply");
let CreateCommentResponse = class CreateCommentResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => Comments_1.Comment, { nullable: true }),
    __metadata("design:type", Comments_1.Comment)
], CreateCommentResponse.prototype, "comment", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int, { nullable: true }),
    __metadata("design:type", Number)
], CreateCommentResponse.prototype, "postId", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean, { nullable: true }),
    __metadata("design:type", Boolean)
], CreateCommentResponse.prototype, "error", void 0);
CreateCommentResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], CreateCommentResponse);
exports.CreateCommentResponse = CreateCommentResponse;
let CreateReplyResponse = class CreateReplyResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => Reply_1.Reply, { nullable: true }),
    __metadata("design:type", Reply_1.Reply)
], CreateReplyResponse.prototype, "reply", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int, { nullable: true }),
    __metadata("design:type", Number)
], CreateReplyResponse.prototype, "commentId", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int, { nullable: true }),
    __metadata("design:type", Number)
], CreateReplyResponse.prototype, "postId", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean, { nullable: true }),
    __metadata("design:type", Boolean)
], CreateReplyResponse.prototype, "error", void 0);
CreateReplyResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], CreateReplyResponse);
exports.CreateReplyResponse = CreateReplyResponse;
let CommentResponse = class CommentResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => [Comments_1.Comment]),
    __metadata("design:type", Array)
], CommentResponse.prototype, "comments", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean),
    __metadata("design:type", Boolean)
], CommentResponse.prototype, "hasMore", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    __metadata("design:type", Number)
], CommentResponse.prototype, "postId", void 0);
CommentResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], CommentResponse);
exports.CommentResponse = CommentResponse;
let ReplyResponse = class ReplyResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => [Reply_1.Reply]),
    __metadata("design:type", Array)
], ReplyResponse.prototype, "replies", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean),
    __metadata("design:type", Boolean)
], ReplyResponse.prototype, "hasMore", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    __metadata("design:type", Number)
], ReplyResponse.prototype, "commentId", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    __metadata("design:type", Number)
], ReplyResponse.prototype, "postId", void 0);
ReplyResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], ReplyResponse);
exports.ReplyResponse = ReplyResponse;
let UserTagInput = class UserTagInput {
};
__decorate([
    (0, type_graphql_1.Field)(() => String),
    __metadata("design:type", String)
], UserTagInput.prototype, "userString", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    __metadata("design:type", Number)
], UserTagInput.prototype, "userId", void 0);
UserTagInput = __decorate([
    (0, type_graphql_1.InputType)()
], UserTagInput);
exports.UserTagInput = UserTagInput;
//# sourceMappingURL=commentInput.js.map