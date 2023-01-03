import { FileResponse } from "../utils/global/globalInput";
import { Field, Int, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Comment } from "./Comments";
import { Like } from "./Like";
import { Post } from "./Post";
import { Reply } from "./Reply";
import { UserSearch } from "./UserSearches";
import { Follow } from "./Follow";
import { CommentLike } from "./CommentLike";
import { ReplyLike } from "./ReplyLike";
import { CommentUserTag } from "./CommentUserTags";
import { ReplyUserTag } from "./ReplyUserTags";
import { CaptionUserTag } from "./CaptionUserTags";
import { PostView } from "./PostView";
import { VideogameUserPreferences } from "./VideogameUserPreferences";
import { VideogameGenreUserPreferences } from "./VideogameGenreUserPreferences";
import { DeviceToken } from "./DeviceToken";
import { Notification } from "./Notification";
import { LikeNotification } from "./LikeNotification";
import { CommentLikeNotification } from "./CommentLikeNotification";
import { ReplyLikeNotification } from "./ReplyLikeNotification";
import { FollowNotification } from "./FollowNotification";
import { CommentNotification } from "./CommentNotification";
import { ReplyNotification } from "./ReplyNotification";
import { CommentTagNotification } from "./CommentTagNotification";
import { ReplyTagNotification } from "./ReplyTagNotification";
import { CaptionTagNotification } from "./CaptionTagNotification";

@ObjectType()
@Entity()
export class User extends BaseEntity {
	@Field()
	@PrimaryGeneratedColumn()
	id!: number;

	@Field()
	@Column()
	name!: string;

	@Field()
	@Column({unique: true})
	username!: string;

	@Field()
	@Column({unique: true})
	email!: string;

	@Field()
	@Column({default: ""})
	bio!: string;

	@Field()
	@Column()
	file_key!: string;

	@Field(() => FileResponse)
	file: FileResponse;

	@Field()
	@Column()
	small_file_key!: string;

	@Field(() => FileResponse)
	smallFile: FileResponse;

	@Column()
	password!: string;

	@Field(() => Int)
	@Column({type: "int", default: 0})
	postCount!: number;
	//post
	@OneToMany(() => Post, post => post.user)
	posts: Post[]

	//all liked videos
	@OneToMany(() => Like, like => like.user)
  likes: Like[];

	@OneToMany(() => CommentLike, like => like.user)
  commentLikes: CommentLike[];

	@OneToMany(() => ReplyLike, like => like.user)
  replyLikes: ReplyLike[];

	@OneToMany(() => Comment, comment => comment.user)
  comments: Comment[];

	@Field(() => [Reply])
	@OneToMany(() => Reply, (reply) => reply.user)
	replies: Reply[];

	@Field(() => [UserSearch])
	@OneToMany(() => UserSearch, (reply) => reply.user)
	searchedUsers: UserSearch[];
	
	@Field(() => [UserSearch])
	@OneToMany(() => UserSearch, (reply) => reply.searchedUser)
	searchedBy: UserSearch[];

	@Field(() => [Follow])
	@OneToMany(() => Follow, (follow) => follow.follower)
	followers: UserSearch[];

	@Field(() => Int)
	@Column({type: 'int', default: 0})
	followersCount: number;

	@Field(() => [Follow])
	@OneToMany(() => Follow, (follow) => follow.following)
	following: UserSearch[];

	@Field(() => Int)
	@Column({type: 'int', default: 0})
	followingCount: number;

	@Field(() => Boolean, {nullable: true})
	followState: boolean

	@Field(() => [CommentUserTag])
	@OneToMany(() => CommentUserTag, (userTags) => userTags.user)
	commentUserTags: CommentUserTag[];

	@Field(() => [ReplyUserTag])
	@OneToMany(() => ReplyUserTag, (userTags) => userTags.user)
	replyUserTags: ReplyUserTag[];

	@Field(() => [CaptionUserTag])
	@OneToMany(() => CaptionUserTag, (userTags) => userTags.user)
	captionUserTags: CaptionUserTag[];

	@Field(() => [PostView])
	@OneToMany(() => PostView, (postViews) => postViews.user)
	postViews: PostView[];

	@Field(() => [VideogameUserPreferences])
	@OneToMany(() => VideogameUserPreferences, (vup) => vup.user)
	videogameUserPreference: VideogameUserPreferences[];

	@Field(() => [VideogameGenreUserPreferences])
	@OneToMany(() => VideogameGenreUserPreferences, (vgup) => vgup.user)
	videogameGenreUserPreference: VideogameGenreUserPreferences[];

	@Field(() => [DeviceToken])
	@OneToMany(() => DeviceToken, (deviceToken) => deviceToken.user)
	deviceToken: DeviceToken[];

	@Field(() => [Notification])
	@OneToMany(() => Notification, (notification) => notification.user)
	notification: Notification[];

	@Field(() => [LikeNotification])
	@OneToMany(() => LikeNotification, (likeNotification) => likeNotification.user)
	likeNotification: LikeNotification[];

	@Field(() => [CommentLikeNotification])
	@OneToMany(() => CommentLikeNotification, (likeNotification) => likeNotification.user)
	commentLikeNotification: CommentLikeNotification[];

	@Field(() => [ReplyLikeNotification])
	@OneToMany(() => ReplyLikeNotification, (likeNotification) => likeNotification.user)
	replyLikeNotification: ReplyLikeNotification[];

	@Field(() => [FollowNotification])
	@OneToMany(() => FollowNotification, (followNotification) => followNotification.follower)
	followerNotification: FollowNotification[];

	@Field(() => [FollowNotification])
	@OneToMany(() => FollowNotification, (followNotification) => followNotification.user)
	followNotification: FollowNotification[];

	@Field(() => [CommentNotification])
	@OneToMany(() => CommentNotification, (commentNotification) => commentNotification.user)
	commentNotification: CommentNotification[];

	@Field(() => [ReplyNotification])
	@OneToMany(() => ReplyNotification, (replyNotification) => replyNotification.user)
	replyNotification: ReplyNotification[];

	@Field(() => [CommentTagNotification])
	@OneToMany(() => CommentTagNotification, (commentTagNotification) => commentTagNotification.user)
	commentTagNotification: CommentTagNotification[];

	@Field(() => [ReplyTagNotification])
	@OneToMany(() => ReplyTagNotification, (replyTagNotification) => replyTagNotification.user)
	replyTagNotification: ReplyTagNotification[];

	@Field(() => [CaptionTagNotification])
	@OneToMany(() => CaptionTagNotification, (captionTagNotification) => captionTagNotification.user)
	captionTagNotification: CaptionTagNotification[];

	@Field(() => String)
	@Column({ type: 'date' })
	birthday: Date;
	
	@Field(() => String)
	@CreateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	createdAt: Date;
	
	@Field(() => String)
	@UpdateDateColumn({ type: 'timestamptz', precision: 6, default: () => "CURRENT_TIMESTAMP(6)" })
	updatedAt: Date;
}