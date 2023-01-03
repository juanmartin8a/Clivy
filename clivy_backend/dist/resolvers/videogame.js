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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.VideogameResolver = exports.VideogameGenreVideogameResolver = void 0;
const Videogame_1 = require("../entities/Videogame");
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const VideogameGenre_1 = require("../entities/VideogameGenre");
const globalInput_1 = require("../utils/global/globalInput");
const VideogameGenreVideogame_1 = require("../entities/VideogameGenreVideogame");
const isAuth_1 = require("../middleware/isAuth");
let VideogameGenreVideogameResolver = class VideogameGenreVideogameResolver {
    videogameGenre(videogameGenreVideogame, { videogameGenreLoader }) {
        return videogameGenreLoader.load(videogameGenreVideogame.videogame_genre_id);
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => VideogameGenre_1.VideogameGenre),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [VideogameGenreVideogame_1.VideogameGenreVideogame, Object]),
    __metadata("design:returntype", void 0)
], VideogameGenreVideogameResolver.prototype, "videogameGenre", null);
VideogameGenreVideogameResolver = __decorate([
    (0, type_graphql_1.Resolver)(VideogameGenreVideogame_1.VideogameGenreVideogame)
], VideogameGenreVideogameResolver);
exports.VideogameGenreVideogameResolver = VideogameGenreVideogameResolver;
let VideogameResolver = class VideogameResolver {
    videogameGenre(videogame, { videogameGenreVideogamesLoader }) {
        return videogameGenreVideogamesLoader.load(videogame.id);
    }
    file(videogame, { fileLoader }) {
        return fileLoader.load(videogame.file_key);
    }
    allVideogames() {
        const videogames = (0, typeorm_1.getConnection)().query(`
      select * from "videogame" v
      order by v."postCount" desc
    `);
        return videogames;
    }
    allTapsVideogames() {
        const videogames = (0, typeorm_1.getConnection)().query(`
      select * from "videogame" v
      order by v."tapCount" desc
    `);
        return videogames;
    }
    allVideogameGenres() {
        const videogameGenres = (0, typeorm_1.getConnection)().query(`
      select * from "videogame_genre"
    `);
        return videogameGenres;
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => VideogameGenreVideogame_1.VideogameGenreVideogame),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Videogame_1.Videogame, Object]),
    __metadata("design:returntype", void 0)
], VideogameResolver.prototype, "videogameGenre", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => globalInput_1.FileResponse),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Videogame_1.Videogame, Object]),
    __metadata("design:returntype", void 0)
], VideogameResolver.prototype, "file", null);
__decorate([
    (0, type_graphql_1.Query)(() => [Videogame_1.Videogame]),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], VideogameResolver.prototype, "allVideogames", null);
__decorate([
    (0, type_graphql_1.Query)(() => [Videogame_1.Videogame]),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], VideogameResolver.prototype, "allTapsVideogames", null);
__decorate([
    (0, type_graphql_1.Query)(() => [VideogameGenre_1.VideogameGenre]),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], VideogameResolver.prototype, "allVideogameGenres", null);
VideogameResolver = __decorate([
    (0, type_graphql_1.Resolver)(Videogame_1.Videogame)
], VideogameResolver);
exports.VideogameResolver = VideogameResolver;
//# sourceMappingURL=videogame.js.map