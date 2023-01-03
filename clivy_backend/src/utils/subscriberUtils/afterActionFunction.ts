import { Post } from "../../entities/Post";
import { VideogameGenrePost } from "../../entities/VideogameGenrePost";
import { VideogameGenreUserPreferences } from "../../entities/VideogameGenreUserPreferences";
import { VideogameUserPreferences } from "../../entities/VideogameUserPreferences";
import { getConnection } from "typeorm";

export const afterActionFunction = async (
  isPost: boolean,
  postId: number,
  userId: number
) => {

  const post = await Post.findOne({where: {id: postId}});

  if (post) {
    await getConnection().transaction(async (tm) => {
      if (post.videogame_id) {
        const videogameUserPref = await VideogameUserPreferences.findOne(
          {where: {
            user_id: userId,
            videogame_id: post.videogame_id
          }}
        );
        if (!videogameUserPref) { 
          await tm.query(`
            insert into videogame_user_preferences ("user_id", "videogame_id", "likeCount", "viewCount")
            values ($1, $2, $3, $4)
          `, [userId, post.videogame_id, 1, 1]);
        } else {
          console.log("sapo");
          await tm.query(`
            update videogame_user_preferences
            set ${isPost ? '"viewCount"' : '"likeCount"'} = ${isPost ? '"viewCount"' : '"likeCount"'} + 1
            where "user_id" = $1 and "videogame_id" = $2
          `, [
            // isPost
            // ? videogameUserPref.viewCount + 1
            // : videogameUserPref.likeCount + 1,
            userId, 
            post.videogame_id
          ]);
        }
      }
      const videogameGenres = await VideogameGenrePost.find(
        {where: {
          post_id: postId,
        }}
      );
      for (let i = 0; i < videogameGenres.length; i++) {
        const videogameGenreUserPref = await VideogameGenreUserPreferences.findOne(
          {where: {
            user_id: userId,
            genre_id: videogameGenres[i].videogame_genre_id
          }}
        );
        if (!videogameGenreUserPref) {
          await tm.query(`
            insert into videogame_genre_user_preferences ("user_id", "genre_id", "likeCount", "viewCount")
            values ($1, $2, $3, $4)
          `, [userId, videogameGenres[i].videogame_genre_id, 1, 1]);
        } else {
          await tm.query(`
            update videogame_genre_user_preferences
            set ${isPost ? '"viewCount"' : '"likeCount"'} = ${isPost ? '"viewCount"' : '"likeCount"'} + 1
            where "user_id" = $1 and "genre_id" = $2
          `, [
            // isPost
            //   ? videogameGenreUserPref.viewCount + 1 
            //   : videogameGenreUserPref.likeCount + 1,
            userId,
            videogameGenres[i].videogame_genre_id
          ]);
        }
      }
    })
  }
}