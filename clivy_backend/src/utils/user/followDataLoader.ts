import DataLoader from "dataloader";
import { Follow } from "../../entities/Follow";

export const followDataLoader = () => new DataLoader<{followerId: number, followingId: number}, Follow | null>( async (keys) => {
  const follows = await Follow.findByIds(keys as any);

  const likesMap: Record<string, Follow> = {};

	follows.forEach((follow) => {
		likesMap[`${follow.followerId}|${follow.followingId}`] = follow;
	});

	return keys.map(key => likesMap[`${key.followerId}|${key.followingId}`]);
})