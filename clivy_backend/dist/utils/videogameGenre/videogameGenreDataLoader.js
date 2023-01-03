"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.videogameGenreDataLoader = exports.videogameGenreVideogameDataLoader = void 0;
const typeorm_1 = require("typeorm");
const dataloader_1 = __importDefault(require("dataloader"));
const VideogameGenre_1 = require("../../entities/VideogameGenre");
const videogameGenreVideogameDataLoader = () => new dataloader_1.default((videogameIds) => __awaiter(void 0, void 0, void 0, function* () {
    const videogameGenreVideogames = yield (0, typeorm_1.getConnection)().query(`
    SELECT videogame_id, 
      JSON_AGG(ROW_TO_JSON("videogame_genre_videogame")) as row
    FROM "videogame_genre_videogame"
    WHERE videogame_id = ANY($1)
    GROUP BY videogame_id
  `, [videogameIds]);
    const videogameGenreVideogamesMap = {};
    for (let i = 0; i < videogameGenreVideogames.length; i++) {
        const videogameId = videogameGenreVideogames[i].videogame_id;
        videogameGenreVideogamesMap[videogameId] = videogameGenreVideogames[i].row;
    }
    return videogameIds.map(videogameId => videogameGenreVideogamesMap[videogameId]);
}));
exports.videogameGenreVideogameDataLoader = videogameGenreVideogameDataLoader;
const videogameGenreDataLoader = () => new dataloader_1.default((videogameGenreIds) => __awaiter(void 0, void 0, void 0, function* () {
    const videogameGenres = yield VideogameGenre_1.VideogameGenre.findByIds(videogameGenreIds);
    const videogameGenreMap = {};
    videogameGenres.forEach((videogameGenre) => {
        videogameGenreMap[videogameGenre.id] = videogameGenre;
    });
    return videogameGenreIds.map(videogameGenreId => videogameGenreMap[videogameGenreId]);
}));
exports.videogameGenreDataLoader = videogameGenreDataLoader;
//# sourceMappingURL=videogameGenreDataLoader.js.map