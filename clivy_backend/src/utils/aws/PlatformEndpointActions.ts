import AWS from "aws-sdk";

export const createPlatformEndpoint = async (token: string): Promise<string | undefined> => {
  // AWS.config.update({region: 'us-east-1'});
  var sns = new AWS.SNS();

  const applicationPlatformARN: string = "";

  let endpointArn: string | undefined

  await sns.createPlatformEndpoint({
    PlatformApplicationArn: applicationPlatformARN,
    Token: token
  }, (err, data) => {
    console.log(err)
    if (!err) {
      endpointArn = data.EndpointArn
      console.log(data.EndpointArn)
    }
  })

  return endpointArn;
}

export const deletePlatformEndpoint = async (endpointARN: string) => {
  var sns = new AWS.SNS();

  await sns.deleteEndpoint({
    EndpointArn: endpointARN
  }, async (err) => {
    if (err) {
      console.log
    }
  })
}