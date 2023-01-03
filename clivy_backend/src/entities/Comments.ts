import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { CommentLike } from "./CommentLike";
import { CommentLikeNotification } from "./CommentLikeNotification";
import { CommentNotification } from "./CommentNotification";
import { CommentTagNotification } from "./CommentTagNotification";
import { CommentUserTag } from "./CommentUserTags";
import { Post } from "./Post";
import { Reply } from "./Reply";
import { User } from "./User";

@ObjectType()
@Entity()
export class Comment extends BaseEntity {
	@Field()
	@PrimaryGeneratedColumn()
	id!: number;

	@Field()
	@Column()
	user_id!: number;

	@Field()
	@Column()
	post_id!: number;

	@Field()
	@Column()
	comment!: string;

	@Field(() => User)
	@ManyToOne(() => User, (user) => user.comments, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "user_id" })
	user: User;

	@Field(() => Post)
	@ManyToOne(() => Post, (post) => post.comments, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "post_id" })
	post: Post;

	@Field(() => Int)
	@Column({type: 'int', default: 0})
	replyCount: number;

	@Field(() => [Reply])
	@OneToMany(() => Reply, (reply) => reply.comment)
	replies: Reply[];

	@Field(() => [CommentLike])
	@OneToMany(() => CommentLike, like => like.comment)
	likes: CommentLike[];

	@Field(() => Boolean, {nullable: true})
	likeState: boolean

	@Field(() => Int)
	@Column({type: 'int', default: 0})
	likeCount: number;

	@Field(() => [CommentUserTag])
	@OneToMany(() => CommentUserTag, userTags => userTags.comment)
	userTags: CommentUserTag[];

	@Field(() => [CommentLikeNotification])
	@OneToMany(() => CommentLikeNotification, (likeNotification) => likeNotification.comment)
	likeNotifications: CommentLikeNotification[];

	@Field(() => [CommentNotification])
	@OneToMany(() => CommentNotification, (commentNotification) => commentNotification.comment)
	commentNotification: CommentNotification[];

	@Field(() => [CommentTagNotification])
	@OneToMany(() => CommentTagNotification, (commentTagNotification) => commentTagNotification.comment)
	commentTagNotification: CommentTagNotification[];

	@Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
	
	@Field(() => String)
	@UpdateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	updatedAt: Date;

}