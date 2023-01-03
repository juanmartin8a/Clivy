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
exports.isAuth = void 0;
const getUser_1 = require("../utils/main/getUser");
const User_1 = require("src/entities/User");
const isAuth = ({ context }, next) => __awaiter(void 0, void 0, void 0, function* () {
    const userIdFromToken = yield (0, getUser_1.getUserIdFromToken)(context.redis, context.req.headers.authorization);
    if (userIdFromToken === undefined) {
        throw new Error('Not Authenticated');
    }
    const user = yield User_1.User.findOne({ where: {
            id: userIdFromToken
        } });
    if (!user) {
        throw new Error('Not Authenticated');
    }
    return next();
});
exports.isAuth = isAuth;
//# sourceMappingURL=isAuth.js.map