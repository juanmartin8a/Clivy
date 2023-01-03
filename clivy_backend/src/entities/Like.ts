import { Field, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { Post } from "./Post";
import { User } from "./User";

@ObjectType()
@Entity()
export class Like extends BaseEntity {
	@Field()
	@PrimaryColumn()
	user_id: number;

	@Field()
	@PrimaryColumn()
	post_id: number;

	@Field(() => User)
	@ManyToOne(() => User, user => user.likes, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "user_id" })
	user: User

	@Field(() => Post)
	@ManyToOne(() => Post, post => post.likes, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "post_id" })
	post: Post

	@Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}