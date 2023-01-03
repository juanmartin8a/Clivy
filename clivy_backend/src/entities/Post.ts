import { FileResponse } from "../utils/global/globalInput";
import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Like } from "./Like";
import { User } from "./User";
import { Comment } from "./Comments";
import { CaptionUserTag } from "./CaptionUserTags";
import { VideogameGenrePost } from "./VideogameGenrePost";
import { Videogame } from "./Videogame";
import { PostView } from "./PostView";
import { LikeNotification } from "./LikeNotification";
import { CaptionTagNotification } from "./CaptionTagNotification";

@ObjectType()
@Entity()
export class Post extends BaseEntity {
	@Field()
	@PrimaryGeneratedColumn()
	id!: number;

	@Field()
	@Column()
	caption!: string;

	@Field()
	@Column()
	file_key!: string;

	@Field(() => FileResponse)
	file: FileResponse;

	@Field(() => Int)
	@Column()
	fileWidth!: number;

	@Field(() => Int)
	@Column()
	fileHeight!: number;

	@Field()
	@Column()
	fileGifKey!: string;

	@Field(() => FileResponse)
	fileGif: FileResponse;

	@Field()
	@Column()
	fileImgKey!: string;

	@Field(() => FileResponse)
	fileImg: FileResponse;
	
	@Field()
	@Column()
	user_id!: number;

	@ManyToOne(() => User, user => user.posts, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "user_id" })
	user: User;

	@Field(() => [Like])
	@OneToMany(() => Like, like => like.post)
	likes: Like[];

	@Field(() => Boolean, {nullable: true})
	likeState: boolean

	@Field(() => Int)
	@Column({type: 'int', default: 0})
	likeCount: number;

	@Field(() => [Comment])
	@OneToMany(() => Comment, (comment) => comment.post)
	comments: Comment[];

	@Field(() => Int)
	@Column({type: 'int', default: 0})
	commentCount: number;

	@Field(() => [CaptionUserTag])
	@OneToMany(() => CaptionUserTag, userTags => userTags.post)
	userTags: CaptionUserTag[];

	@Field(() => Int)
	@Column({type: 'int', nullable: true})
	videogame_id: number

	@Field(() => [Videogame])
	@ManyToOne(() => Videogame, (videogame) => videogame.post)
	@JoinColumn({ name: "videogame_id" })
	videogame: Videogame;

	@Field(() => [VideogameGenrePost])
	@OneToMany(() => VideogameGenrePost, (videogameGenrePost) => videogameGenrePost.post)
	videogameGenre: VideogameGenrePost[];

	@Field(() => Int)
	@Column({type: 'int', default: 0})
	viewsCount: number

	@Field(() => [PostView])
	@OneToMany(() => PostView, (postViews) => postViews.post)
	postViews: PostView[];

	@Field(() => [LikeNotification])
	@OneToMany(() => LikeNotification, (likeNotification) => likeNotification.post)
	likeNotifications: LikeNotification[];

	@Field(() => [CaptionTagNotification])
	@OneToMany(() => CaptionTagNotification, (captionTagNotification) => captionTagNotification.post)
	captionTagNotification: CaptionTagNotification[];

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;

	@Field(() => String)
	@UpdateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	updatedAt: Date;
}