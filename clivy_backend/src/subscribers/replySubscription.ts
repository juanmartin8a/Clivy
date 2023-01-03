import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, RemoveEvent, UpdateEvent } from "typeorm";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Notification, NotificationType } from "../entities/Notification";
import { Reply } from "../entities/Reply";
import { Comment } from "../entities/Comments";
import { ReplyNotification } from "../entities/ReplyNotification";
// import { Notification } from "../entities/Notification"

@EventSubscriber()
export class ReplySubscription implements EntitySubscriberInterface<Reply> {
  listenTo(): any {
    return Reply;
  }

  // async beforeRemove(event: RemoveEvent<Reply>) {
  //   console.log("12345678")
  //   if (event.entityId) {
  //     console.log(event.entityId)
  //     const reply = await Reply.findOne({ where: {
  //       id: event.entityId
  //     }});
  //     console.log(reply);
  //     console.log("asijdnfvkjadhbfvdvbh")
  //     if (reply) {
  //       const comment = await Comment.findOne({
  //         where: {
  //           id: reply.comment_id
  //         }
  //       })
  //       if (comment) {
  //         await getConnection().query(`
  //           update "comment"
  //           set "replyCount" = "replyCount" - 1
  //           where id = $1
  //         `, [reply.comment_id]);
  //         await getConnection().query(`
  //           update "post"
  //           set "commentCount" = "commentCount" - 1
  //           where id = $1
  //         `, [comment.post_id]);
  //       }
  //     }
  //   }
  // }

  async afterUpdate(event: UpdateEvent<Reply>) {
    if (event.entity && event.entity.id) {
      const replyRow = await Reply.findOne({
        where: {id: event.entity.id}
      })

      if (replyRow) {
        const comment = await Comment.findOne({
          where: {
            id: replyRow.comment_id
          }
        })

        if (comment) {
          // await getConnection().query(`
          //   update "comment"
          //   set "replyCount" = "replyCount" + 1
          //   where id = $1
          // `, [replyRow.comment_id]);
          
          // await getConnection().query(`
          //   update "post"
          //   set "commentCount" = "commentCount" + 1
          //   where id = $1
          // `, [comment.post_id]);

          const user = await User.findOne({where: {id: replyRow.user_id}})

          if (user) {
            if (user.id != comment.user_id) {
              const notificationData = await ReplyNotification.findOne({
                where: {
                  reply_id: replyRow.id, //event.entity.id
                  user_id: comment.user_id,
                  type: NotificationType.reply
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
                    { parent_id: replyRow.id, user_id: comment.user_id, type: NotificationType.reply}
                  )
                  .execute();
                  
                  await tm.createQueryBuilder()
                  .update(ReplyNotification)
                  .set({
                    updatedAt: new Date()
                  })
                  .where(
                    "reply_id = :reply_id and user_id = :user_id and type = :type", 
                    { reply_id: replyRow.id, user_id: comment.user_id, type: NotificationType.reply}
                  )
                  .execute();
                })
              } else {
                await getConnection().transaction(async (tm) => {
                  await tm.query(`
                    insert into "notification" ("parent_id", "user_id", "type")
                    values ($1, $2, $3)
                  `, [replyRow.id, comment.user_id, NotificationType.reply]);
                  await tm.query(`
                    insert into "reply_notification" ("reply_id", "user_id", "type")
                    values ($1, $2, $3)
                  `, [replyRow.id, comment.user_id, NotificationType.reply]);
                })
              }
              const deviceTokens = await DeviceToken.find({where: {
                user_id: comment.user_id
              }});
      
              console.log(deviceTokens);
      
              const message = `${user.username} replied to your comment`;
              
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
  }
}