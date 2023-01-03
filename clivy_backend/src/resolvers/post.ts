import { Arg, Ctx, FieldResolver, Int, Mutation, Query, Resolver, Root, UseMiddleware } from "type-graphql";
import { getConnection } from "typeorm";
import { Post } from "../entities/Post";
import { CreatePostResponse, FileDimsInput, LikeResponse, PaginatedPosts } from "../utils/post/postInput";
import { validatePost } from "../utils/post/validateInput";
import { v4 as uuidv4 } from 'uuid';
import { FileUpload, GraphQLUpload } from "graphql-upload";
import { Like } from "../entities/Like";
import { MyContext } from "../myContext";
import { FileResponse } from "../utils/global/globalInput";
import { User } from "../entities/User";
import { isAuth } from "../middleware/isAuth";
import { uploadFileProcess } from "../utils/global/uploadImage";
// import { likeProcess } from "../utils/like/likeProcess";
import { CaptionUserTag } from "../entities/CaptionUserTags";
import { UserTagInput } from "../utils/comment/commentInput";
import { PostView } from "../entities/PostView";

@Resolver(Post)
export class PostResolver {
	@FieldResolver(() => [CaptionUserTag])
  async userTags (
    @Root() post: Post,
		@Ctx() { captionUserTagsLoader }: MyContext
  ) {
		const dataLoaderRes = await captionUserTagsLoader.load(post.id);
		return dataLoaderRes ? dataLoaderRes : [];
  }

	@FieldResolver(() => Like)
  async likeState(
    @Root() post: Post,
		@Ctx() { likeLoader, userId }: MyContext
  ) {

		if (!userId || userId === undefined) {
      return null;
    }

		const like = await likeLoader.load({
      post_id: post.id,
      user_id: userId
    });

    return like ? true : false;
  }
	
  @FieldResolver(() => User)
  user(
    @Root() post: Post,
		@Ctx() { userLoader }: MyContext
  ) {
		if (post.user_id && !post.user) {
			return userLoader.load(post.user_id);
		} else {
			return post.user
		}
    // return userLoader.load(post.user_id);
  }

	@FieldResolver(() => FileResponse)
	file(
		@Root() post: Post,
		@Ctx() { fileLoader }: MyContext
	) {
		return fileLoader.load(post.file_key);
	}

	@FieldResolver(() => FileResponse)
	fileGif(
		@Root() post: Post,
		@Ctx() { fileLoader }: MyContext
	) {
		return fileLoader.load(post.fileGifKey);
	}

	@FieldResolver(() => FileResponse)
	fileImg(
		@Root() post: Post,
		@Ctx() { fileLoader }: MyContext
	) {
		return fileLoader.load(post.fileImgKey);
	}

