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
exports.CaptionUserTag = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const User_1 = require("./User");
const Post_1 = require("./Post");
let CaptionUserTag = class CaptionUserTag extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], CaptionUserTag.prototype, "post_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], CaptionUserTag.prototype, "user_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], CaptionUserTag.prototype, "user_string", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => User_1.User),
    (0, typeorm_1.ManyToOne)(() => User_1.User, (user) => user.captionUserTags, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete',
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], CaptionUserTag.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Post_1.Post),
    (0, typeorm_1.ManyToOne)(() => Post_1.Post, (post) => post.userTags, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete',
    }),
    (0, typeorm_1.JoinColumn)({ name: "post_id" }),
    __metadata("design:type", Post_1.Post)
], CaptionUserTag.prototype, "post", void 0);
CaptionUserTag = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], CaptionUserTag);
exports.CaptionUserTag = CaptionUserTag;
//# sourceMappingURL=CaptionUserTags.js.map