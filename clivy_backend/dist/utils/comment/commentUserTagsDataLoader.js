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
exports.replyUserTagsDataLoader = exports.commentUserTagsDataLoader = void 0;
const dataloader_1 = __importDefault(require("dataloader"));
const typeorm_1 = require("typeorm");
const commentUserTagsDataLoader = () => new dataloader_1.default((commentIds) => __awaiter(void 0, void 0, void 0, function* () {
    const userTags = yield (0, typeorm_1.getConnection)().query(`
    SELECT comment_id, 
      JSON_AGG(ROW_TO_JSON("comment_user_tag")) as row
    FROM "comment_user_tag"
    WHERE comment_id = ANY($1)
    GROUP BY comment_id
  `, [commentIds]);
    const userTagsMap = {};
    for (let i = 0; i < userTags.length; i++) {
        const commentId = userTags[i].comment_id;
        userTagsMap[commentId] = userTags[i].row;
    }
    return commentIds.map(commentId => userTagsMap[commentId]);
}));
exports.commentUserTagsDataLoader = commentUserTagsDataLoader;
const replyUserTagsDataLoader = () => new dataloader_1.default((replyIds) => __awaiter(void 0, void 0, void 0, function* () {
    const userTags = yield (0, typeorm_1.getConnection)().query(`
    SELECT reply_id, 
      JSON_AGG(ROW_TO_JSON("reply_user_tag")) as row
    FROM "reply_user_tag"
    WHERE reply_id = ANY($1)
    GROUP BY reply_id
  `, [replyIds]);
    const userTagsMap = {};
    for (let i = 0; i < userTags.length; i++) {
        const replyId = userTags[i].reply_id;
        userTagsMap[replyId] = userTags[i].row;
    }
    return replyIds.map(replyId => userTagsMap[replyId]);
}));
exports.replyUserTagsDataLoader = replyUserTagsDataLoader;
//# sourceMappingURL=commentUserTagsDataLoader.js.map