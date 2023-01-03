import { Field, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { User } from "./User";
import { Videogame } from "./Videogame";

@ObjectType()
@Entity()
export class VideogameUserPreferences extends BaseEntity {
  @PrimaryColumn()
  user_id: number

  @PrimaryColumn()
  videogame_id: number

  @Column({type: 'int', default: 0})
  likeCount: number

  @Column({type: 'int', default: 0})
  viewCount: number

  @ManyToOne(() => User, user => user.videogameUserPreference, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({name: "user_id"})
  user: User;

  @ManyToOne(() => Videogame, videogame => videogame.videogameUserPreference, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({name: "videogame_id"})
  videogame: Videogame;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}