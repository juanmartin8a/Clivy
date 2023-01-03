import DataLoader from "dataloader";
import { CommentLike } from "../../entities/CommentLike";
import { ReplyLike } from "../../entities/ReplyLike";
import { Like } from "../../entities/Like";


export const likeDataLoader = () => new DataLoader<{post_id: number, user_id: number}, Like | null>(async (keys) => {
  const likes = await Like.findByIds(keys as any);

	const likesMap: Record<string, Like> = {};

	likes.forEach((like) => {
		likesMap[`${like.user_id}|${like.post_id}`] = like;
	});

	return keys.map(key => likesMap[`${key.user_id}|${key.post_id}`]);
});

export const commentLikeDataLoader = () => new DataLoader<{comment_id: number, user_id: number}, CommentLike | null>(async (keys) => {
  const likes = await CommentLike.findByIds(keys as any);

	const likesMap: Record<string, CommentLike> = {};

	likes.forEach((like) => {
		likesMap[`${like.user_id}|${like.comment_id}`] = like;
	});

	return keys.map(key => likesMap[`${key.user_id}|${key.comment_id}`]);
});

export const replyLikeDataLoader = () => new DataLoader<{reply_id: number, user_id: number}, ReplyLike | null>(async (keys) => {
  const likes = await ReplyLike.findByIds(keys as any);

	const likesMap: Record<string, ReplyLike> = {};

	likes.forEach((like) => {
		likesMap[`${like.user_id}|${like.reply_id}`] = like;
	});

	return keys.map(key => likesMap[`${key.user_id}|${key.reply_id}`]);
});