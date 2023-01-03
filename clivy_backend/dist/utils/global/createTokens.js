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
exports.createRefreshToken = exports.createAccessToken = exports.createTokens = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const fs_1 = __importDefault(require("fs"));
const createTokens = (payload) => __awaiter(void 0, void 0, void 0, function* () {
    const ACCESS_PRIVATE_KEY = fs_1.default.readFileSync('jwt_keys/access_jwt_keys/rsa_priv_a_key.pem', 'utf8');
    const REFRESH_PRIVATE_KEY = fs_1.default.readFileSync('jwt_keys/refresh_jwt_keys/rsa_r_priv_key.pem', 'utf8');
    const accessToken = yield (0, exports.createAccessToken)(payload, ACCESS_PRIVATE_KEY);
    const refreshToken = yield (0, exports.createRefreshToken)(payload, REFRESH_PRIVATE_KEY);
    return {
        accessToken: accessToken,
        refreshToken: refreshToken
    };
});
exports.createTokens = createTokens;
const createAccessToken = (payload, privateKey) => __awaiter(void 0, void 0, void 0, function* () {
    return jsonwebtoken_1.default.sign(payload, privateKey, { algorithm: 'RS256', expiresIn: 60 });
});
exports.createAccessToken = createAccessToken;
const createRefreshToken = (payload, privateKey) => __awaiter(void 0, void 0, void 0, function* () {
    return jsonwebtoken_1.default.sign(payload, privateKey, { algorithm: 'RS256', expiresIn: 60 * 60 * 24 * 7 });
});
exports.createRefreshToken = createRefreshToken;
//# sourceMappingURL=createTokens.js.map