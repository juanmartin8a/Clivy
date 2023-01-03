import AWS from "aws-sdk";
import apn from 'apn';

export const publishNotification = async (
  rawPayload: Object, token: string, isIOS: boolean
): Promise<boolean> => {
  let tokenDoesNotExist: boolean = false;

  const pfxPath = "";

  const options = {
    pfx: pfxPath,
    passphrase: "",
    production: false,
  }
  
  const apnProvider = new apn.Provider(options)

  let notification = new apn.Notification()

  notification.rawPayload = rawPayload;

  await apnProvider.send(notification, [token]).then((result) => {
    if (result.failed[0] && result.failed[0].status === "410")  {
      tokenDoesNotExist = true;
    }
  });

  return tokenDoesNotExist;
}