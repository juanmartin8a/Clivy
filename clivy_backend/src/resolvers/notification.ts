import { LikeNotification } from "../entities/LikeNotification";
import { Arg, Ctx, Int, Query, Resolver, UseMiddleware } from "type-graphql";
import { Notification } from "../entities/Notification";
import { MyContext } from "../myContext";
import { getConnection } from "typeorm";
import { CommentLikeNotification } from "../entities/CommentLikeNotification";
import { ReplyLikeNotification } from "../entities/ReplyLikeNotification";
import { Reply } from "../entities/Reply";
import { Comment } from "../entities/Comments";
// import { ReplyLike } from "../entities/ReplyLike";
import { User } from "../entities/User";
import { Post } from "../entities/Post";
import { FollowNotification } from "../entities/FollowNotification";
import { CommentNotification } from "../entities/CommentNotification";
import { ReplyNotification } from "../entities/ReplyNotification";
import { CommentTagNotification } from "../entities/CommentTagNotification";
import { ReplyTagNotification } from "../entities/ReplyTagNotification";
import { CaptionTagNotification } from "../entities/CaptionTagNotification";
import { ReplyUserTag } from "../entities/ReplyUserTags";
import { CommentUserTag } from "../entities/CommentUserTags";
import { CaptionUserTag } from "../entities/CaptionUserTags";
import { isAuth } from "../middleware/isAuth";
import { PaginatedNotifications } from "../utils/notification/notificationInput";

@Resolver(Notification)
export class NotificationResolver {

