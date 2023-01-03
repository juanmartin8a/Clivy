import { DeviceToken } from "../../entities/DeviceToken";
import { getConnection } from "typeorm"
import { publishNotification } from "../aws/publishNotification";

export const cronDeviceTokenFunc = async () => {
  const deviceTokens = await getConnection().query(`
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
    const deviceToken: DeviceToken = deviceTokens[i];
    const payload: Object = {
      "aps": {
        "content-available": 1,
      }
    }
    const res = await publishNotification(
      payload, deviceToken.token, deviceToken.platform == 'iOS'
    );
    if (res === true) {
      await getConnection().query(`
        delete device_token
        where user_id = $1 and token = $2
      `, [deviceToken.user_id, deviceToken.token])
    }
  }
}