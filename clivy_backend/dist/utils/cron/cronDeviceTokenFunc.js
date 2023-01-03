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
exports.cronDeviceTokenFunc = void 0;
const typeorm_1 = require("typeorm");
const publishNotification_1 = require("../aws/publishNotification");
const cronDeviceTokenFunc = () => __awaiter(void 0, void 0, void 0, function* () {
    const deviceTokens = yield (0, typeorm_1.getConnection)().query(`
    select * from device_token dt
    where mod(
      round(
        extract(
          hour from (date_trunc('millisecond', (now() at time zone 'utc')) - date_trunc('millisecond', (dt."createdAt" at time zone 'utc')))
        )
      ) :: int, 
      336
    ) = 0 or mod(
      round(
        extract(
          hour from (date_trunc('millisecond', (now() at time zone 'utc')) - date_trunc('millisecond', (dt."createdAt" at time zone 'utc')))
        )
      ) :: int, 
      335
    ) = 0 or mod(
      round(
        extract(
          hour from (date_trunc('millisecond', (now() at time zone 'utc')) - date_trunc('millisecond', (dt."createdAt" at time zone 'utc')))
        )
      ) :: int, 
      334
    ) = 0 or mod(
      round(
        extract(
          hour from (date_trunc('millisecond', (now() at time zone 'utc')) - date_trunc('millisecond', (dt."createdAt" at time zone 'utc')))
        )
      ) :: int, 
      333
    ) = 0 or mod(
      round(
        extract(
          hour from (date_trunc('millisecond', (now() at time zone 'utc')) - date_trunc('millisecond', (dt."createdAt" at time zone 'utc')))
        )
      ) :: int, 
      332
    ) = 0 or mod(
      round(
        extract(
          hour from (date_trunc('millisecond', (now() at time zone 'utc')) - date_trunc('millisecond', (dt."createdAt" at time zone 'utc')))
        )
      ) :: int, 
      331
    ) = 0 or mod(
      round(
        extract(
          hour from (date_trunc('millisecond', (now() at time zone 'utc')) - date_trunc('millisecond', (dt."createdAt" at time zone 'utc')))
        )
      ) :: int, 
      330
    ) = 0 or mod(
      round(
        extract(
          hour from (date_trunc('millisecond', (now() at time zone 'utc')) - date_trunc('millisecond', (dt."createdAt" at time zone 'utc')))
        )
      ) :: int, 
      329
    ) = 0
  `);
    for (var i = 0; i < deviceTokens.length; i++) {
        const deviceToken = deviceTokens[i];
        const payload = {
            "aps": {
                "content-available": 1,
            }
        };
        const res = yield (0, publishNotification_1.publishNotification)(payload, deviceToken.token, deviceToken.platform == 'iOS');
        if (res === true) {
            yield (0, typeorm_1.getConnection)().query(`
        delete device_token
        where user_id = $1 and token = $2
      `, [deviceToken.user_id, deviceToken.token]);
        }
    }
});
exports.cronDeviceTokenFunc = cronDeviceTokenFunc;
//# sourceMappingURL=cronDeviceTokenFunc.js.map