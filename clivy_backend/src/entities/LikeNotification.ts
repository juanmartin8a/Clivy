import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryColumn, UpdateDateColumn } from "typeorm";
import { Post } from "./Post";
import { Notification, NotificationType } from "./Notification";
import { User } from "./User";

@ObjectType()
@Entity()
export class LikeNotification extends BaseEntity {
  @Field(() => Int)
  @PrimaryColumn()
  post_id: number

  @Field(() => Int)
  @PrimaryColumn()
  user_id: number

	@Field(() => Int)
  @PrimaryColumn()
  type: NotificationType

  @OneToOne(() => Notification, notification => notification.likeNotification, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn([
		{ name: "post_id", referencedColumnName: "parent_id" },
		{ name: "user_id", referencedColumnName: "user_id" },
		{ name: "type", referencedColumnName: "type" }
	])
	notification: Notification

  @Field(() => Post)
  @ManyToOne(() => Post, post => post.likeNotifications, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "post_id" })
	post: Post
	
	@ManyToOne(() => User, user => user.commentLikeNotification, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "user_id" })
	user: User

	@Field(() => String)
	@UpdateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	updatedAt: Date;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}