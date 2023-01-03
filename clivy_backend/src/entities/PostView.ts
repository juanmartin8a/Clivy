import { Field, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { Post } from "./Post";
import { User } from "./User";

@Entity()
@ObjectType()
export class PostView extends BaseEntity {
  @Field()
  @PrimaryColumn()
  post_id: number;

  @Field()
  @PrimaryColumn()
  user_id: number;

  @ManyToOne(() => Post, post => post.postViews, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({ name: "post_id" })
  post: Post

  @ManyToOne(() => User, user => user.postViews, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({ name: "user_id" })
  user: User

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}