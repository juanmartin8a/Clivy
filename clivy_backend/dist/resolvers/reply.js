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
exports.ReplyResolver = exports.ReplyUserTagResolver = void 0;
const type_graphql_1 = require("type-graphql");
const isAuth_1 = require("../middleware/isAuth");
const typeorm_1 = require("typeorm");
const commentInput_1 = require("../utils/comment/commentInput");
const User_1 = require("../entities/User");
const Reply_1 = require("../entities/Reply");
const postInput_1 = require("../utils/post/postInput");
const ReplyLike_1 = require("../entities/ReplyLike");
const ReplyUserTags_1 = require("../entities/ReplyUserTags");
const Comments_1 = require("../entities/Comments");
let ReplyUserTagResolver = class ReplyUserTagResolver {
    user(replyUserTag, { userLoader }) {
        return __awaiter(this, void 0, void 0, function* () {
            return userLoader.load(replyUserTag.user_id);
        });
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => [ReplyUserTags_1.ReplyUserTag]),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [ReplyUserTags_1.ReplyUserTag, Object]),
    __metadata("design:returntype", Promise)
], ReplyUserTagResolver.prototype, "user", null);
ReplyUserTagResolver = __decorate([
    (0, type_graphql_1.Resolver)(ReplyUserTags_1.ReplyUserTag)
], ReplyUserTagResolver);
exports.ReplyUserTagResolver = ReplyUserTagResolver;
let ReplyResolver = class ReplyResolver {
    userTags(reply, { replyUserTagsLoader }) {
        return __awaiter(this, void 0, void 0, function* () {
            const dataLoaderRes = yield replyUserTagsLoader.load(reply.id);
            return dataLoaderRes ? dataLoaderRes : [];
        });
    }
    likeState(reply, { replyLikeLoader, userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!userId || userId === undefined) {
                return null;
            }
            const like = yield replyLikeLoader.load({
                reply_id: reply.id,
                user_id: userId
            });
            return like ? true : false;
        });
    }
    user(reply, { userLoader }) {
        return __awaiter(this, void 0, void 0, function* () {
            if (reply.user_id && !reply.user) {
                return userLoader.load(reply.user_id);
            }
            else {
                return reply.user;
            }
        });
    }
    replyComment(commentId, postId, reply, userTagsInput, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            let commentExists = true;
            let newReply;
            const queryRunner = (0, typeorm_1.getConnection)().createQueryRunner();
            yield queryRunner.connect();
            const comment = yield Comments_1.Comment.findOne({
                where: { id: commentId }
            });
            if (!comment) {
                commentExists = false;
                if (!commentExists) {
                    return {
                        error: true
                    };
                }
            }
            yield queryRunner.startTransaction();
            try {
                newReply = yield queryRunner.manager.createQueryBuilder()
                    .insert()
                    .into(Reply_1.Reply)
                    .values({ comment_id: commentId, post_id: postId, user_id: userId, reply: reply })
                    .returning("*")
                    .execute();
                for (let i = 0; i < userTagsInput.length; i++) {
                    yield queryRunner.manager.createQueryBuilder()
                        .insert()
                        .into(ReplyUserTags_1.ReplyUserTag)
                        .values({
                        reply_id: newReply.raw[0].id,
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
                .update(Reply_1.Reply)
                .set({
                id: newReply.raw[0].id
            })
                .where("id = :id", { id: newReply.raw[0].id })
                .execute();
            for (let i = 0; i < userTagsInput.length; i++) {
                yield (0, typeorm_1.getConnection)().createQueryBuilder()
                    .update(ReplyUserTags_1.ReplyUserTag)
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
                    .execute();
            }
            return {
                commentId: commentId,
                postId: postId,
                reply: newReply.raw[0]
            };
        });
    }
    commentReplies(limit, cursor, commentId, postId, idsList) {
        return __awaiter(this, void 0, void 0, function* () {
            const realLimit = Math.min(20, limit);
            const realLimitLength = realLimit + 1;
            const cursorArray = [commentId, realLimitLength, idsList];
            if (cursor) {
                cursorArray.push(new Date(parseInt(cursor)));
            }
            const replies = yield (0, typeorm_1.getConnection)().query(`
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
        });
    }
    likeUnlikeReply(replyId, clientId, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const replyExists = yield Reply_1.Reply.findOne({ where: {
                    id: replyId,
                } });
            if (!replyExists) {
                return {
                    value: undefined
                };
            }
            const like = yield ReplyLike_1.ReplyLike.findOne({ where: {
                    user_id: userId,
                    reply_id: replyId
                } });
            if (!like) {
                yield (0, typeorm_1.getConnection)().createQueryBuilder()
                    .insert()
                    .into(ReplyLike_1.ReplyLike)
                    .values({ user_id: userId, reply_id: replyId })
                    .execute();
            }
            else {
                yield ReplyLike_1.ReplyLike.remove(like);
            }
            return {
                value: like ? -1 : 1,
                clientId: clientId
            };
        });
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => [ReplyUserTags_1.ReplyUserTag]),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Reply_1.Reply, Object]),
    __metadata("design:returntype", Promise)
], ReplyResolver.prototype, "userTags", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => ReplyLike_1.ReplyLike),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Reply_1.Reply, Object]),
    __metadata("design:returntype", Promise)
], ReplyResolver.prototype, "likeState", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => [User_1.User]),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Reply_1.Reply, Object]),
    __metadata("design:returntype", Promise)
], ReplyResolver.prototype, "user", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => commentInput_1.CreateReplyResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("commentId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("postId", () => type_graphql_1.Int)),
    __param(2, (0, type_graphql_1.Arg)("reply", () => String)),
    __param(3, (0, type_graphql_1.Arg)("userTagsInput", () => [commentInput_1.UserTagInput])),
    __param(4, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number, String, Array, Object]),
    __metadata("design:returntype", Promise)
], ReplyResolver.prototype, "replyComment", null);
__decorate([
    (0, type_graphql_1.Query)(() => commentInput_1.ReplyResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("limit", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("cursor", () => String, { nullable: true })),
    __param(2, (0, type_graphql_1.Arg)("commentId", () => type_graphql_1.Int)),
    __param(3, (0, type_graphql_1.Arg)("postId", () => type_graphql_1.Int)),
    __param(4, (0, type_graphql_1.Arg)("idsList", () => [type_graphql_1.Int])),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, String, Number, Number, Array]),
    __metadata("design:returntype", Promise)
], ReplyResolver.prototype, "commentReplies", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => postInput_1.LikeResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("replyId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("clientId")),
    __param(2, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, String, Object]),
    __metadata("design:returntype", Promise)
], ReplyResolver.prototype, "likeUnlikeReply", null);
ReplyResolver = __decorate([
    (0, type_graphql_1.Resolver)(Reply_1.Reply)
], ReplyResolver);
exports.ReplyResolver = ReplyResolver;
//# sourceMappingURL=reply.js.map