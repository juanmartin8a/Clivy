import { Arg, Ctx, FieldResolver, Int, Mutation, Query, Resolver, Root, UseMiddleware } from "type-graphql";
import { Comment } from "../entities/Comments";
import { isAuth } from "../middleware/isAuth";
import { MyContext } from "../myContext";
import { getConnection } from "typeorm";
import { CommentResponse, CreateCommentResponse, UserTagInput } from "../utils/comment/commentInput";
import { User } from "../entities/User";
import { LikeResponse } from "../utils/post/postInput";
import { CommentLike } from "../entities/CommentLike";
// import { likeProcess } from "../utils/like/likeProcess";
import { CommentUserTag } from "../entities/CommentUserTags";
import { Post } from "../entities/Post";
import { Reply } from "../entities/Reply";

@Resolver(CommentUserTag)
export class CommentUserTagResolver {
	@FieldResolver(() => [CommentUserTag])
	async user(
		@Root() commentUserTag: CommentUserTag,
		@Ctx() { userLoader }: MyContext
	) {
		return userLoader.load(commentUserTag.user_id);
	}
}

@Resolver(Comment)
export class CommentResolver {

	@FieldResolver(() => [CommentUserTag])
  async userTags (
    @Root() comment: Comment,
		@Ctx() { commentUserTagsLoader }: MyContext
  ) {
		const dataLoaderRes = await commentUserTagsLoader.load(comment.id);
		return dataLoaderRes ? dataLoaderRes : [];
  }

	@FieldResolver(() => CommentLike)
  async likeState(
    @Root() comment: Comment,
		@Ctx() { commentLikeLoader, userId }: MyContext
  ) {

		if (!userId || userId === undefined) {
      return null;
    }

		const like = await commentLikeLoader.load({
      comment_id: comment.id,
      user_id: userId
    });

		console.log(like);

    return like ? true : false;
  }

	@FieldResolver(() => User)
	async user(
		@Root() comment: Comment,
		@Ctx() { userLoader }: MyContext
	) {
		if (comment.user_id && !comment.user) {
			return userLoader.load(comment.user_id);
		} else {
			return comment.user
		}
	}

