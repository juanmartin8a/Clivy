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
exports.VideogameGenreUserPreferences = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const User_1 = require("./User");
const VideogameGenre_1 = require("./VideogameGenre");
let VideogameGenreUserPreferences = class VideogameGenreUserPreferences extends typeorm_1.BaseEntity {
};
__decorate([
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], VideogameGenreUserPreferences.prototype, "user_id", void 0);
__decorate([
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], VideogameGenreUserPreferences.prototype, "genre_id", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], VideogameGenreUserPreferences.prototype, "likeCount", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], VideogameGenreUserPreferences.prototype, "viewCount", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => User_1.User, user => user.videogameGenreUserPreference, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "user_id" }),
    __metadata("design:type", User_1.User)
], VideogameGenreUserPreferences.prototype, "user", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => VideogameGenre_1.VideogameGenre, genre => genre.videogameGenreUserPreference, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete'
    }),
    (0, typeorm_1.JoinColumn)({ name: "genre_id" }),
    __metadata("design:type", VideogameGenre_1.VideogameGenre)
], VideogameGenreUserPreferences.prototype, "genre", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], VideogameGenreUserPreferences.prototype, "createdAt", void 0);
VideogameGenreUserPreferences = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], VideogameGenreUserPreferences);
exports.VideogameGenreUserPreferences = VideogameGenreUserPreferences;
//# sourceMappingURL=VideogameGenreUserPreferences.js.map