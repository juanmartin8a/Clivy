import { Field, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { Post } from "./Post";
import { VideogameGenre } from "./VideogameGenre";

@ObjectType()
@Entity()
export class VideogameGenrePost extends BaseEntity {
  @PrimaryColumn()
  videogame_genre_id: number

  @PrimaryColumn()
  post_id: number

  @Field(() => VideogameGenre)
	@ManyToOne(() => VideogameGenre, (videogameGenre) => videogameGenre.videogameGenrePost, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "videogame_genre_id" })
	videogameGenre: VideogameGenre;

	@Field(() => Post)
	@ManyToOne(() => Post, (post) => post.videogameGenre, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "post_id" })
	post: Post;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}