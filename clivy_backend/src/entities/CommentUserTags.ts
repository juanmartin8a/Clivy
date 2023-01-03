import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm"
import { User } from "./User";
import { Comment } from "./Comments";

@ObjectType()
@Entity()
export class CommentUserTag extends BaseEntity {
  // @Field(() => Int)
  // @PrimaryGeneratedColumn()
  // id: number;

  @Field(() => Int)
  @PrimaryColumn()
  comment_id: number;

  @Field(() => Int)
  @PrimaryColumn()
  user_id: number;

  @Field(() => String)
  @Column()
  user_string: String;

  @Field(() => User)
	@ManyToOne(() => User, (user) => user.commentUserTags, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "user_id" })
	user: User;

  @Field(() => Comment)
	@ManyToOne(() => Comment, (comment) => comment.userTags, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "comment_id" })
	comment: Comment;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}