  @Query(() => PaginatedNotifications)
  @UseMiddleware(isAuth)
  async notifications(
    @Arg("idsList", () => [String]) idsList: string[],
		@Arg("limit", () => Int) limit: number,
		// @Arg("cursor", () => String, {nullable: true}) cursor: string,
    @Ctx() { userId }: MyContext
  ): Promise<PaginatedNotifications> {
    const realLimit = Math.min(20, limit);
		const realLimitLength = realLimit + 1;
		
		// if (cursor) {
		// 	cursorArray.push(new Date(parseInt(cursor)));
		// }

    const notifications = await getConnection()
      .createQueryBuilder()
      .select(`
        n.*,
        concat (
          n.parent_id::text, '_', n.user_id::text, '_', n.type::text
        ) as concatenated_id,
        case
          when l.post_id is null or p.id is null or pl.post_id is null or array_length(array_agg(plu), 1) = 0 then null
          else json_build_object(
            'post', json_build_object(
              'id', p.id,
              'likeCount', p."likeCount",
              'fileImgKey', p."fileImgKey",
              'likes', json_agg(
                json_build_object(
                  'user', json_build_object(
                    'id', plu.id,
                    'username', plu.username,
                    'small_file_key', plu.file_key
                  )
                )
              )
            )
          ) 
        end as "likeNotification",
        case
          when l1.reply_id is null or r.id is null or rc is null or rcp is null or rl.reply_id is null or array_length(array_agg(rlu), 1) = 0 then null
          else json_build_object(
            'reply', json_build_object(
              'id', r.id,
              'reply', r.reply,
              'likeCount', r."likeCount",
              'comment', json_build_object(
                'id', rc.id,
                'post', json_build_object(
                  'id', rcp.id,
                  'fileImgKey', rcp."fileImgKey"
                )
              ),
              'userTags', json_agg(
                json_build_object(
                  'reply_id', rut.reply_id,
                  'user_id', rut.user_id,
                  'user_string', rut.user_string
                )
              ),
              'likes', json_agg(
                json_build_object(
                  'user', json_build_object(
                    'id', rlu.id,
                    'username', rlu.username,
                    'small_file_key', rlu.small_file_key
                  )
                )
              )
            )
          )
        end as "likeReplyNotification",
        case 
          when l2.comment_id is null or c.id is null or cl.comment_id is null or array_length(array_agg(clu), 1) = 0 or cp is null then null
          else json_build_object(
            'comment', json_build_object(
              'id', c.id,
              'comment', c.comment,
              'likeCount', c."likeCount",
              'post', json_build_object(
                'id', cp.id,
                'fileImgKey', cp."fileImgKey"
              ),
              'userTags', json_agg(
                json_build_object(
                  'comment_id', cut.comment_id,
                  'user_id', cut.user_id,
                  'user_string', cut.user_string
                )
              ),
              'likes', json_agg(
                json_build_object(
                  'user', json_build_object(
                    'id', clu.id,
                    'username', clu.username,
                    'small_file_key', clu.small_file_key
                  )
                )
              )
            )
          ) 
        end as "likeCommentNotification",
        case 
          when f.follower_id is null or fu.id is null then null
          else json_build_object(
            'follower', json_build_object(
              'id', fu.id,
              'username', fu.username,
              'small_file_key', fu.small_file_key
            )
          ) 
        end as "followNotification",
        case 
          when cn.comment_id is null or cnc.id is null or cnu.id is null or cncp.id is null then null
          else json_build_object(
            'comment', json_build_object(
              'id', cnc.id,
              'comment', cnc.comment,
              'post', json_build_object(
                'id', cncp.id,
                'fileImgKey', cncp."fileImgKey"
              ),
              'userTags', json_agg(
                json_build_object(
                  'comment_id', cncut.comment_id,
                  'user_id', cncut.user_id,
                  'user_string', cncut.user_string
                )
              ),
              'user', json_build_object(
                'id', cnu.id,
                'username', cnu.username,
                'small_file_key', cnu.small_file_key
              )
            )
          ) 
        end as "commentNotification",
        case 
          when rn.reply_id is null or rnr.id is null or rnu.id is null or rnrc.id is null or rnrcp.id is null then null
          else json_build_object(
            'reply', json_build_object(
              'id', rnr.id,
              'reply', rnr.reply,
              'comment', json_build_object(
                'id', rnrc.id,
                'post', json_build_object(
                  'id', rnrcp.id,
                  'fileImgKey', rnrcp."fileImgKey"
                )
              ),
              'userTags', json_agg(
                json_build_object(
                  'reply_id', rnrut.reply_id,
                  'user_id', rnrut.user_id,
                  'user_string', rnrut.user_string
                )
              ),
              'user', json_build_object(
                'id', rnu.id,
                'username', rnu.username,
                'small_file_key', rnu.small_file_key
              )
            )
          ) 
        end as "replyNotification",
        case 
          when ctn.comment_id is null or ctnc.id is null or ctnu.id is null or ctncp.id is null then null
          else json_build_object(
            'comment', json_build_object(
              'id', ctnc.id,
              'comment', ctnc.comment,
              'post', json_build_object(
                'id', ctncp.id,
                'fileImgKey', ctncp."fileImgKey"
              ),
              'userTags', json_agg(
                json_build_object(
                  'comment_id', ctncut.comment_id,
                  'user_id', ctncut.user_id,
                  'user_string', ctncut.user_string
                )
              ),
              'user', json_build_object(
                'id', ctnu.id,
                'username', ctnu.username,
                'small_file_key', ctnu.small_file_key
              )
            )
          ) 
        end as "commentTagNotification",
        case 
          when rtn.reply_id is null or rtnr.id is null or rtnu.id is null or rtnrc is null or rtnrcp is null then null
          else json_build_object(
            'reply', json_build_object(
              'id', rtnr.id,
              'reply', rtnr.reply,
              'userTags', json_agg(
                json_build_object(
                  'reply_id', rtnrut.reply_id,
                  'user_id', rtnrut.user_id,
                  'user_string', rtnrut.user_string
                )
              ),
              'comment', json_build_object(
                'id', rtnrc.id,
                'post', json_build_object(
                  'id', rtnrcp.id,
                  'fileImgKey', rtnrcp."fileImgKey"
                )
              ),
              'user', json_build_object(
                'id', rtnu.id,
                'username', rtnu.username,
                'small_file_key', rtnu.small_file_key
              )
            )
          ) 
        end as "replyTagNotification",
        case 
          when cptn.post_id is null or cptnp.id is null or cptnu.id is null then null
          else json_build_object(
            'post', json_build_object(
              'id', cptnp.id,
              'caption', cptnp.caption,
              'fileImgKey', cptnp."fileImgKey",
              'userTags', json_agg(
                json_build_object(
                  'post_id', cptnput.post_id,
                  'user_id', cptnput.user_id,
                  'user_string', cptnput.user_string
                )
              ),
              'user', json_build_object(
                'id', cptnu.id,
                'username', cptnu.username,
                'small_file_key', cptnu.small_file_key
              )
            )
          ) 
        end as "captionTagNotification"
      `)
      .from(Notification, "n")
      .leftJoin(
        LikeNotification,
        "l",
        "l.post_id = n.parent_id and l.user_id = n.user_id and l.type = n.type"
      )
      .leftJoin(
        Post,
        'p',
        "p.id = l.post_id"
      )
      .leftJoin(
        `(select * from "like"
        order by "createdAt" desc
        limit 2)`, //ReplyLike
        'pl',
        "pl.post_id = p.id and pl.user_id != n.user_id"
      )
      .leftJoin(
        User,
        'plu',
        "plu.id = pl.user_id"
      )
      .leftJoin(
        ReplyLikeNotification,
        "l1", 
        "l1.reply_id = n.parent_id and l1.user_id = n.user_id and l1.type = n.type"
      )
      .leftJoin(
        Reply,
        'r',
        "r.id = l1.reply_id"
      )
      .leftJoin(
        Comment,
        "rc",
        "rc.id = r.comment_id"
      )
      .leftJoin(
        Post,
        "rcp",
        "rcp.id = rc.post_id"
      )
      .leftJoin(
        ReplyUserTag,
        'rut',
        'rut.reply_id = r.id'
      )
      .leftJoin(
        `(select * from reply_like
        order by "createdAt" desc
        limit 2)`, //ReplyLike
        'rl',
        "rl.reply_id = r.id and rl.user_id != n.user_id"
      )
      .leftJoin(
        User,
        'rlu',
        "rlu.id = rl.user_id"
      )
      .leftJoin(
        CommentLikeNotification,
        "l2", 
        "l2.comment_id = n.parent_id and l2.user_id = n.user_id and l2.type = n.type"
      )
      .leftJoin(
        Comment,
        'c',
        "c.id = l2.comment_id"
      )
      .leftJoin(
        Post,
        "cp",
        "cp.id = c.post_id"
      )
      .leftJoin(
        CommentUserTag,
        'cut',
        'cut.comment_id = c.id'
      )
      .leftJoin(
        `(select * from comment_like
        order by "createdAt" desc
        limit 2)`, //ReplyLike
        'cl',
        "cl.comment_id = c.id and cl.user_id != n.user_id"
      )
      .leftJoin(
        User,
        'clu',
        "clu.id = cl.user_id"
      )
      .leftJoin(
        FollowNotification,
        'f',
        'f.follower_id = n.parent_id and f.user_id = n.user_id and f.type = n.type'
      )
      .leftJoin(
        User,
        'fu',
        'fu.id = f.follower_id'
      )
      .leftJoin(
        CommentNotification,
        'cn',
        'cn.comment_id = n.parent_id and cn.user_id = n.user_id and cn.type = n.type'
      )
      .leftJoin(
        Comment,
        'cnc',
        'cnc.id = cn.comment_id'
      )
      .leftJoin(
        Post,
        "cncp",
        "cncp.id = cnc.post_id"
      )
      .leftJoin(
        User,
        'cnu',
        'cnu.id = cnc.user_id'
      )
      .leftJoin(
        CommentUserTag,
        'cncut',
        'cncut.comment_id = cnc.id'
      )
      .leftJoin(
        ReplyNotification,
        'rn',
        'rn.reply_id = n.parent_id and rn.user_id = n.user_id and rn.type = n.type'
      )
      .leftJoin(
        Reply,
        'rnr',
        'rnr.id = rn.reply_id'
      )
      .leftJoin(
        Comment,
        'rnrc',
        'rnrc.id = rnr.comment_id'
      )
      .leftJoin(
        Post,
        "rnrcp",
        "rnrcp.id = rnrc.post_id"
      )
      .leftJoin(
        User,
        'rnu',
        'rnu.id = rnr.user_id'
      )
      .leftJoin(
        ReplyUserTag,
        'rnrut',
        'rnrut.reply_id = rnr.id'
      )
      .leftJoin(
        CommentTagNotification,
        'ctn',
        'ctn.comment_id = n.parent_id and ctn.user_id = n.user_id and ctn.type = n.type'
      )
      .leftJoin(
        Comment,
        'ctnc',
        'ctnc.id = ctn.comment_id'
      )
      .leftJoin(
        Post,
        "ctncp",
        "ctncp.id = ctnc.post_id"
      )
      .leftJoin(
        User,
        'ctnu',
        'ctnu.id = ctnc.user_id'
      )
      .leftJoin(
        CommentUserTag,
        'ctncut',
        'ctncut.comment_id = ctnc.id'
      )
      .leftJoin(
        ReplyTagNotification,
        'rtn',
        'rtn.reply_id = n.parent_id and rtn.user_id = n.user_id and rtn.type = n.type'
      )
      .leftJoin(
        Reply,
        'rtnr',
        'rtnr.id = rtn.reply_id'
      )
      .leftJoin(
        Comment,
        'rtnrc',
        'rtnrc.id = rtnr.comment_id'
      )
      .leftJoin(
        Post,
        "rtnrcp",
        "rtnrcp.id = rtnrc.post_id"
      )
      .leftJoin(
        User,
        'rtnu',
        'rtnu.id = rtnr.user_id'
      )
      .leftJoin(
        ReplyUserTag,
        'rtnrut',
        'rtnrut.reply_id = rtnr.id'
      )
      .leftJoin(
        CaptionTagNotification,
        'cptn',
        'cptn.post_id = n.parent_id and cptn.user_id = n.user_id and cptn.type = n.type'
      )
      .leftJoin(
        Post,
        'cptnp',
        'cptnp.id = cptn.post_id'
      )
      .leftJoin(
        User,
        'cptnu',
        'cptnu.id = cptnp.user_id'
      )
      .leftJoin(
        CaptionUserTag,
        'cptnput',
        'cptnput.post_id = cptnp.id'
      )
      .groupBy("cptnu.id, cptnp.id, cptn.post_id, cptn.user_id, cptn.type, rtnrc.id, rtnrcp.id, rtnu.id, rtnr.id, rtn.reply_id, rtn.user_id, rtn.type, ctncp.id, ctnu.id, ctnc.id, ctn.type, ctn.user_id, ctn.comment_id, rnrc.id, rnrcp.id, rnu.id, rnr.id, rn.reply_id, rn.user_id, rn.type, cncp.id, cnu.id, cnc.id, cn.comment_id, cn.user_id, cn.type, fu.id, f.follower_id, f.user_id, f.type, pl.post_id, p.id, l.post_id, l.user_id, l.type, cp.id,  cl.comment_id, c.id, l2.comment_id, l2.user_id, l2.type, rc.id, rcp.id, r.id, rl.reply_id, l1.reply_id, l1.user_id, l1.type, n.parent_id, n.user_id, n.type")
      .where(`
        n.user_id = :user_id
        and not (concat (
          n.parent_id::text, '_', n.user_id::text, '_', n.type::text
        ) = ANY (:ids_list))
        and (
          (l is not null and p is not null and pl is not null and plu is not null) or
          (l1 is not null and r is not null and rl is not null and rlu is not null and rc is not null and rcp is not null) or
          (l2 is not null and c is not null and cl is not null and clu is not null and cp is not null) or
          (f is not null and fu is not null) or
          (cn is not null and cnc is not null and cnu is not null and cncp is not null) or
          (rn is not null and rnr is not null and rnu is not null and rnrc is not null and rnrcp is not null) or
          (ctn is not null and ctnc is not null and ctnu is not null and ctncp is not null) or
          (rtn is not null and rtnr is not null and rtnu is not null and rtnrc is not null and rtnrcp is not null) or
          (cptn is not null and cptnp is not null and cptnu is not null)
        )
      `, { user_id: userId, ids_list: idsList})//ids_list: idsList
      .orderBy('n."updatedAt"', "DESC")
      .limit(realLimitLength)
      .getRawMany()

    console.log(notifications.slice(0, realLimit))

    return {
			notifications: notifications.slice(0, realLimit),
			hasMore: notifications.length === realLimitLength,
		};

    // return notifications;
  }
} 