import DataLoader from "dataloader";
import { CaptionUserTag } from "../../entities/CaptionUserTags";
import { getConnection } from "typeorm";

export const captionUserTagsDataLoader = () => new DataLoader<number, CaptionUserTag[]>(async (captionIds) => {
  const userTags = await getConnection().query(`
    SELECT post_id, 
      JSON_AGG(ROW_TO_JSON("caption_user_tag")) as row
    FROM "caption_user_tag"
    WHERE post_id = ANY($1)
    GROUP BY post_id
  `, [captionIds as number[]]);

	const userTagsMap: Record<number, CaptionUserTag[]> = {};

  for (let i = 0; i < userTags.length; i++) {
    const captionId: number = userTags[i].post_id;
    userTagsMap[captionId] = userTags[i].row as CaptionUserTag[];
  }
  
	return captionIds.map(captionId => userTagsMap[captionId]);
});