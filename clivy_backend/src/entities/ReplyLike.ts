import { Field, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { Reply } from "./Reply";
import { User } from "./User";

@ObjectType()
@Entity()
export class ReplyLike extends BaseEntity {
	@Field()
	@PrimaryColumn()
	user_id: number;

	@Field()
	@PrimaryColumn()
	reply_id: number;

	@Field(() => User)
	@ManyToOne(() => User, user => user.replyLikes, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "user_id" })
	user: User

	@Field(() => Reply)
	@ManyToOne(() => Reply, reply => reply.likes, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "reply_id" })
	reply: Reply

	@Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}