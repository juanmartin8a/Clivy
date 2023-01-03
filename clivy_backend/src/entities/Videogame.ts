import { FileResponse } from "../utils/global/globalInput";
import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { VideogameGenreVideogame } from "./VideogameGenreVideogame";
import { Post } from "./Post";
import { VideogameUserPreferences } from "./VideogameUserPreferences";

@ObjectType()
@Entity()
export class Videogame extends BaseEntity {
  @Field(() => Int)
  @PrimaryGeneratedColumn()
  id: number

  @Field()
  @Column()
  name: string

  @Field()
  @Column()
  file_key: string

  @Field(() => FileResponse)
	file: FileResponse;

  @Field(() => Int)
  @Column({type: 'int', default: 0})
  tapCount: number

  @Field(() => Int)
  @Column({type: 'int', default: 0})
  postCount: number

  @Field(() => [VideogameGenreVideogame])
	@OneToMany(() => VideogameGenreVideogame, (videogameGenreVideogame) => videogameGenreVideogame.videogame)
	videogameGenre: VideogameGenreVideogame[];

  @Field(() => [Post])
	@OneToMany(() => Post, (post) => post.videogame)
	post: Post[];

  @Field(() => [VideogameUserPreferences])
	@OneToMany(() => VideogameUserPreferences, (vup) => vup.videogame)
	videogameUserPreference: VideogameUserPreferences[];

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
	
	@Field(() => String)
	@UpdateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	updatedAt: Date;
}