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
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkBlacklist = void 0;
const checkBlacklist = (redis, token) => __awaiter(void 0, void 0, void 0, function* () {
    let redisError = false;
    let redisToken = null;
    yield redis.get(token, (err, result) => {
        if (err || (typeof result) === null) {
            redisError = true;
            redisToken = null;
        }
        else {
            redisToken = result;
        }
    });
    if (!redisError && redisToken !== null) {
        return null;
    }
    return true;
});
exports.checkBlacklist = checkBlacklist;
//# sourceMappingURL=checkBlackList.js.map