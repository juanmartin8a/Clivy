import { Field, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { User } from "./User";
import { VideogameGenre } from "./VideogameGenre";

@ObjectType()
@Entity()
export class VideogameGenreUserPreferences extends BaseEntity {
  @PrimaryColumn()
  user_id: number

  @PrimaryColumn()
  genre_id: number

  @Column({type: 'int', default: 0})
  likeCount: number

  @Column({type: 'int', default: 0})
  viewCount: number

  @ManyToOne(() => User, user => user.videogameGenreUserPreference, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({name: "user_id"})
  user: User;

  @ManyToOne(() => VideogameGenre, genre => genre.videogameGenreUserPreference, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({name: "genre_id"})
  genre: VideogameGenre;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}