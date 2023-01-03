import { getConnection } from "typeorm";
import { DeviceToken, Platforms } from "../../entities/DeviceToken";
import { User } from "../../entities/User";
import { createTokens } from "../global/createTokens";
import { DeviceInput } from "../global/globalInput";

export const signInFunc = async (user: User, deviceInput: DeviceInput) => {

  if (deviceInput.deviceToken) {
    console.log(deviceInput.deviceToken);
    const deviceToken = await DeviceToken.findOne({where: {
      token: deviceInput.deviceToken,
      user_id: user!.id, 
    }});
    if (!deviceToken) {
      await getConnection().query(`
        insert into "device_token" ("user_id", "token", "platform")
        values ($1, $2, $3)
      `, [
        user!.id,
        deviceInput.deviceToken,
        deviceInput.platformIsIOS == true
          ? Platforms.iOS
          : Platforms.Android
      ]);
    }
  }

  const payload = {
    id: `${(user as User).id}`,
    username: (user as User).username,
    roles: ['user'],
  }

  const {accessToken, refreshToken} = await createTokens(payload);

  return {
    accessToken: accessToken,
    refreshToken: refreshToken,
  }
}