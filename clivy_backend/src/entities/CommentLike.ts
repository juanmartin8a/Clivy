import { Field, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { Comment } from "./Comments";
import { User } from "./User";

@ObjectType()
@Entity()
export class CommentLike extends BaseEntity {
	@Field()
	@PrimaryColumn()
	user_id: number;

	@Field()
	@PrimaryColumn()
	comment_id: number;

	@Field(() => User)
	@ManyToOne(() => User, user => user.commentLikes, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "user_id" })
	user: User

	@Field(() => Comment)
	@ManyToOne(() => Comment, comment => comment.likes, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "comment_id" })
	comment: Comment

	@Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}