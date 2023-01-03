import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { User } from "./User";

@ObjectType()
@Entity()
export class UserSearch extends BaseEntity {
  @Field(() => Int)
  @PrimaryColumn()
  userId: number;

  @Field(() => Int)
  @PrimaryColumn()
  searchedUserId: number;

  @Field(() => User)
  @ManyToOne(() => User, user => user.searchedUsers, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
  @JoinColumn({ name: "userId" })
  user: User; // usersSearched

  @Field(() => User)
  @ManyToOne(() => User, user => user.searchedBy, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
  @JoinColumn({ name: "searchedUserId" })
  searchedUser: User; // searchedBy

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	updatedAt: Date;
}