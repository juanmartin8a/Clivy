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
exports.verifyJWT = void 0;
const fs_1 = __importDefault(require("fs"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const verifyJWT = (token, forRefresh) => __awaiter(void 0, void 0, void 0, function* () {
    let PUBLIC_KEY;
    if (forRefresh) {
        PUBLIC_KEY = fs_1.default.readFileSync('jwt_keys/refresh_jwt_keys/rsa_r_pub_key.pem', 'utf8');
    }
    else {
        PUBLIC_KEY = fs_1.default.readFileSync('jwt_keys/access_jwt_keys/rsa_pub_a_key.pem', 'utf8');
    }
    let error = false;
    let payload = {};
    yield jsonwebtoken_1.default.verify(token, PUBLIC_KEY, { algorithms: ['RS256'] }, (err, result) => {
        if (err || (typeof result) === undefined) {
            error = true;
        }
        else {
            payload = result;
        }
    });
    return {
        error: error,
        payload: payload
    };
});
exports.verifyJWT = verifyJWT;
//# sourceMappingURL=verifyJWT.js.map