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
exports.CommentResolver = exports.CommentUserTagResolver = void 0;
const type_graphql_1 = require("type-graphql");
const Comments_1 = require("../entities/Comments");
const isAuth_1 = require("../middleware/isAuth");
const typeorm_1 = require("typeorm");
const commentInput_1 = require("../utils/comment/commentInput");
const User_1 = require("../entities/User");
const postInput_1 = require("../utils/post/postInput");
const CommentLike_1 = require("../entities/CommentLike");
const CommentUserTags_1 = require("../entities/CommentUserTags");
const Post_1 = require("../entities/Post");
const Reply_1 = require("../entities/Reply");
let CommentUserTagResolver = class CommentUserTagResolver {
    user(commentUserTag, { userLoader }) {
        return __awaiter(this, void 0, void 0, function* () {
            return userLoader.load(commentUserTag.user_id);
        });
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => [CommentUserTags_1.CommentUserTag]),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [CommentUserTags_1.CommentUserTag, Object]),
    __metadata("design:returntype", Promise)
], CommentUserTagResolver.prototype, "user", null);
CommentUserTagResolver = __decorate([
    (0, type_graphql_1.Resolver)(CommentUserTags_1.CommentUserTag)
], CommentUserTagResolver);
exports.CommentUserTagResolver = CommentUserTagResolver;
let CommentResolver = class CommentResolver {
    userTags(comment, { commentUserTagsLoader }) {
        return __awaiter(this, void 0, void 0, function* () {
            const dataLoaderRes = yield commentUserTagsLoader.load(comment.id);
            return dataLoaderRes ? dataLoaderRes : [];
        });
    }
    likeState(comment, { commentLikeLoader, userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!userId || userId === undefined) {
                return null;
            }
            const like = yield commentLikeLoader.load({
                comment_id: comment.id,
                user_id: userId
            });
            console.log(like);
            return like ? true : false;
        });
    }
    user(comment, { userLoader }) {
        return __awaiter(this, void 0, void 0, function* () {
            if (comment.user_id && !comment.user) {
                return userLoader.load(comment.user_id);
            }
            else {
                return comment.user;
            }
        });
    }
    commentPost(postId, comment, userTagsInput, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            let postExists = true;
            let newComment;
            const queryRunner = (0, typeorm_1.getConnection)().createQueryRunner();
            yield queryRunner.connect();
            const post = yield Post_1.Post.findOne({
                where: { id: postId }
            });
            if (!post) {
                postExists = false;
                if (!postExists) {
                    return {
                        error: true
                    };
                }
            }
            yield queryRunner.startTransaction();
            try {
                console.log("a");
                newComment = yield queryRunner.manager.createQueryBuilder()
                    .insert()
                    .into(Comments_1.Comment)
                    .values({ post_id: postId, user_id: userId, comment: comment })
                    .returning("*")
                    .execute();
                for (let i = 0; i < userTagsInput.length; i++) {
                    yield queryRunner.manager.createQueryBuilder()
                        .insert()
                        .into(CommentUserTags_1.CommentUserTag)
                        .values({
                        comment_id: newComment.raw[0].id,
                        user_id: userTagsInput[i].userId,
                        user_string: userTagsInput[i].userString
                    })
                        .execute();
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
                .update(Comments_1.Comment)
                .set({
                id: newComment.raw[0].id
            })
                .where("id = :id", { id: newComment.raw[0].id })
                .execute();
            for (let i = 0; i < userTagsInput.length; i++) {
                yield (0, typeorm_1.getConnection)().createQueryBuilder()
                    .update(CommentUserTags_1.CommentUserTag)
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
                    .execute();
            }
            return {
                postId: postId,
                comment: newComment.raw[0]
            };
        });
    }
    comments(limit, postId, idsList, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const realLimit = Math.min(20, limit);
            const realLimitLength = realLimit + 1;
            const cursorArray = [realLimitLength, postId, userId, idsList];
            const comments = yield (0, typeorm_1.getConnection)().query(`
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
        });
    }
    likeUnlikeComment(commentId, clientId, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const commentExists = yield Comments_1.Comment.findOne({ where: {
                    id: commentId,
                } });
            if (!commentExists) {
                return {
                    value: undefined
                };
            }
            const like = yield CommentLike_1.CommentLike.findOne({ where: {
                    user_id: userId,
                    comment_id: commentId
                } });
            if (!like) {
                yield (0, typeorm_1.getConnection)().createQueryBuilder()
                    .insert()
                    .into(CommentLike_1.CommentLike)
                    .values({ user_id: userId, comment_id: commentId })
                    .execute();
            }
            else {
                yield CommentLike_1.CommentLike.remove(like);
            }
            return {
                value: like ? -1 : 1,
                clientId: clientId
            };
        });
    }
    deleteComment(commentId, isReply, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            console.log("hello there");
            let comment;
            if (isReply) {
                comment = yield Reply_1.Reply.findOne({ where: {
                        id: commentId,
                    } });
            }
            else {
                comment = yield Comments_1.Comment.findOne({ where: {
                        id: commentId,
                    } });
            }
            if (comment !== undefined) {
                if (comment.user_id === parseInt(userId.toString())) {
                    if (isReply) {
                        yield Reply_1.Reply.remove(comment);
                    }
                    else {
                        yield Comments_1.Comment.remove(comment);
                    }
                    return true;
                }
                return false;
            }
            return false;
        });
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => [CommentUserTags_1.CommentUserTag]),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Comments_1.Comment, Object]),
    __metadata("design:returntype", Promise)
], CommentResolver.prototype, "userTags", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => CommentLike_1.CommentLike),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Comments_1.Comment, Object]),
    __metadata("design:returntype", Promise)
], CommentResolver.prototype, "likeState", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => User_1.User),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Comments_1.Comment, Object]),
    __metadata("design:returntype", Promise)
], CommentResolver.prototype, "user", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => commentInput_1.CreateCommentResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("postId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("comment", () => String)),
    __param(2, (0, type_graphql_1.Arg)("userTagsInput", () => [commentInput_1.UserTagInput])),
    __param(3, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, String, Array, Object]),
    __metadata("design:returntype", Promise)
], CommentResolver.prototype, "commentPost", null);
__decorate([
    (0, type_graphql_1.Query)(() => commentInput_1.CommentResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("limit", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("postId", () => type_graphql_1.Int)),
    __param(2, (0, type_graphql_1.Arg)("idsList", () => [type_graphql_1.Int])),
    __param(3, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number, Array, Object]),
    __metadata("design:returntype", Promise)
], CommentResolver.prototype, "comments", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => postInput_1.LikeResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("commentId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("clientId")),
    __param(2, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, String, Object]),
    __metadata("design:returntype", Promise)
], CommentResolver.prototype, "likeUnlikeComment", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("commentId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("isReply", () => Boolean)),
    __param(2, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Boolean, Object]),
    __metadata("design:returntype", Promise)
], CommentResolver.prototype, "deleteComment", null);
CommentResolver = __decorate([
    (0, type_graphql_1.Resolver)(Comments_1.Comment)
], CommentResolver);
exports.CommentResolver = CommentResolver;
//# sourceMappingURL=comment.js.map