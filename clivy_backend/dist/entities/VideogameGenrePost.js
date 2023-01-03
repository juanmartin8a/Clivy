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
exports.VideogameGenrePost = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Post_1 = require("./Post");
const VideogameGenre_1 = require("./VideogameGenre");
let VideogameGenrePost = class VideogameGenrePost extends typeorm_1.BaseEntity {
};
__decorate([
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], VideogameGenrePost.prototype, "videogame_genre_id", void 0);
__decorate([
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], VideogameGenrePost.prototype, "post_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => VideogameGenre_1.VideogameGenre),
    (0, typeorm_1.ManyToOne)(() => VideogameGenre_1.VideogameGenre, (videogameGenre) => videogameGenre.videogameGenrePost, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete',
    }),
    (0, typeorm_1.JoinColumn)({ name: "videogame_genre_id" }),
    __metadata("design:type", VideogameGenre_1.VideogameGenre)
], VideogameGenrePost.prototype, "videogameGenre", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Post_1.Post),
    (0, typeorm_1.ManyToOne)(() => Post_1.Post, (post) => post.videogameGenre, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete',
    }),
    (0, typeorm_1.JoinColumn)({ name: "post_id" }),
    __metadata("design:type", Post_1.Post)
], VideogameGenrePost.prototype, "post", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], VideogameGenrePost.prototype, "createdAt", void 0);
VideogameGenrePost = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], VideogameGenrePost);
exports.VideogameGenrePost = VideogameGenrePost;
//# sourceMappingURL=VideogameGenrePost.js.map