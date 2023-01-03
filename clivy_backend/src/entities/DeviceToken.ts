import { ObjectType, Field } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { User } from "./User";

export enum Platforms {
  iOS = "iOS",
  Android = "Android"
}

@ObjectType()
@Entity()
export class DeviceToken extends BaseEntity {
  @PrimaryColumn()
  token: string;

  @Column()
  platform: Platforms;

  @PrimaryColumn()
  user_id: number

  @ManyToOne(() => User, (user) => user.deviceToken, {
    onDelete: "CASCADE",
    orphanedRowAction: 'delete'
  })
  @JoinColumn({name: "user_id"})
  user: User

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}