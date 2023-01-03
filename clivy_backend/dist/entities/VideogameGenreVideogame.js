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
exports.VideogameGenreVideogame = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Videogame_1 = require("./Videogame");
const VideogameGenre_1 = require("./VideogameGenre");
let VideogameGenreVideogame = class VideogameGenreVideogame extends typeorm_1.BaseEntity {
};
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], VideogameGenreVideogame.prototype, "videogame_genre_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], VideogameGenreVideogame.prototype, "videogame_id", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => VideogameGenre_1.VideogameGenre),
    (0, typeorm_1.ManyToOne)(() => VideogameGenre_1.VideogameGenre, (videogameGenre) => videogameGenre.videogameGenreVideogames, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete',
    }),
    (0, typeorm_1.JoinColumn)({ name: "videogame_genre_id" }),
    __metadata("design:type", VideogameGenre_1.VideogameGenre)
], VideogameGenreVideogame.prototype, "videogameGenre", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Videogame_1.Videogame),
    (0, typeorm_1.ManyToOne)(() => Videogame_1.Videogame, (videogame) => videogame.videogameGenre, {
        onDelete: "CASCADE",
        orphanedRowAction: 'delete',
    }),
    (0, typeorm_1.JoinColumn)({ name: "videogame_id" }),
    __metadata("design:type", Videogame_1.Videogame)
], VideogameGenreVideogame.prototype, "videogame", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    (0, typeorm_1.CreateDateColumn)({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" }),
    __metadata("design:type", Date)
], VideogameGenreVideogame.prototype, "createdAt", void 0);
VideogameGenreVideogame = __decorate([
    (0, type_graphql_1.ObjectType)(),
    (0, typeorm_1.Entity)()
], VideogameGenreVideogame);
exports.VideogameGenreVideogame = VideogameGenreVideogame;
//# sourceMappingURL=VideogameGenreVideogame.js.map