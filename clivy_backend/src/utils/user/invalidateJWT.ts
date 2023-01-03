import { Object } from "aws-sdk/clients/s3";
import { Redis } from "ioredis";


export const invalidateJWT = async (redis: Redis, payload: Object, token: string) => {
  const currentTime = Date.now();
	const timeBeforeExpire = (payload as any).exp - (currentTime / 1000);
	if (Math.sign(timeBeforeExpire) !== -1) {
		await redis.set(`${token}`, `${token}`, 'EX', Math.round(timeBeforeExpire));
	}
}