	@Mutation(() => CreatePostResponse)
	@UseMiddleware(isAuth)
	async createPost(
		// @Arg("userId", () => Int) userId: number,
		@Arg("caption", () => String) caption: string,
		@Arg("fileDims", () => FileDimsInput) fileDims: FileDimsInput,
		@Arg("file", () => GraphQLUpload) file: FileUpload,
		@Arg("fileGif", () => GraphQLUpload) fileGif: FileUpload,
		@Arg("fileImg", () => GraphQLUpload) fileImg: FileUpload,
		@Arg("userTagsInput", () => [UserTagInput]) userTagsInput: UserTagInput[],
		@Arg("videogameId", () => Int, {nullable: true}) videogameId: number,
		@Arg("videogameGenreIds", () => [Int]) videogameGenreIds: number[],
		//@Arg("input", () => CreatePostInput) input: CreatePostInput,
		@Ctx() { userId }: MyContext
 	): Promise<CreatePostResponse> {

		// check is file is video or image
		const errors = await validatePost(caption, file);

		if (errors != null) {
			return {
				error: errors
			}
		}

		const randomString = uuidv4();

		const key = 'posts/' + randomString + '.mp4';
		const uploadFileResponse = await uploadFileProcess(file.createReadStream, key, file.mimetype);
		if (uploadFileResponse?.error) {
			return uploadFileResponse;
		}

		const gifKey = 'postsThumbnails/' + randomString + '.gif';
		const uploadFileGifResponse = await uploadFileProcess(fileGif.createReadStream, gifKey, fileGif.mimetype);
		if (uploadFileGifResponse?.error) {
			return uploadFileGifResponse;
		}

		const imgKey = 'postsImages/' + randomString + '.jpg';
		const uploadFileImgResponse = await uploadFileProcess(fileImg.createReadStream, imgKey, fileImg.mimetype);
		if (uploadFileImgResponse?.error) {
			return uploadFileImgResponse;
		}

		let error: boolean = false;

		let createdPost: any;

		const queryRunner = getConnection().createQueryRunner()
		await queryRunner.connect()

		await queryRunner.startTransaction();

		try {
			createdPost = await queryRunner.manager.query(`
				insert into post (caption, user_id, file_key, "fileGifKey", "fileImgKey", "fileWidth", "fileHeight", "videogame_id")
				values ($1, $2, $3, $4, $5, $6, $7, $8)
				returning *
			`, [caption, userId, key, gifKey, imgKey, fileDims.fileWidth, fileDims.fileHeight, videogameId]).catch((err) => {
				if (err) {
					error = true;
				}
			});

			for (let i = 0; i < userTagsInput.length; i++) {
				await queryRunner.manager.createQueryBuilder()
				.insert()
				.into(CaptionUserTag)
				.values({
					post_id: createdPost[0].id, 
					user_id: userTagsInput[i].userId, 
					user_string: userTagsInput[i].userString
				})
				.execute()
			}

			for (let i = 0; i < videogameGenreIds.length; i++) {
				await queryRunner.manager.query(`
					insert into "videogame_genre_post" ("videogame_genre_id", "post_id")
					values ($1, $2)
				`, [videogameGenreIds[i], createdPost[0].id])
			}

			await queryRunner.commitTransaction();
		} catch {
			await queryRunner.rollbackTransaction();
		} finally {
			await queryRunner.release();
		}

		await getConnection().createQueryBuilder()
		.update(Post)
		.set({
			id: createdPost[0].id
		})
		.where("id = :id", {id: createdPost[0].id})
		.execute()

		for (let i = 0; i < userTagsInput.length; i++) {
			await getConnection().createQueryBuilder()
			.update(CaptionUserTag)
			.set({
				post_id: createdPost[0].id,
				user_id: userTagsInput[i].userId,
				user_string: userTagsInput[i].userString
			})
			.where("post_id = :post_id and user_id = :user_id and user_string = :user_string", {
				post_id: createdPost[0].id,
				user_id: userTagsInput[i].userId,
				user_string: userTagsInput[i].userString
			})
			.execute()
		}

		if (error) {
			return {
				error: {
					field: 'post',
					message: 'could not upload post'
				}
			};
		}

		console.log(createdPost);

		return {
			post: createdPost[0]
		}
	}

	@Query(() => PaginatedPosts)
	@UseMiddleware(isAuth)
	async posts(
    @Arg("limit", () => Int) limit: number,
		@Arg("idsList", () => [Int]) idsList: number[],
		@Ctx() { userId }: MyContext
  ): Promise<PaginatedPosts> {
    const realLimit = Math.min(15, limit);
    const realLimitLength = realLimit + 1;
  
    const cursorArray: any[] = [realLimitLength, userId, idsList];

		const posts = await getConnection().query(`
			select p.* from post p

			left join follow f -- users that i follow
				on (p.user_id = f."followingId")
				and (f."followerId" = $2)

			left join follow fb -- users that follow me and i follow them
				on (fb."followingId" = f."followerId")
				and (fb."followerId" = f."followingId")

			left join "like" l
				on 	(l.post_id = p.id)
				and (l.user_id = f."followingId")

			left join (
				select nvup.* from videogame_user_preferences nvup
				where nvup.user_id = $2
				order by nvup."likeCount" desc
				limit 5
			) vup
				on (vup.videogame_id = p.videogame_id)
				and (vup.user_id = $2)

			left join post_view pv
				on (pv.post_id = p.id) 
				and (pv.user_id = $2)

			where 
				-- p.user_id != $2
				-- and pv is null
				-- and (vup is not null or f2 is not null or (f is not null and fb is not null))
				-- and not (p.id = ANY($3))
				not (p.id = ANY($3))

			group by p.id, vup.*, l.*, f.*, fb.*
			order by (vup is not null or l is not null or fb is not null) desc, --(f is not null and fb is not null)
				((date_trunc('millisecond', (now() at time zone 'utc')) + interval '2' day) - (date_trunc('millisecond', (p."createdAt" at time zone 'utc')))) / greatest( (p."viewsCount" + 1), 1 ) asc 
			limit $1
    `, cursorArray);
		console.log(posts)
		
    return {
      posts: posts.slice(0, realLimit),
      hasMore: posts.length === realLimitLength
    };
	}

