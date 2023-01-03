import { Redis } from "ioredis";

export const checkBlacklist = async (redis: Redis, token: string) => {
  let redisError: boolean = false;
  let redisToken: (string | null) = null;

  await redis.get(token, (err, result) => {
    if (err || (typeof result) === null) {
      redisError = true
      redisToken = null
    } else {
      redisToken = result;
    }
  });

  if (!redisError && redisToken !== null) {
    return null;
  }

  return true;
}