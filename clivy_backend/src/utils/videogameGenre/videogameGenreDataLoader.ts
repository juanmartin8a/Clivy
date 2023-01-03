import { VideogameGenreVideogame } from "../../entities/VideogameGenreVideogame";
import { getConnection } from "typeorm";
import DataLoader from "dataloader";
import { VideogameGenre } from "../../entities/VideogameGenre";

export const videogameGenreVideogameDataLoader = () => new DataLoader<number, VideogameGenreVideogame[]>(async (videogameIds) => {
  const videogameGenreVideogames = await getConnection().query(`
    SELECT videogame_id, 
      JSON_AGG(ROW_TO_JSON("videogame_genre_videogame")) as row
    FROM "videogame_genre_videogame"
    WHERE videogame_id = ANY($1)
    GROUP BY videogame_id
  `, [videogameIds as number[]]);

	const videogameGenreVideogamesMap: Record<number, VideogameGenreVideogame[]> = {};

  for (let i = 0; i < videogameGenreVideogames.length; i++) {
    const videogameId: number = videogameGenreVideogames[i].videogame_id;
    videogameGenreVideogamesMap[videogameId] = videogameGenreVideogames[i].row as VideogameGenreVideogame[];
  }
  
	return videogameIds.map(videogameId => videogameGenreVideogamesMap[videogameId]);
});

export const videogameGenreDataLoader = () => new DataLoader<number, VideogameGenre>(async (videogameGenreIds) => {
  const videogameGenres = await VideogameGenre.findByIds(videogameGenreIds as number[])

	const videogameGenreMap: Record<number, VideogameGenre> = {};

  videogameGenres.forEach((videogameGenre) => {
    videogameGenreMap[videogameGenre.id] = videogameGenre;
  })
  
	return videogameGenreIds.map(videogameGenreId => videogameGenreMap[videogameGenreId]);
});