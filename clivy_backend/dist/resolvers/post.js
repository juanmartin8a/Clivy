"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PostResolver = void 0;
const type_graphql_1 = require("type-graphql");
const typeorm_1 = require("typeorm");
const Post_1 = require("../entities/Post");
const postInput_1 = require("../utils/post/postInput");
const validateInput_1 = require("../utils/post/validateInput");
const uuid_1 = require("uuid");
const graphql_upload_1 = require("graphql-upload");
const Like_1 = require("../entities/Like");
const globalInput_1 = require("../utils/global/globalInput");
const User_1 = require("../entities/User");
const isAuth_1 = require("../middleware/isAuth");
const uploadImage_1 = require("../utils/global/uploadImage");
const CaptionUserTags_1 = require("../entities/CaptionUserTags");
const commentInput_1 = require("../utils/comment/commentInput");
const PostView_1 = require("../entities/PostView");
let PostResolver = class PostResolver {
    userTags(post, { captionUserTagsLoader }) {
        return __awaiter(this, void 0, void 0, function* () {
            const dataLoaderRes = yield captionUserTagsLoader.load(post.id);
            return dataLoaderRes ? dataLoaderRes : [];
        });
    }
    likeState(post, { likeLoader, userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!userId || userId === undefined) {
                return null;
            }
            const like = yield likeLoader.load({
                post_id: post.id,
                user_id: userId
            });
            return like ? true : false;
        });
    }
    user(post, { userLoader }) {
        if (post.user_id && !post.user) {
            return userLoader.load(post.user_id);
        }
        else {
            return post.user;
        }
    }
    file(post, { fileLoader }) {
        return fileLoader.load(post.file_key);
    }
    fileGif(post, { fileLoader }) {
        return fileLoader.load(post.fileGifKey);
    }
    fileImg(post, { fileLoader }) {
        return fileLoader.load(post.fileImgKey);
    }
    createPost(caption, fileDims, file, fileGif, fileImg, userTagsInput, videogameId, videogameGenreIds, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const errors = yield (0, validateInput_1.validatePost)(caption, file);
            if (errors != null) {
                return {
                    error: errors
                };
            }
            const randomString = (0, uuid_1.v4)();
            const key = 'posts/' + randomString + '.mp4';
            const uploadFileResponse = yield (0, uploadImage_1.uploadFileProcess)(file.createReadStream, key, file.mimetype);
            if (uploadFileResponse === null || uploadFileResponse === void 0 ? void 0 : uploadFileResponse.error) {
                return uploadFileResponse;
            }
            const gifKey = 'postsThumbnails/' + randomString + '.gif';
            const uploadFileGifResponse = yield (0, uploadImage_1.uploadFileProcess)(fileGif.createReadStream, gifKey, fileGif.mimetype);
            if (uploadFileGifResponse === null || uploadFileGifResponse === void 0 ? void 0 : uploadFileGifResponse.error) {
                return uploadFileGifResponse;
            }
            const imgKey = 'postsImages/' + randomString + '.jpg';
            const uploadFileImgResponse = yield (0, uploadImage_1.uploadFileProcess)(fileImg.createReadStream, imgKey, fileImg.mimetype);
            if (uploadFileImgResponse === null || uploadFileImgResponse === void 0 ? void 0 : uploadFileImgResponse.error) {
                return uploadFileImgResponse;
            }
            let error = false;
            let createdPost;
            const queryRunner = (0, typeorm_1.getConnection)().createQueryRunner();
            yield queryRunner.connect();
            yield queryRunner.startTransaction();
            try {
                createdPost = yield queryRunner.manager.query(`
				insert into post (caption, user_id, file_key, "fileGifKey", "fileImgKey", "fileWidth", "fileHeight", "videogame_id")
				values ($1, $2, $3, $4, $5, $6, $7, $8)
				returning *
			`, [caption, userId, key, gifKey, imgKey, fileDims.fileWidth, fileDims.fileHeight, videogameId]).catch((err) => {
                    if (err) {
                        error = true;
                    }
                });
                for (let i = 0; i < userTagsInput.length; i++) {
                    yield queryRunner.manager.createQueryBuilder()
                        .insert()
                        .into(CaptionUserTags_1.CaptionUserTag)
                        .values({
                        post_id: createdPost[0].id,
                        user_id: userTagsInput[i].userId,
                        user_string: userTagsInput[i].userString
                    })
                        .execute();
                }
                for (let i = 0; i < videogameGenreIds.length; i++) {
                    yield queryRunner.manager.query(`
					insert into "videogame_genre_post" ("videogame_genre_id", "post_id")
					values ($1, $2)
				`, [videogameGenreIds[i], createdPost[0].id]);
                }
                yield queryRunner.commitTransaction();
            }
            catch (_a) {
                yield queryRunner.rollbackTransaction();
            }
            finally {
                yield queryRunner.release();
            }
            yield (0, typeorm_1.getConnection)().createQueryBuilder()
                .update(Post_1.Post)
                .set({
                id: createdPost[0].id
            })
                .where("id = :id", { id: createdPost[0].id })
                .execute();
            for (let i = 0; i < userTagsInput.length; i++) {
                yield (0, typeorm_1.getConnection)().createQueryBuilder()
                    .update(CaptionUserTags_1.CaptionUserTag)
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
                    .execute();
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
            };
        });
    }
    posts(limit, idsList, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const realLimit = Math.min(15, limit);
            const realLimitLength = realLimit + 1;
            const cursorArray = [realLimitLength, userId, idsList];
            const posts = yield (0, typeorm_1.getConnection)().query(`
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
            console.log(posts);
            return {
                posts: posts.slice(0, realLimit),
                hasMore: posts.length === realLimitLength
            };
        });
    }
    followingPosts(limit, idsList, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const realLimit = Math.min(20, limit);
            const realLimitLength = realLimit + 1;
            const cursorArray = [realLimitLength, userId, idsList];
            const posts = yield (0, typeorm_1.getConnection)().query(`
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
            return {
                posts: posts.slice(0, realLimit),
                hasMore: posts.length === realLimitLength
            };
        });
    }
    videogamePosts(limit, videogameId, idsList, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const realLimit = Math.min(20, limit);
            const realLimitLength = realLimit + 1;
            const cursorArray = [realLimitLength, userId, idsList, videogameId];
            const posts = yield (0, typeorm_1.getConnection)().query(`
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
        });
    }
    likeUnlikePost(postId, clientId, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const postExists = yield Post_1.Post.findOne({ where: {
                    id: postId,
                } });
            if (!postExists) {
                return {
                    value: undefined,
                    clientId: undefined
                };
            }
            const like = yield Like_1.Like.findOne({ where: {
                    user_id: userId,
                    post_id: postId
                } });
            if (!like) {
                yield (0, typeorm_1.getConnection)().createQueryBuilder()
                    .insert()
                    .into(Like_1.Like)
                    .values({ user_id: userId, post_id: postId })
                    .execute();
                console.log("like");
            }
            else {
                yield Like_1.Like.remove(like);
                console.log("unlike");
            }
            return {
                value: like ? -1 : 1,
                clientId: clientId,
            };
        });
    }
    userPosts(userId, limit, cursor) {
        return __awaiter(this, void 0, void 0, function* () {
            const realLimit = Math.min(10, limit);
            const realLimitLength = realLimit + 1;
            const cursorArray = [userId, realLimitLength];
            if (cursor) {
                cursorArray.push(new Date(parseInt(cursor)));
            }
            console.log(cursor);
            const posts = yield (0, typeorm_1.getConnection)().query(`
      select p.* from post p 
			where p.user_id = $1
      ${cursor ? `and date_trunc('millisecond', (p."createdAt" at time zone 'utc')) < date_trunc('millisecond', ($3::timestamptz at time zone 'utc'))` : ""}
      order by p."createdAt" DESC
      limit $2
    `, cursorArray);
            return {
                posts: posts.slice(0, realLimit),
                hasMore: posts.length === realLimitLength
            };
        });
    }
    viewClip(postId, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const postView = yield PostView_1.PostView.findOne({
                where: {
                    user_id: userId,
                    post_id: postId
                }
            });
            try {
                if (postView) {
                    const postInfo = yield Post_1.Post.findOne({ where: { id: postId } });
                    if (postInfo) {
                        yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                            yield Post_1.Post.update(postId, {
                                id: postId,
                                viewsCount: postInfo.viewsCount + 1,
                            });
                            yield tm.createQueryBuilder()
                                .update(PostView_1.PostView)
                                .set({ user_id: userId, post_id: postId })
                                .where("user_id = :user_id and post_id = :post_id", { user_id: userId, post_id: postId })
                                .execute();
                        }));
                    }
                }
                else {
                    yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                        const postInfo = yield Post_1.Post.findOne({ where: { id: postId } });
                        yield tm.createQueryBuilder()
                            .insert()
                            .into(PostView_1.PostView)
                            .values({ user_id: userId, post_id: postId })
                            .execute().catch((_) => {
                        });
                        if (postInfo) {
                            yield Post_1.Post.update(postId, {
                                id: postId,
                                viewsCount: postInfo.viewsCount + 1,
                            });
                        }
                    }));
                }
            }
            catch (e) {
                return false;
            }
            return true;
        });
    }
    getAllPosts() {
        return __awaiter(this, void 0, void 0, function* () {
            const posts = yield Post_1.Post.find({});
            return posts;
        });
    }
    deletePost(postId, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const post = yield Post_1.Post.findOne({ where: {
                    id: postId,
                } });
            console.log(post);
            if (post) {
                if (post.user_id === parseInt(userId.toString())) {
                    yield Post_1.Post.remove(post);
                    return true;
                }
                return false;
            }
            return false;
        });
    }
    singlePost(id) {
        return __awaiter(this, void 0, void 0, function* () {
            const post = yield Post_1.Post.findOne({
                where: {
                    id: id
                }
            });
            return post;
        });
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => [CaptionUserTags_1.CaptionUserTag]),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Post_1.Post, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "userTags", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => Like_1.Like),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Post_1.Post, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "likeState", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => User_1.User),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Post_1.Post, Object]),
    __metadata("design:returntype", void 0)
], PostResolver.prototype, "user", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => globalInput_1.FileResponse),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Post_1.Post, Object]),
    __metadata("design:returntype", void 0)
], PostResolver.prototype, "file", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => globalInput_1.FileResponse),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Post_1.Post, Object]),
    __metadata("design:returntype", void 0)
], PostResolver.prototype, "fileGif", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => globalInput_1.FileResponse),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Post_1.Post, Object]),
    __metadata("design:returntype", void 0)
], PostResolver.prototype, "fileImg", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => postInput_1.CreatePostResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("caption", () => String)),
    __param(1, (0, type_graphql_1.Arg)("fileDims", () => postInput_1.FileDimsInput)),
    __param(2, (0, type_graphql_1.Arg)("file", () => graphql_upload_1.GraphQLUpload)),
    __param(3, (0, type_graphql_1.Arg)("fileGif", () => graphql_upload_1.GraphQLUpload)),
    __param(4, (0, type_graphql_1.Arg)("fileImg", () => graphql_upload_1.GraphQLUpload)),
    __param(5, (0, type_graphql_1.Arg)("userTagsInput", () => [commentInput_1.UserTagInput])),
    __param(6, (0, type_graphql_1.Arg)("videogameId", () => type_graphql_1.Int, { nullable: true })),
    __param(7, (0, type_graphql_1.Arg)("videogameGenreIds", () => [type_graphql_1.Int])),
    __param(8, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, postInput_1.FileDimsInput, Object, Object, Object, Array, Number, Array, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "createPost", null);
__decorate([
    (0, type_graphql_1.Query)(() => postInput_1.PaginatedPosts),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("limit", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("idsList", () => [type_graphql_1.Int])),
    __param(2, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Array, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "posts", null);
__decorate([
    (0, type_graphql_1.Query)(() => postInput_1.PaginatedPosts),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("limit", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("idsList", () => [type_graphql_1.Int])),
    __param(2, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Array, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "followingPosts", null);
__decorate([
    (0, type_graphql_1.Query)(() => postInput_1.PaginatedPosts),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("limit", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("videogameId", () => type_graphql_1.Int)),
    __param(2, (0, type_graphql_1.Arg)("idsList", () => [type_graphql_1.Int])),
    __param(3, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number, Array, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "videogamePosts", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => postInput_1.LikeResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("postId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("clientId")),
    __param(2, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, String, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "likeUnlikePost", null);
__decorate([
    (0, type_graphql_1.Query)(() => postInput_1.PaginatedPosts),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("userId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("limit", () => type_graphql_1.Int)),
    __param(2, (0, type_graphql_1.Arg)("cursor", () => String, { nullable: true })),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number, String]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "userPosts", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("postId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "viewClip", null);
__decorate([
    (0, type_graphql_1.Query)(() => [Post_1.Post]),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "getAllPosts", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("postId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Object]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "deletePost", null);
__decorate([
    (0, type_graphql_1.Query)(() => Post_1.Post, { nullable: true }),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("id", () => type_graphql_1.Int)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], PostResolver.prototype, "singlePost", null);
PostResolver = __decorate([
    (0, type_graphql_1.Resolver)(Post_1.Post)
], PostResolver);
exports.PostResolver = PostResolver;
//# sourceMappingURL=post.js.map