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
exports.Post = void 0;
const globalInput_1 = require("../utils/global/globalInput");
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Like_1 = require("./Like");
const User_1 = require("./User");
const Comments_1 = require("./Comments");
const CaptionUserTags_1 = require("./CaptionUserTags");
const VideogameGenrePost_1 = require("./VideogameGenrePost");
const Videogame_1 = require("./Videogame");
const PostView_1 = require("./PostView");
const LikeNotification_1 = require("./LikeNotification");
const CaptionTagNotification_1 = require("./CaptionTagNotification");
let Post = class Post extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], Post.prototype, "id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Post.prototype, "caption", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Post.prototype, "file_key", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => globalInput_1.FileResponse),
    __metadata("design:type", globalInput_1.FileResponse)
], Post.prototype, "file", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Post.prototype, "fileWidth", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Post.prototype, "fileHeight", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Post.prototype, "fileGifKey", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => globalInput_1.FileResponse),
    __metadata("design:type", globalInput_1.FileResponse)
], Post.prototype, "fileGif", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Post.prototype, "fileImgKey", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => globalInput_1.FileResponse),
    __metadata("design:type", globalInput_1.FileResponse)
], Post.prototype, "fileImg", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Post.prototype, "user_id", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => User_1.User, user => user.posts, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], Post.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Like_1.Like]),
    (0, typeorm_1.OneToMany)(() => Like_1.Like, like => like.post),
    __metadata("design:type", Array)
], Post.prototype, "likes", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean, { nullable: true }),
    __metadata("design:type", Boolean)
], Post.prototype, "likeState", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], Post.prototype, "likeCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Comments_1.Comment]),
    (0, typeorm_1.OneToMany)(() => Comments_1.Comment, (comment) => comment.post),
    __metadata("design:type", Array)
], Post.prototype, "comments", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], Post.prototype, "commentCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CaptionUserTags_1.CaptionUserTag]),
    (0, typeorm_1.OneToMany)(() => CaptionUserTags_1.CaptionUserTag, userTags => userTags.post),
    __metadata("design:type", Array)
], Post.prototype, "userTags", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', nullable: true }),
    __metadata("design:type", Number)
], Post.prototype, "videogame_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Videogame_1.Videogame]),
    (0, typeorm_1.ManyToOne)(() => Videogame_1.Videogame, (videogame) => videogame.post),
    (0, typeorm_1.JoinColumn)({ name: "videogame_id" }),
    __metadata("design:type", Videogame_1.Videogame)
], Post.prototype, "videogame", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [VideogameGenrePost_1.VideogameGenrePost]),
    (0, typeorm_1.OneToMany)(() => VideogameGenrePost_1.VideogameGenrePost, (videogameGenrePost) => videogameGenrePost.post),
    __metadata("design:type", Array)
], Post.prototype, "videogameGenre", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], Post.prototype, "viewsCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [PostView_1.PostView]),
    (0, typeorm_1.OneToMany)(() => PostView_1.PostView, (postViews) => postViews.post),
    __metadata("design:type", Array)
], Post.prototype, "postViews", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [LikeNotification_1.LikeNotification]),
    (0, typeorm_1.OneToMany)(() => LikeNotification_1.LikeNotification, (likeNotification) => likeNotification.post),
    __metadata("design:type", Array)
], Post.prototype, "likeNotifications", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [CaptionTagNotification_1.CaptionTagNotification]),
    (0, typeorm_1.OneToMany)(() => CaptionTagNotification_1.CaptionTagNotification, (captionTagNotification) => captionTagNotification.post),
    __metadata("design:type", Array)
], Post.prototype, "captionTagNotification", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Post.prototype, "createdAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Post.prototype, "updatedAt", void 0);
Post = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], Post);
exports.Post = Post;
//# sourceMappingURL=Post.js.map