	@Query(() => PaginatedPosts)
	@UseMiddleware(isAuth)
	async followingPosts(
    @Arg("limit", () => Int) limit: number,
		@Arg("idsList", () => [Int]) idsList: number[],
		@Ctx() { userId }: MyContext
  ): Promise<PaginatedPosts> {
    const realLimit = Math.min(20, limit);
    const realLimitLength = realLimit + 1;
  
    const cursorArray: any[] = [realLimitLength, userId, idsList];

    const posts = await getConnection().query(`
      select p.* from post p

			left join "follow" f 
				on p.user_id = f."followingId"
				and f."followerId" = $2

			left join "like" l
				on (l.post_id = p.id)
				and (l.user_id = f."followingId")

			left join (
				select * from videogame_user_preferences nvup
				where nvup.user_id = $2
				order by nvup."likeCount" desc
				limit 5
			) vup
				on (vup.videogame_id = p.videogame_id)
				and (vup.user_id = $2)

			left join post_view pv
				on (pv.post_id = p.id)
				and (pv.user_id = $2)
				
			where 
				p.user_id != $2
				-- and pv is null
				and (f is not null)
				and not (p.id = ANY($3))
			
			group by p.id, l.*, vup.*, pv.*
			order by (pv is null) desc,
				(vup is not null or l is not null) desc,
				((date_trunc('millisecond', (now() at time zone 'utc')) + interval '2' day) - (date_trunc('millisecond', (p."createdAt" at time zone 'utc')))) / greatest( (p."viewsCount" + 1), 1 ) asc 
			limit $1
		`, cursorArray);
				// -- ${ cursor ? `and date_trunc('millisecond', (p."createdAt" at time zone 'utc')) < date_trunc('millisecond', ($3::timestamptz at time zone 'utc'))` : "" }

    return {
      posts: posts.slice(0, realLimit),
      hasMore: posts.length === realLimitLength
    };
	}

	@Query(() => PaginatedPosts)
	@UseMiddleware(isAuth)
	async videogamePosts(
    @Arg("limit", () => Int) limit: number,
		@Arg("videogameId", () => Int) videogameId: number,
		@Arg("idsList", () => [Int]) idsList: number[],
		@Ctx() { userId }: MyContext
  ): Promise<PaginatedPosts> {
    const realLimit = Math.min(20, limit);
    const realLimitLength = realLimit + 1;
  
    const cursorArray: any[] = [realLimitLength, userId, idsList, videogameId];
		
		const posts = await getConnection().query(`
			select p.* from post p

			left join "videogame" v 
				on p.videogame_id = v.id 
				and p.videogame_id = $4

			left join follow f
				on (p.user_id = f."followingId")
				and (f."followerId" = $2)

			left join follow fb 
				on (fb."followingId" = f."followerId")
				and (fb."followerId" = f."followingId")

			left join "like" l
				on 	(l.post_id = p.id)
				and (l.user_id = f."followingId")

			left join post_view pv
				on (pv.post_id = p.id) 
				and (pv.user_id = $2)

			where 
				p.user_id != $2
				and v is not null
				and pv is null
				and not (p.id = ANY($3))

			group by p.id, l.*, f.*, fb.*
			order by (l is not null or fb is not null) desc,
				((date_trunc('millisecond', (now() at time zone 'utc')) + interval '2' day) - (date_trunc('millisecond', (p."createdAt" at time zone 'utc')))) / greatest( (p."viewsCount" + 1), 1 ) asc 
			limit $1
    `, cursorArray);

    return {
      posts: posts.slice(0, realLimit),
      hasMore: posts.length === realLimitLength
    };
	}

