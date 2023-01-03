import DataLoader from "dataloader";
import { CommentUserTag } from "../../entities/CommentUserTags";
import { ReplyUserTag } from "../../entities/ReplyUserTags";
import { getConnection } from "typeorm";

export const commentUserTagsDataLoader = () => new DataLoader<number, CommentUserTag[]>(async (commentIds) => {
  const userTags = await getConnection().query(`
    SELECT comment_id, 
      JSON_AGG(ROW_TO_JSON("comment_user_tag")) as row
    FROM "comment_user_tag"
    WHERE comment_id = ANY($1)
    GROUP BY comment_id
  `, [commentIds as number[]]);

	const userTagsMap: Record<number, CommentUserTag[]> = {};

  for (let i = 0; i < userTags.length; i++) {
    const commentId: number = userTags[i].comment_id
    userTagsMap[commentId] = userTags[i].row as CommentUserTag[];
  }
  
	return commentIds.map(commentId => userTagsMap[commentId]);
});

export const replyUserTagsDataLoader = () => new DataLoader<number, ReplyUserTag[]>(async (replyIds) => {
  const userTags = await getConnection().query(`
    SELECT reply_id, 
      JSON_AGG(ROW_TO_JSON("reply_user_tag")) as row
    FROM "reply_user_tag"
    WHERE reply_id = ANY($1)
    GROUP BY reply_id
  `, [replyIds as number[]]);

  const userTagsMap: Record<number, ReplyUserTag[]> = {};

  for (let i = 0; i < userTags.length; i++) {
    const replyId: number = userTags[i].reply_id
    userTagsMap[replyId] = userTags[i].row as ReplyUserTag[];
  }
  
	return replyIds.map(replyId => userTagsMap[replyId]);
});