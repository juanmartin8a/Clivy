import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, UpdateEvent } from "typeorm";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Notification, NotificationType } from "../entities/Notification";
import { ReplyUserTag } from "../entities/ReplyUserTags";
import { Reply } from "../entities/Reply";
import { ReplyTagNotification } from "../entities/ReplyTagNotification";

@EventSubscriber()
export class ReplyTagSubscription implements EntitySubscriberInterface<ReplyUserTag> {
  listenTo(): any {
    return ReplyUserTag;
  }

  async afterUpdate(event: UpdateEvent<ReplyUserTag>) {
    if (event.entity && event.entity.reply_id) {

      const reply = await Reply.findOne({
        where: {id: event.entity.reply_id}
      })
  
      if (reply) {
  
        const replyUser = await User.findOne({where: {id: reply.user_id}})
  
        const taggedUser = await User.findOne({where: {id: event.entity.user_id}})
  
        if (replyUser && taggedUser) {
          if (taggedUser.id != replyUser.id) {
            const notificationData = await ReplyTagNotification.findOne({
              where: {
                reply_id: reply.id,
                user_id: taggedUser.id,
                type: NotificationType.replyTag
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
                  { parent_id: reply.id, user_id: taggedUser.id, type: NotificationType.replyTag}
                )
                .execute();
                
                await tm.createQueryBuilder()
                .update(ReplyTagNotification)
                .set({
                  updatedAt: new Date()
                })
                .where(
                  "reply_id = :reply_id and user_id = :user_id and type = :type", 
                  { reply_id: reply.id, user_id: taggedUser.id, type: NotificationType.replyTag}
                )
                .execute();
              })
            } else {
              await getConnection().transaction(async (tm) => {
                await tm.query(`
                  insert into "notification" ("parent_id", "user_id", "type")
                  values ($1, $2, $3)
                `, [reply.id, taggedUser.id, NotificationType.replyTag]);
                await tm.query(`
                  insert into "reply_tag_notification" ("reply_id", "user_id", "type")
                  values ($1, $2, $3)
                `, [reply.id, taggedUser.id, NotificationType.replyTag]);
              })
            }
            const deviceTokens = await DeviceToken.find({where: {
              user_id: taggedUser.id
            }});
    
            console.log(deviceTokens);
    
            const message = `${replyUser.username} tagged you in a reply`;
            
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