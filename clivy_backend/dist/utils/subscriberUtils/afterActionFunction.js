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
Object.defineProperty(exports, "__esModule", { value: true });
exports.afterActionFunction = void 0;
const Post_1 = require("../../entities/Post");
const VideogameGenrePost_1 = require("../../entities/VideogameGenrePost");
const VideogameGenreUserPreferences_1 = require("../../entities/VideogameGenreUserPreferences");
const VideogameUserPreferences_1 = require("../../entities/VideogameUserPreferences");
const typeorm_1 = require("typeorm");
const afterActionFunction = (isPost, postId, userId) => __awaiter(void 0, void 0, void 0, function* () {
    const post = yield Post_1.Post.findOne({ where: { id: postId } });
    if (post) {
        yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(void 0, void 0, void 0, function* () {
            if (post.videogame_id) {
                const videogameUserPref = yield VideogameUserPreferences_1.VideogameUserPreferences.findOne({ where: {
                        user_id: userId,
                        videogame_id: post.videogame_id
                    } });
                if (!videogameUserPref) {
                    yield tm.query(`
            insert into videogame_user_preferences ("user_id", "videogame_id", "likeCount", "viewCount")
            values ($1, $2, $3, $4)
          `, [userId, post.videogame_id, 1, 1]);
                }
                else {
                    console.log("sapo");
                    yield tm.query(`
            update videogame_user_preferences
            set ${isPost ? '"viewCount"' : '"likeCount"'} = ${isPost ? '"viewCount"' : '"likeCount"'} + 1
            where "user_id" = $1 and "videogame_id" = $2
          `, [
                        userId,
                        post.videogame_id
                    ]);
                }
            }
            const videogameGenres = yield VideogameGenrePost_1.VideogameGenrePost.find({ where: {
                    post_id: postId,
                } });
            for (let i = 0; i < videogameGenres.length; i++) {
                const videogameGenreUserPref = yield VideogameGenreUserPreferences_1.VideogameGenreUserPreferences.findOne({ where: {
                        user_id: userId,
                        genre_id: videogameGenres[i].videogame_genre_id
                    } });
                if (!videogameGenreUserPref) {
                    yield tm.query(`
            insert into videogame_genre_user_preferences ("user_id", "genre_id", "likeCount", "viewCount")
            values ($1, $2, $3, $4)
          `, [userId, videogameGenres[i].videogame_genre_id, 1, 1]);
                }
                else {
                    yield tm.query(`
            update videogame_genre_user_preferences
            set ${isPost ? '"viewCount"' : '"likeCount"'} = ${isPost ? '"viewCount"' : '"likeCount"'} + 1
            where "user_id" = $1 and "genre_id" = $2
          `, [
                        userId,
                        videogameGenres[i].videogame_genre_id
                    ]);
                }
            }
        }));
    }
});
exports.afterActionFunction = afterActionFunction;
//# sourceMappingURL=afterActionFunction.js.map