import { Arg, Ctx, FieldResolver, Int, Mutation, Query, Resolver, Root, UseMiddleware } from "type-graphql";
import { isAuth } from "../middleware/isAuth";
import { MyContext } from "../myContext";
import { getConnection } from "typeorm";
import { CreateReplyResponse, ReplyResponse, UserTagInput } from "../utils/comment/commentInput";
import { User } from "../entities/User";
import { Reply } from "../entities/Reply";
import { LikeResponse } from "../utils/post/postInput";
import { ReplyLike } from "../entities/ReplyLike";
// import { likeProcess } from "../utils/like/likeProcess";
import { ReplyUserTag } from "../entities/ReplyUserTags";
import { Comment } from "../entities/Comments";

@Resolver(ReplyUserTag)
export class ReplyUserTagResolver {
	@FieldResolver(() => [ReplyUserTag])
	async user(
		@Root() replyUserTag: ReplyUserTag,
		@Ctx() { userLoader }: MyContext
	) {
		return userLoader.load(replyUserTag.user_id);
	}
}

@Resolver(Reply)
export class ReplyResolver {

	@FieldResolver(() => [ReplyUserTag])
  async userTags (
    @Root() reply: Reply,
		@Ctx() { replyUserTagsLoader }: MyContext
  ) {
		const dataLoaderRes = await replyUserTagsLoader.load(reply.id);
		return dataLoaderRes ? dataLoaderRes : [];
  }

	@FieldResolver(() => ReplyLike)
  async likeState(
    @Root() reply: Reply,
		@Ctx() { replyLikeLoader, userId }: MyContext
  ) {

		if (!userId || userId === undefined) {
      return null;
    }

		const like = await replyLikeLoader.load({
      reply_id: reply.id,
      user_id: userId
    });

    return like ? true : false;
  }

	@FieldResolver(() => [User])
	async user(
		@Root() reply: Reply,
		@Ctx() { userLoader }: MyContext
	) {
		if (reply.user_id && !reply.user) {
			return userLoader.load(reply.user_id);
		} else {
			return reply.user
		}
	}

	@Mutation(() => CreateReplyResponse)
	@UseMiddleware(isAuth)
	async replyComment(
		@Arg("commentId", () => Int) commentId: number,
		@Arg("postId", () => Int) postId: number,
		@Arg("reply", () => String) reply: string,
		@Arg("userTagsInput", () => [UserTagInput]) userTagsInput: UserTagInput[],
		@Ctx() { userId }: MyContext
	): Promise<CreateReplyResponse> {

		let commentExists: boolean = true;
		let newReply: any;

		const queryRunner = getConnection().createQueryRunner()
		await queryRunner.connect()

		const comment = await Comment.findOne({
			where: { id: commentId }
		})
		
		if (!comment) {
			commentExists = false;
			if (!commentExists) {
				return {
					error: true
				}
			}
		}

		await queryRunner.startTransaction();

		try {
			newReply = await queryRunner.manager.createQueryBuilder()
			.insert()
			.into(Reply)
			.values({comment_id: commentId, post_id: postId, user_id: userId, reply: reply})
			.returning("*")
			.execute()
			for (let i = 0; i < userTagsInput.length; i++) {
				await queryRunner.manager.createQueryBuilder()
				.insert()
				.into(ReplyUserTag)
				.values({
					reply_id: newReply.raw[0].id, 
					user_id: userTagsInput[i].userId, 
					user_string: userTagsInput[i].userString
				})
				.execute()
			}

			await queryRunner.commitTransaction();

		} catch {
			await queryRunner.rollbackTransaction();
		} finally {
			await queryRunner.release();
		}

		await getConnection().createQueryBuilder()
		.update(Reply)
		.set({
			id: newReply.raw[0].id
		})
		.where("id = :id", {id: newReply.raw[0].id})
		.execute()

		for (let i = 0; i < userTagsInput.length; i++) {
			await getConnection().createQueryBuilder()
			.update(ReplyUserTag)
			.set({
				reply_id: newReply.raw[0].id, 
				user_id: userTagsInput[i].userId, 
				user_string: userTagsInput[i].userString
			})
			.where("reply_id = :reply_id and user_id = :user_id and user_string = :user_string", {
				reply_id: newReply.raw[0].id, 
				user_id: userTagsInput[i].userId, 
				user_string: userTagsInput[i].userString
			})
			.execute()
		}

		return {
			commentId: commentId,
			postId: postId,
			reply: newReply.raw[0]
		};
	}

	@Query(() => ReplyResponse)
	@UseMiddleware(isAuth)
	async commentReplies(
		@Arg("limit", () => Int) limit: number,
		@Arg("cursor", () => String, {nullable: true}) cursor: string,
		@Arg("commentId", () => Int) commentId: number,
		@Arg("postId", () => Int) postId: number,
		@Arg("idsList", () => [Int]) idsList: number[],
	): Promise<ReplyResponse> {
		const realLimit = Math.min(20, limit);
		const realLimitLength = realLimit + 1;

		const cursorArray: any[] = [commentId, realLimitLength, idsList];
		
		if (cursor) {
			cursorArray.push(new Date(parseInt(cursor)));
		}

		const replies = await getConnection().query(`
			select r.* from reply r
			where r."comment_id" = $1
			and not (r.id = ANY ($3))
			${cursor ? `and date_trunc('millisecond', (r."createdAt" at time zone 'utc')) > date_trunc('millisecond', ($4::timestamptz at time zone 'utc'))` : ""}
			order by r."createdAt" ASC
			limit $2;
			`, cursorArray);

		return {
			replies: replies.slice(0, realLimit),
			hasMore: replies.length === realLimitLength,
			commentId: commentId,
			postId: postId
		};
	}

	@Mutation(() => LikeResponse)
	@UseMiddleware(isAuth)
	async likeUnlikeReply(
		@Arg("replyId", () => Int) replyId: number,
		@Arg("clientId") clientId: string,
		@Ctx() { userId }: MyContext
	): Promise<LikeResponse> {

		const replyExists = await Reply.findOne({where: {
			id: replyId,
		}}); 

		if (!replyExists) {
			return {
				value: undefined
			}
		}

		const like = await ReplyLike.findOne({where: {
			user_id: userId,
			reply_id: replyId
		}});

		if (!like) {
			await getConnection().createQueryBuilder()
			.insert()
			.into(ReplyLike)
			.values({ user_id: userId, reply_id: replyId })
			.execute()
		} else {
			await ReplyLike.remove(like);
		}

		// await likeProcess(
		// 	userHasLike != undefined, userId!, replyId, "reply", 'reply_like'
		// );

		return {
			value: like ? -1 : 1,
			clientId: clientId
		};
	}
	
}