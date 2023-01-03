"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.replyLikeDataLoader = exports.commentLikeDataLoader = exports.likeDataLoader = void 0;
const dataloader_1 = __importDefault(require("dataloader"));
const CommentLike_1 = require("../../entities/CommentLike");
const ReplyLike_1 = require("../../entities/ReplyLike");
const Like_1 = require("../../entities/Like");
const likeDataLoader = () => new dataloader_1.default((keys) => __awaiter(void 0, void 0, void 0, function* () {
    const likes = yield Like_1.Like.findByIds(keys);
    const likesMap = {};
    likes.forEach((like) => {
        likesMap[`${like.user_id}|${like.post_id}`] = like;
    });
    return keys.map(key => likesMap[`${key.user_id}|${key.post_id}`]);
}));
exports.likeDataLoader = likeDataLoader;
const commentLikeDataLoader = () => new dataloader_1.default((keys) => __awaiter(void 0, void 0, void 0, function* () {
    const likes = yield CommentLike_1.CommentLike.findByIds(keys);
    const likesMap = {};
    likes.forEach((like) => {
        likesMap[`${like.user_id}|${like.comment_id}`] = like;
    });
    return keys.map(key => likesMap[`${key.user_id}|${key.comment_id}`]);
}));
exports.commentLikeDataLoader = commentLikeDataLoader;
const replyLikeDataLoader = () => new dataloader_1.default((keys) => __awaiter(void 0, void 0, void 0, function* () {
    const likes = yield ReplyLike_1.ReplyLike.findByIds(keys);
    const likesMap = {};
    likes.forEach((like) => {
        likesMap[`${like.user_id}|${like.reply_id}`] = like;
    });
    return keys.map(key => likesMap[`${key.user_id}|${key.reply_id}`]);
}));
exports.replyLikeDataLoader = replyLikeDataLoader;
//# sourceMappingURL=likeDataLoader.js.map