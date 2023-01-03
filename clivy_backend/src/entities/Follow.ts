import { Field, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { User } from "./User";

@Entity()
@ObjectType()
export class Follow extends BaseEntity {
  @Field()
  @PrimaryColumn()
  followerId: number;

  @Field()
  @PrimaryColumn()
  followingId: number;

  @ManyToOne(() => User, user => user.followers, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({ name: "followerId" })
  follower: User

  @ManyToOne(() => User, user => user.following, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({ name: "followingId" })
  following: User

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}