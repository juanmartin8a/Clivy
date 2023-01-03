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
exports.Videogame = void 0;
const globalInput_1 = require("../utils/global/globalInput");
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const VideogameGenreVideogame_1 = require("./VideogameGenreVideogame");
const Post_1 = require("./Post");
const VideogameUserPreferences_1 = require("./VideogameUserPreferences");
let Videogame = class Videogame extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], Videogame.prototype, "id", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Videogame.prototype, "name", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Videogame.prototype, "file_key", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => globalInput_1.FileResponse),
    __metadata("design:type", globalInput_1.FileResponse)
], Videogame.prototype, "file", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], Videogame.prototype, "tapCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.Column)({ type: 'int', default: 0 }),
    __metadata("design:type", Number)
], Videogame.prototype, "postCount", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [VideogameGenreVideogame_1.VideogameGenreVideogame]),
    (0, typeorm_1.OneToMany)(() => VideogameGenreVideogame_1.VideogameGenreVideogame, (videogameGenreVideogame) => videogameGenreVideogame.videogame),
    __metadata("design:type", Array)
], Videogame.prototype, "videogameGenre", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [Post_1.Post]),
    (0, typeorm_1.OneToMany)(() => Post_1.Post, (post) => post.videogame),
    __metadata("design:type", Array)
], Videogame.prototype, "post", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [VideogameUserPreferences_1.VideogameUserPreferences]),
    (0, typeorm_1.OneToMany)(() => VideogameUserPreferences_1.VideogameUserPreferences, (vup) => vup.videogame),
    __metadata("design:type", Array)
], Videogame.prototype, "videogameUserPreference", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Videogame.prototype, "createdAt", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.UpdateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], Videogame.prototype, "updatedAt", void 0);
Videogame = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], Videogame);
exports.Videogame = Videogame;
//# sourceMappingURL=Videogame.js.map