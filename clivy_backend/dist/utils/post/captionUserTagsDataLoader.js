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
exports.captionUserTagsDataLoader = void 0;
const dataloader_1 = __importDefault(require("dataloader"));
const typeorm_1 = require("typeorm");
const captionUserTagsDataLoader = () => new dataloader_1.default((captionIds) => __awaiter(void 0, void 0, void 0, function* () {
    const userTags = yield (0, typeorm_1.getConnection)().query(`
    SELECT post_id, 
      JSON_AGG(ROW_TO_JSON("caption_user_tag")) as row
    FROM "caption_user_tag"
    WHERE post_id = ANY($1)
    GROUP BY post_id
  `, [captionIds]);
    const userTagsMap = {};
    for (let i = 0; i < userTags.length; i++) {
        const captionId = userTags[i].post_id;
        userTagsMap[captionId] = userTags[i].row;
    }
    return captionIds.map(captionId => userTagsMap[captionId]);
}));
exports.captionUserTagsDataLoader = captionUserTagsDataLoader;
//# sourceMappingURL=captionUserTagsDataLoader.js.map