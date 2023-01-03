import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryColumn, UpdateDateColumn } from "typeorm";
import { Notification, NotificationType } from "./Notification";
import { User } from "./User";
import { Reply } from "./Reply";

@ObjectType()
@Entity()
export class ReplyTagNotification extends BaseEntity {
  @Field(() => Int)
  @PrimaryColumn()
  reply_id: number

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
		{ name: "reply_id", referencedColumnName: "parent_id" },
		{ name: "user_id", referencedColumnName: "user_id" },
		{ name: "type", referencedColumnName: "type" }
	])
	notification: Notification

  @Field(() => Reply)
  @ManyToOne(() => Reply, reply => reply.replyTagNotification, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "reply_id" })
	reply: Reply
	
	@ManyToOne(() => User, user => user.replyTagNotification, {
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