	// like
	@Mutation(() => LikeResponse)
	@UseMiddleware(isAuth)
	async likeUnlikePost(
		@Arg("postId", () => Int) postId: number,
		@Arg("clientId") clientId: string,
		@Ctx() { userId }: MyContext
	): Promise<LikeResponse> {

		const postExists = await Post.findOne({where: {
			id: postId,
		}}); 

		if (!postExists) {
			return {
				value: undefined,
				clientId: undefined
			}
		}

		const like = await Like.findOne({where: {
			user_id: userId,
			post_id: postId
		}});
		// await likeProcess(
		// 	userHasLike != undefined, userId!, postId, "post", "like"
		// );
		if (!like) {
			await getConnection().createQueryBuilder()
			.insert()
			.into(Like)
			.values({ user_id: userId, post_id: postId })
			.execute()
			console.log("like");
		} else {
			await Like.remove(like);
			console.log("unlike");
		}

		return {
			value: like ? -1 : 1,
			clientId: clientId,
		};
	}

	@Query(() => PaginatedPosts)
	@UseMiddleware(isAuth)
	async userPosts(
		@Arg("userId", () => Int) userId: number,
		@Arg("limit", () => Int) limit: number,
		@Arg("cursor", () => String, {nullable: true}) cursor: string,
	) {
		const realLimit = Math.min(10, limit);
    const realLimitLength = realLimit + 1;
  
    const cursorArray: any[] = [userId, realLimitLength];

    if (cursor) {
      cursorArray.push(new Date(parseInt(cursor)))
    }

		console.log(cursor);

    const posts = await getConnection().query(`
      select p.* from post p 
			where p.user_id = $1
      ${ cursor ? `and date_trunc('millisecond', (p."createdAt" at time zone 'utc')) < date_trunc('millisecond', ($3::timestamptz at time zone 'utc'))` : "" }
      order by p."createdAt" DESC
      limit $2
    `, cursorArray);

		// console.log("aaaaa");

		// console.log(posts.length);

		// console.log(realLimitLength)

		// console.log(posts.length === realLimitLength);

    return {
      posts: posts.slice(0, realLimit),
      hasMore: posts.length === realLimitLength
    };
	}

	@Mutation(() => Boolean)
	@UseMiddleware(isAuth)
	async viewClip(
		@Arg("postId", () => Int) postId: number,
		@Ctx() { userId }: MyContext
	) {
		const postView = await PostView.findOne({
			where: {
				user_id: userId,
				post_id: postId
			}
		});

		try {
			if (postView) {
				const postInfo = await Post.findOne({where: {id: postId}});
				if (postInfo) {
					await getConnection().transaction(async tm => {
						await Post.update(postId, {
							id: postId,
							viewsCount: postInfo.viewsCount + 1,
						});

						await tm.createQueryBuilder()
						.update(PostView)
						.set({ user_id: userId, post_id: postId })
						.where("user_id = :user_id and post_id = :post_id", 
							{ user_id: userId, post_id: postId }
						)
						.execute();
					});
				}
			} else {
				await getConnection().transaction(async (tm) => {
					const postInfo = await Post.findOne({where: {id: postId}});
					await tm.createQueryBuilder()
        		.insert()
						.into(PostView)
						.values({ user_id: userId, post_id: postId })
						.execute().catch((_) => {
							// console.log(err);
						});
					// await tm.query(`
					// 	insert into "post_view" (post_id, user_id)
					// 	values ($1, $2)
					// `, [postId, userId]);
					if (postInfo) {
						await Post.update(postId, {
							id: postId,
							viewsCount: postInfo.viewsCount + 1,
						});
					}
				})
			}
		} catch(e) {
			return false
		}

		return true;
	}

	// @Mutation(() => Boolean)

	@Query(() => [Post])
	// @UseMiddleware(isAuth)
	async getAllPosts() {
		const posts = await Post.find({});
		return posts;
	}

	@Mutation(() => Boolean)
	@UseMiddleware(isAuth)
	async deletePost(
		@Arg("postId", () => Int) postId: number,
		@Ctx() { userId }: MyContext
	) {
		
		const post = await Post.findOne({where: {
			id: postId,
		}});

		console.log(post);

		if (post!) {
			if (post.user_id === parseInt(userId!.toString())) {
				await Post.remove(post);
				// console.log("removed");
				return true;
			}
			return false;
		}

		return false;
	}

	@Query(() => Post, {nullable: true})
	@UseMiddleware(isAuth)
	async singlePost(
		@Arg("id", () => Int) id: number
	) {
		const post = await Post.findOne({
			where: {
				id: id
			}
		});

		return post;
	}
}