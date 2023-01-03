import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm"
import { User } from "./User";
import { Post } from "./Post";

@ObjectType()
@Entity()
export class CaptionUserTag extends BaseEntity {
  // @Field(() => Int)
  // @PrimaryGeneratedColumn()
  // id: number;

  @Field(() => Int)
  @PrimaryColumn()
  post_id: number;

  @Field(() => Int)
  @PrimaryColumn()
  user_id: number;

  @Field(() => String)
  @Column()
  user_string: String;

  @Field(() => User)
	@ManyToOne(() => User, (user) => user.captionUserTags, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "user_id" })
	user: User;

  @Field(() => Post)
	@ManyToOne(() => Post, (post) => post.userTags, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete',
	})
	@JoinColumn({ name: "post_id" })
	post: Post;
}