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
exports.followDataLoader = void 0;
const dataloader_1 = __importDefault(require("dataloader"));
const Follow_1 = require("../../entities/Follow");
const followDataLoader = () => new dataloader_1.default((keys) => __awaiter(void 0, void 0, void 0, function* () {
    const follows = yield Follow_1.Follow.findByIds(keys);
    const likesMap = {};
    follows.forEach((follow) => {
        likesMap[`${follow.followerId}|${follow.followingId}`] = follow;
    });
    return keys.map(key => likesMap[`${key.followerId}|${key.followingId}`]);
}));
exports.followDataLoader = followDataLoader;
//# sourceMappingURL=followDataLoader.js.map