	@Mutation(() => CreateCommentResponse)
	@UseMiddleware(isAuth)
	async commentPost(
		@Arg("postId", () => Int) postId: number,
		@Arg("comment", () => String) comment: string,
		@Arg("userTagsInput", () => [UserTagInput]) userTagsInput: UserTagInput[],
		@Ctx() { userId }: MyContext
	): Promise<CreateCommentResponse> {

		let postExists: boolean = true;
		let newComment: any;

		const queryRunner = getConnection().createQueryRunner()
		await queryRunner.connect()

		// await getConnection().transaction(async (tm) => {
		// newComment = await tm.query(`
		// 	insert into comment ("post_id", "user_id", "comment")
		// 	values ($1, $2, $3)
		// 	returning *;
		// `, [postId, userId, comment]);
		// console.log("hellow there my guy")
		// await queryRunner.commitTransaction(); 
		// await queryRunner.startTransaction();
		const post = await Post.findOne({
			where: { id: postId }
		})
		
		if (!post) {
			postExists = false;
			if (!postExists) {
				return {
					error: true
				}
			}
		}

		await queryRunner.startTransaction();

		try {
			console.log("a")
			newComment = await queryRunner.manager.createQueryBuilder()
			.insert()
			.into(Comment)
			.values({post_id: postId, user_id: userId, comment: comment})
			.returning("*")
			.execute()
			for (let i = 0; i < userTagsInput.length; i++) {
				await queryRunner.manager.createQueryBuilder()
				.insert()
				.into(CommentUserTag)
				.values({
					comment_id: newComment.raw[0].id, 
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
		.update(Comment)
		.set({
			id: newComment.raw[0].id
		})
		.where("id = :id", {id: newComment.raw[0].id})
		.execute()

		for (let i = 0; i < userTagsInput.length; i++) {
			await getConnection().createQueryBuilder()
			.update(CommentUserTag)
			.set({
				comment_id: newComment.raw[0].id, 
				user_id: userTagsInput[i].userId, 
				user_string: userTagsInput[i].userString
			})
			.where("comment_id = :comment_id and user_id = :user_id and user_string = :user_string", {
				comment_id: newComment.raw[0].id,
				user_id: userTagsInput[i].userId,
				user_string: userTagsInput[i].userString
			})
			.execute()
		}

		return {
			postId: postId,
			comment: newComment.raw[0]
		};
	}

	@Query(() => CommentResponse)
	@UseMiddleware(isAuth)
	async comments(
		@Arg("limit", () => Int) limit: number,
		//@Arg("cursor", () => String, {nullable: true}) cursor: string,
		@Arg("postId", () => Int) postId: number,
		@Arg("idsList", () => [Int]) idsList: number[],
		@Ctx() { userId }: MyContext
	): Promise<CommentResponse> {
		const realLimit = Math.min(20, limit);
		const realLimitLength = realLimit + 1;

		const cursorArray: any[] = [realLimitLength, postId, userId, idsList];

		const comments = await getConnection().query(`
			select c.* from comment c

			left join follow f
				on f."followingId" = c.user_id
				and f."followerId" = $3

			left join comment_like l
				on l.comment_id = c.id
				and l.user_id = $3

			where c."post_id" = $2
				and not (c.id = ANY ($4))
				order by (f is not null or l is not null) desc,
				((date_trunc('millisecond', (now() at time zone 'utc')) + interval '1' day) - (date_trunc('millisecond', (c."createdAt" at time zone 'utc')))) / greatest( (c."likeCount" + 1), 1 ) asc 
			limit $1;
		`, cursorArray);

		return {
			comments: comments.slice(0, realLimit),
			hasMore: comments.length === realLimitLength,
			postId: postId
		};
	}

	@Mutation(() => LikeResponse)
	@UseMiddleware(isAuth)
	async likeUnlikeComment(
		@Arg("commentId", () => Int) commentId: number,
		@Arg("clientId") clientId: string,
		@Ctx() { userId }: MyContext
	): Promise<LikeResponse> {

		const commentExists = await Comment.findOne({where: {
			id: commentId,
		}}); 

		if (!commentExists) {
			return {
				value: undefined
			}
		}

		const like = await CommentLike.findOne({where: {
			user_id: userId,
			comment_id: commentId
		}});

		if (!like) {
			await getConnection().createQueryBuilder()
			.insert()
			.into(CommentLike)
			.values({ user_id: userId, comment_id: commentId })
			.execute()
		} else {
			await CommentLike.remove(like);
		}

		// await likeProcess(
		// 	userHasLike != undefined, userId!, commentId, "comment", "comment_like"
		// );

		return {
			value: like ? -1 : 1,
			clientId: clientId
		};
	}

	// @Query(() => [Comment], {nullable: true})
	// async getAllComments() {
	// 	return Comment.find({});
	// }

	@Mutation(() => Boolean)
	@UseMiddleware(isAuth)
	async deleteComment(
		@Arg("commentId", () => Int) commentId: number,
		@Arg("isReply", () => Boolean) isReply: boolean,
		@Ctx() { userId }: MyContext
	) {
		console.log("hello there");
		let comment;

		if (isReply) {
			comment = await Reply.findOne({where: {
				id: commentId,
			}});
		} else {
			comment = await Comment.findOne({where: {
				id: commentId,
			}});
		}

		if (comment !== undefined) {
			if (comment.user_id === parseInt(userId!.toString())) {
				if (isReply) {
					await Reply.remove(comment);
				} else {
					await Comment.remove(comment);
				}
				return true;
			} 
			return false;
		}

		return false;
	}
	
}


// golang HAPP
// func (r *mutationResolver) CreateEvent(ctx context.Context, input model.CreateEventInput) (*model.CreateEventResponse, error) {
// 	eventPics := make([]string, len(input.EventPics))

// 	for i := 0; i < len(input.EventPics); i++ { //i, picture := range input.EventPics {
// 		content, err := io.ReadAll(input.EventPics[i].File)
// 		if err != nil {
// 			// could not read file #i
// 			return nil, fmt.Errorf("could not read picture #%s", strconv.Itoa(i))
// 		}

// 		uuid := uuid.New()
// 		uuidString := uuid.String()
// 		key := "eventPictures/" + strconv.Itoa(i) + "-" + uuidString + ".jpg"

// 		eventPics = append(eventPics, key)

// 		file := bytes.NewReader(content)
// 		uploadRes := awsS3.UploadToS3(key, file)
// 		if !uploadRes {
// 			// return error could not create event try again later
// 			return nil, fmt.Errorf("could not create event, try again later")
// 		}
// 	}

// 	msInt, _ := strconv.ParseInt(input.EventDate, 10, 64)
// 	eventDate := time.Unix(0, msInt*int64(time.Millisecond))

// 	event, err := r.client.Event.Create().
// 		SetName(input.Name).
// 		SetDescription(input.Description).
// 		SetEventPics(eventPics).
// 		SetEventDate(eventDate).
// 		Save(ctx)
// 	if err != nil {
// 		// return error could not create event
// 		return nil, fmt.Errorf("could not create event, try again later")
// 	}

// 	bulk := make([]*ent.EventUserCreate, len(input.EventUsers))

// 	for i, id := range input.EventUsers {
// 		bulk[i] = r.client.EventUser.Create().SetEventID(event.ID).SetUserID(id)
// 	}

// 	_, err = r.client.EventUser.CreateBulk(bulk...).Save(ctx)
// 	if err != nil {
// 		// return event and say that users could not be invited an error occured and
// 		// try inviting them from the created event
// 		return nil, fmt.Errorf("an error ocurred users could not be invited, you can try inviting them from the created event")
// 	}

// 	return &model.CreateEventResponse{
// 		Event: event,
// 		// Errors: &model.ErrorResponse{}[]
// 	}, nil
// }