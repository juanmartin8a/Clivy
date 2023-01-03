import { VideogameGenres } from "../utils/videogameGenre/videogameGenreTypes";
import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { VideogameGenreVideogame } from "./VideogameGenreVideogame";
import { VideogameGenrePost } from "./VideogameGenrePost";
import { VideogameGenreUserPreferences } from "./VideogameGenreUserPreferences";

@ObjectType()
@Entity()
export class VideogameGenre extends BaseEntity {
  @Field(() => Int)
  @PrimaryGeneratedColumn()
  id: number

  @Field(() => String)
  @Column()
  videogame_genre: VideogameGenres

  @Field(() => [VideogameGenreVideogame])
  @OneToMany(() => VideogameGenreVideogame, (videogameGenreVideogame) => videogameGenreVideogame.videogameGenre)
  videogameGenreVideogames: VideogameGenreVideogame[];

  @Field(() => [VideogameGenrePost])
  @OneToMany(() => VideogameGenrePost, (videogameGenrePost) => videogameGenrePost.videogameGenre)
  videogameGenrePost: VideogameGenrePost[];

  @Field(() => [VideogameGenreUserPreferences])
	@OneToMany(() => VideogameGenreUserPreferences, (vgup) => vgup.genre)
	videogameGenreUserPreference: VideogameGenreUserPreferences[];

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}
