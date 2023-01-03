import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Comment } from "./Comments";
import { ReplyLike } from "./ReplyLike";
import { ReplyLikeNotification } from "./ReplyLikeNotification";
import { ReplyNotification } from "./ReplyNotification";
import { ReplyTagNotification } from "./ReplyTagNotification";
import { ReplyUserTag } from "./ReplyUserTags";
import { User } from "./User";

@ObjectType()
@Entity()
export class Reply extends BaseEntity {
  @Field()
	@PrimaryGeneratedColumn()
	id!: number;

	@Field()
	@Column()
	user_id!: number;

	@Field()
	@Column()
	comment_id!: number;

	@Field()
	@Column()
	post_id!: number;

	@Field()
	@Column()
	reply!: string;

	@Field(() => User)
	@ManyToOne(() => User, (user) => user.replies, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "user_id" })
	user: User;

	@Field(() => Comment)
	@ManyToOne(() => Comment, (comment) => comment.replies, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "comment_id" })
	comment: Comment;

	@Field(() => [ReplyLike])
	@OneToMany(() => ReplyLike, like => like.reply)
	likes: ReplyLike[];

	@Field(() => Boolean, {nullable: true})
	likeState: boolean;

	@Field(() => Int)
	@Column({type: 'int', default: 0})
	likeCount: number;

	@Field(() => [ReplyUserTag])
	@OneToMany(() => ReplyUserTag, userTags => userTags.reply)
	userTags: ReplyUserTag[];

	@Field(() => [ReplyLikeNotification])
	@OneToMany(() => ReplyLikeNotification, (likeNotification) => likeNotification.reply)
	likeNotifications: ReplyLikeNotification[];

	@Field(() => [ReplyNotification])
	@OneToMany(() => ReplyNotification, (replyNotification) => replyNotification.reply)
	replyNotification: ReplyNotification[];

	@Field(() => [ReplyTagNotification])
	@OneToMany(() => ReplyTagNotification, (replyTagNotification) => replyTagNotification.reply)
	replyTagNotification: ReplyTagNotification[];

	@Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
	
	@Field(() => String)
	@UpdateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	updatedAt: Date;

}