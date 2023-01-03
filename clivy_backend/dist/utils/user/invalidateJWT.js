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
exports.invalidateJWT = void 0;
const invalidateJWT = (redis, payload, token) => __awaiter(void 0, void 0, void 0, function* () {
    const currentTime = Date.now();
    const timeBeforeExpire = payload.exp - (currentTime / 1000);
    if (Math.sign(timeBeforeExpire) !== -1) {
        yield redis.set(`${token}`, `${token}`, 'EX', Math.round(timeBeforeExpire));
    }
});
exports.invalidateJWT = invalidateJWT;
//# sourceMappingURL=invalidateJWT.js.map