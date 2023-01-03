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
exports.getUserPayloadFromToken = exports.getUserIdFromToken = exports.getUserFromToken = void 0;
const checkBlackList_1 = require("../user/checkBlackList");
const verifyJWT_1 = require("../user/verifyJWT");
const getUserFromToken = (redis, token, forRefresh) => __awaiter(void 0, void 0, void 0, function* () {
    if (token !== undefined) {
        if (token === null) {
            return undefined;
        }
        const tokenList = token.split(' ');
        let realToken = '';
        if (tokenList[0] === 'Bearer') {
            realToken = tokenList[1];
        }
        else {
            realToken = tokenList[0];
        }
        const validateToken = yield (0, checkBlackList_1.checkBlacklist)(redis, realToken);
        if (validateToken === null) {
            return undefined;
        }
        const { error, payload } = yield (0, verifyJWT_1.verifyJWT)(realToken, forRefresh);
        if (error || payload === {} || (typeof payload) === undefined) {
            return undefined;
        }
        return payload;
    }
    return undefined;
});
exports.getUserFromToken = getUserFromToken;
const getUserIdFromToken = (redis, token) => __awaiter(void 0, void 0, void 0, function* () {
    if (token !== undefined) {
        const getUserPayload = yield (0, exports.getUserFromToken)(redis, token, false);
        if (getUserPayload === undefined) {
            return undefined;
        }
        return getUserPayload.id;
    }
    return undefined;
});
exports.getUserIdFromToken = getUserIdFromToken;
const getUserPayloadFromToken = (redis, token, forRefresh) => __awaiter(void 0, void 0, void 0, function* () {
    if (token !== undefined) {
        const getUserPayload = yield (0, exports.getUserFromToken)(redis, token, forRefresh);
        if (getUserPayload === undefined) {
            return undefined;
        }
        return getUserPayload;
    }
    return undefined;
});
exports.getUserPayloadFromToken = getUserPayloadFromToken;
//# sourceMappingURL=getUser.js.map