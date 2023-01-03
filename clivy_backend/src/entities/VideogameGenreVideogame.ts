import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { Videogame } from "./Videogame";
import { VideogameGenre } from "./VideogameGenre";

@ObjectType()
@Entity()
export class VideogameGenreVideogame extends BaseEntity {
	@Field(() => Int)
  @PrimaryColumn()
  videogame_genre_id: number

	@Field(() => Int)
  @PrimaryColumn()
  videogame_id: number

  @Field(() => VideogameGenre)
	@ManyToOne(() => VideogameGenre, (videogameGenre) => videogameGenre.videogameGenreVideogames, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "videogame_genre_id" })
	videogameGenre: VideogameGenre;

	@Field(() => Videogame)
	@ManyToOne(() => Videogame, (videogame) => videogame.videogameGenre, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "videogame_id" })
	videogame: Videogame;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}