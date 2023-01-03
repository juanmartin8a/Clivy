import { Videogame } from "../entities/Videogame";
import { Ctx, FieldResolver, Query, Resolver, Root, UseMiddleware } from "type-graphql";
import { getConnection } from "typeorm";
import { VideogameGenre } from "../entities/VideogameGenre";
import { MyContext } from "../myContext";
import { FileResponse } from "../utils/global/globalInput";
import { VideogameGenreVideogame } from "../entities/VideogameGenreVideogame";
import { isAuth } from "../middleware/isAuth";

@Resolver(VideogameGenreVideogame)
export class VideogameGenreVideogameResolver {
  @FieldResolver(() => VideogameGenre)
	videogameGenre(
		@Root() videogameGenreVideogame: VideogameGenreVideogame,
		@Ctx() { videogameGenreLoader }: MyContext
	) {
		return videogameGenreLoader.load(videogameGenreVideogame.videogame_genre_id);
	}
}

@Resolver(Videogame)
export class VideogameResolver {
  @FieldResolver(() => VideogameGenreVideogame)
	videogameGenre(
		@Root() videogame: Videogame,
		@Ctx() { videogameGenreVideogamesLoader }: MyContext
	) {
		return videogameGenreVideogamesLoader.load(videogame.id);
	}

  @FieldResolver(() => FileResponse)
	file(
		@Root() videogame: Videogame,
		@Ctx() { fileLoader }: MyContext
	) {
		return fileLoader.load(videogame.file_key);
	}

  @Query(() => [Videogame])
  @UseMiddleware(isAuth)
  allVideogames(): Promise<Videogame[]> {
    const videogames = getConnection().query(`
      select * from "videogame" v
      order by v."postCount" desc
    `);

    return videogames
  }

  @Query(() => [Videogame])
  @UseMiddleware(isAuth)
  allTapsVideogames(): Promise<Videogame[]> {
    const videogames = getConnection().query(`
      select * from "videogame" v
      order by v."tapCount" desc
    `);

    return videogames
  }

  @Query(() => [VideogameGenre])
  @UseMiddleware(isAuth)
  allVideogameGenres(): Promise<VideogameGenre[]> {
    const videogameGenres = getConnection().query(`
      select * from "videogame_genre"
    `);

    return videogameGenres
  }

}