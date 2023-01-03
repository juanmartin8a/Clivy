import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, InsertEvent, RemoveEvent } from "typeorm";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Notification, NotificationType } from "../entities/Notification";
import { ReplyLike } from "../entities/ReplyLike";
import { Reply } from "../entities/Reply";
import { ReplyLikeNotification } from "../entities/ReplyLikeNotification";
// import { Notification } from "../entities/Notification"

@EventSubscriber()
export class ReplyLikeSubscription implements EntitySubscriberInterface<ReplyLike> {
  listenTo(): any {
    return ReplyLike; 
  }

  // async afterRemove(event: RemoveEvent<ReplyLike>) {
  //   const reply = await Reply.findOne({
  //     where: {
  //       id: event.entityId.comment_id
  //     }
  //   });
  //   if (reply) {
  //     await getConnection().query(`
  //       update "reply"
  //       set "likeCount" = "likeCount" - 1
  //       where "id" = $1
  //     `, [event.entityId.reply_id]);

  //     await Notification.delete({
  //       parent_id: reply.id,
  //       user_id: reply.user_id,
  //       type: NotificationType.replyLike
  //     })
  //   }
  // }

  async afterInsert(event: InsertEvent<ReplyLike>) {
    // console.log("hello there")
    // console.log(event.entity.post_id);
    const repliesById: Reply[] = await Reply.find({
      where: {
        id: event.entity.reply_id
      }
    });
    if (repliesById.length > 0) {
      const reply: Reply = repliesById[0]

      // await event.manager.increment(Reply, {id: event.entity.reply_id}, "likeCount", 1);
      await getConnection().query(`
        update "reply"
        set "likeCount" = "likeCount" + 1
        where "id" = $1
      `, [event.entity.reply_id]);

      const user = await User.findOne({where: {id: event.entity.user_id}});


      if (user) {
        if (user.id != reply.user_id) {
          const notificationData = await ReplyLikeNotification.findOne({
            where: {
              reply_id: reply.id,
              user_id: reply.user_id,
              type: NotificationType.replyLike
            }
          })
          if (notificationData) {
            await getConnection().transaction(async (tm) => {
              await tm.createQueryBuilder()
              .update(Notification)
              .set({
                updatedAt: new Date()
              })
              .where(
                "parent_id = :parent_id and user_id = :user_id and type = :type", 
                { parent_id: reply.id, user_id: reply.user_id, type: NotificationType.replyLike}
              )
              .execute();
              
              await tm.createQueryBuilder()
              .update(ReplyLikeNotification)
              .set({
                updatedAt: new Date()
              })
              .where(
                "reply_id = :reply_id and user_id = :user_id and type = :type", 
                { reply_id: reply.id, user_id: reply.user_id, type: NotificationType.replyLike}
              )
              .execute();
            })
          } else {
            getConnection().transaction(async (tm) => {
              await tm.createQueryBuilder()
              .insert()
              .into(Notification)
              .values({
                parent_id: reply.id,
                user_id: reply.user_id,
                type: NotificationType.replyLike,
              })
              .execute()

              await tm.createQueryBuilder()
              .insert()
              .into(ReplyLikeNotification)
              .values({
                reply_id: reply.id,
                user_id: reply.user_id,
                type: NotificationType.replyLike,
              })
              .execute()
            })
          }
          const theReply = await Notification.find({});
          console.log(theReply);
          const deviceTokens = await DeviceToken.find({where: {
            user_id: reply.user_id
          }});
    
          const message = `${user.username} has liked your reply`;
          
          for (var i = 0; i < deviceTokens.length; i++) {
            const deviceToken: DeviceToken = deviceTokens[i];
            const payload: Object = {
              "aps": {
                // "content-available": 1,
                "sound": "default",
                "badge": 1, // make this dynamic
                "alert": {
                  "title": "Clivy",
                  "body": message
                }
              }
            }
            await publishNotification(
              payload, deviceToken.token, deviceToken.platform == 'iOS'
            );
          }
        }
      }
    }
  }
}