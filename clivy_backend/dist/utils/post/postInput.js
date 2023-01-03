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
exports.FileDimsInput = exports.PaginatedPosts = exports.LikeResponse = exports.CreatePostResponse = exports.CreatePostInput = void 0;
const Post_1 = require("../../entities/Post");
const type_graphql_1 = require("type-graphql");
const graphql_upload_1 = require("graphql-upload");
const globalInput_1 = require("../global/globalInput");
let CreatePostInput = class CreatePostInput {
};
__decorate([
    (0, type_graphql_1.Field)(() => String),
    __metadata("design:type", String)
], CreatePostInput.prototype, "caption", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => graphql_upload_1.GraphQLUpload),
    __metadata("design:type", Object)
], CreatePostInput.prototype, "file", void 0);
CreatePostInput = __decorate([
    (0, type_graphql_1.InputType)()
], CreatePostInput);
exports.CreatePostInput = CreatePostInput;
let CreatePostResponse = class CreatePostResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => Post_1.Post, { nullable: true }),
    __metadata("design:type", Post_1.Post)
], CreatePostResponse.prototype, "post", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => globalInput_1.ErrorResponse, { nullable: true }),
    __metadata("design:type", globalInput_1.ErrorResponse)
], CreatePostResponse.prototype, "error", void 0);
CreatePostResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], CreatePostResponse);
exports.CreatePostResponse = CreatePostResponse;
let LikeResponse = class LikeResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int, { nullable: true }),
    __metadata("design:type", Number)
], LikeResponse.prototype, "value", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], LikeResponse.prototype, "clientId", void 0);
LikeResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], LikeResponse);
exports.LikeResponse = LikeResponse;
let PaginatedPosts = class PaginatedPosts {
};
__decorate([
    (0, type_graphql_1.Field)(() => [Post_1.Post]),
    __metadata("design:type", Array)
], PaginatedPosts.prototype, "posts", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean),
    __metadata("design:type", Boolean)
], PaginatedPosts.prototype, "hasMore", void 0);
PaginatedPosts = __decorate([
    (0, type_graphql_1.ObjectType)()
], PaginatedPosts);
exports.PaginatedPosts = PaginatedPosts;
let FileDimsInput = class FileDimsInput {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    __metadata("design:type", Number)
], FileDimsInput.prototype, "fileWidth", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    __metadata("design:type", Number)
], FileDimsInput.prototype, "fileHeight", void 0);
FileDimsInput = __decorate([
    (0, type_graphql_1.InputType)()
], FileDimsInput);
exports.FileDimsInput = FileDimsInput;
//# sourceMappingURL=postInput.js.map