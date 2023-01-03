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
exports.signInFunc = void 0;
const typeorm_1 = require("typeorm");
const DeviceToken_1 = require("../../entities/DeviceToken");
const createTokens_1 = require("../global/createTokens");
const signInFunc = (user, deviceInput) => __awaiter(void 0, void 0, void 0, function* () {
    if (deviceInput.deviceToken) {
        console.log(deviceInput.deviceToken);
        const deviceToken = yield DeviceToken_1.DeviceToken.findOne({ where: {
                token: deviceInput.deviceToken,
                user_id: user.id,
            } });
        if (!deviceToken) {
            yield (0, typeorm_1.getConnection)().query(`
        insert into "device_token" ("user_id", "token", "platform")
        values ($1, $2, $3)
      `, [
                user.id,
                deviceInput.deviceToken,
                deviceInput.platformIsIOS == true
                    ? DeviceToken_1.Platforms.iOS
                    : DeviceToken_1.Platforms.Android
            ]);
        }
    }
    const payload = {
        id: `${user.id}`,
        username: user.username,
        roles: ['user'],
    };
    const { accessToken, refreshToken } = yield (0, createTokens_1.createTokens)(payload);
    return {
        accessToken: accessToken,
        refreshToken: refreshToken,
    };
});
exports.signInFunc = signInFunc;
//# sourceMappingURL=signIn.js.map