import { Redis } from "ioredis";
import { checkBlacklist } from "../user/checkBlackList";
import { verifyJWT } from "../user/verifyJWT";

export const getUserFromToken = async (redis: Redis, token?: string, forRefresh?: boolean) => {
	if (token !== undefined) {
    // console.log('token is: ' + token);
		if (token === null) {
      return undefined;
    }

    const tokenList: string[] = token.split(' ');
    let realToken: string = '';

    if (tokenList[0] === 'Bearer') {
      realToken = tokenList[1];
    } else {
      realToken = tokenList[0];
    }

    const validateToken = await checkBlacklist(redis, realToken);

    if (validateToken === null) {
      return undefined;
    }

		const { error, payload } = await verifyJWT(realToken, forRefresh!);
		
    if (error || payload === {} || (typeof payload) === undefined) {
      return undefined;
    }

		return payload;
	}

	return undefined;
}

export const getUserIdFromToken = async (redis: Redis, token?: string) => {
  if (token !== undefined) {
    const getUserPayload = await getUserFromToken(redis, token, false);
    
    if (getUserPayload === undefined) {
      return undefined;
    }

    return (getUserPayload as any).id as number;
  }
  return undefined;
}

export const getUserPayloadFromToken = async (redis: Redis, token?: string, forRefresh?: boolean) => {
  if (token !== undefined) {
    const getUserPayload = await getUserFromToken(redis, token, forRefresh);

    if (getUserPayload === undefined) {
      return undefined
    }

    return getUserPayload;
  }
  return undefined
}