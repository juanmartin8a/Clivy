// NOTIFICATION table

import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryColumn, UpdateDateColumn } from "typeorm";
import { CaptionTagNotification } from "./CaptionTagNotification";
import { CommentLikeNotification } from "./CommentLikeNotification";
import { CommentNotification } from "./CommentNotification";
import { CommentTagNotification } from "./CommentTagNotification";
import { FollowNotification } from "./FollowNotification";
import { LikeNotification } from "./LikeNotification";
import { ReplyLikeNotification } from "./ReplyLikeNotification";
import { ReplyNotification } from "./ReplyNotification";
import { ReplyTagNotification } from "./ReplyTagNotification";
import { User } from "./User";

// show notifications in feed
// if more than 3 notifications belonging to the same parent id (likes only) then show stacked notification
// order them by created at time

// parent notification 
// two columns 
// id PK and user_id
// many to one below
// child notification categories like mention, like, follow, comment
// child columns
// primary keys
// notification id 
// parent id (in like parent is post_id, mention comment_id, follow user_id)

// ADD MIGRATINO WITH THIS

export enum NotificationType {
	like = "like",
	commentLike = "comment_like",
	replyLike = "reply_like",
	follow = "follow",
	comment = "comment",
	reply = "reply",
	commentTag = "comment_tag",
	replyTag = "reply_tag",
	capTag = "caption_tag"
}

@ObjectType()
@Entity()
export class Notification extends BaseEntity {

	@Field(() => Int)
  @PrimaryColumn()
  parent_id: number

	@Field(() => Int)
  @PrimaryColumn()
  user_id: number

	@Field(() => String)
  @PrimaryColumn()
  type: NotificationType

	@Field(() => String)
	concatenated_id: string

  @ManyToOne(() => User, user => user.notification, {
		onDelete: "CASCADE",
		orphanedRowAction: 'delete'
	})
	@JoinColumn({ name: "user_id" })
	user: User

	@Field(() => LikeNotification, {nullable: true})
	@OneToOne(() => LikeNotification, (likeNofication) => likeNofication.notification)
	likeNotification: LikeNotification;

	@Field(() => CommentLikeNotification, {nullable: true})
	@OneToOne(() => CommentLikeNotification, (likeNofication) => likeNofication.notification)
	likeCommentNotification: CommentLikeNotification;

	@Field(() => ReplyLikeNotification, {nullable: true})
	@OneToOne(() => ReplyLikeNotification, (likeNofication) => likeNofication.notification)
	likeReplyNotification: ReplyLikeNotification;

	@Field(() => FollowNotification, {nullable: true})
	@OneToOne(() => FollowNotification, (followNofication) => followNofication.notification)
	followNotification: FollowNotification;

	@Field(() => CommentNotification, {nullable: true})
	@OneToOne(() => CommentNotification, (followNofication) => followNofication.notification, {nullable: true})
	commentNotification: CommentNotification;

	@Field(() => ReplyNotification, {nullable: true})
	@OneToOne(() => ReplyNotification, (replyNofication) => replyNofication.notification)
	replyNotification: ReplyNotification;

	@Field(() => CommentTagNotification, {nullable: true})
	@OneToOne(() => CommentTagNotification, (commentTagNofication) => commentTagNofication.notification)
	commentTagNotification: CommentTagNotification;

	@Field(() => ReplyTagNotification, {nullable: true})
	@OneToOne(() => ReplyTagNotification, (replyTagNofication) => replyTagNofication.notification)
	replyTagNotification: ReplyTagNotification;

	@Field(() => CaptionTagNotification, {nullable: true})
	@OneToOne(() => CaptionTagNotification, (captionTagNofication) => captionTagNofication.notification)
	captionTagNotification: CaptionTagNotification;

	@Field(() => String)
	@UpdateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	updatedAt: Date;

  @Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
}