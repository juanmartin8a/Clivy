import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm"
import { Reply } from "./Reply";
import { User } from "./User";

@ObjectType()
@Entity()
export class ReplyUserTag extends BaseEntity {
  // @Field(() => Int)
  // @PrimaryGeneratedColumn()
  // id: number;

  @Field(() => Int)
  @PrimaryColumn()
  reply_id: number;

  @Field(() => Int)
  @PrimaryColumn()
  user_id: number;

  @Field(() => String)
  @Column()
  user_string: String;

  @Field(() => User)
	@ManyToOne(() => User, (user) => user.replyUserTags, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "user_id" })
	user: User;

  @Field(() => Reply)
	@ManyToOne(() => Reply, (reply) => reply.userTags, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "reply_id" })
	reply: Reply;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}