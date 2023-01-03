import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, UpdateEvent } from "typeorm";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Notification, NotificationType } from "../entities/Notification";
import { CaptionUserTag } from "../entities/CaptionUserTags";
import { Post } from "../entities/Post";
import { CaptionTagNotification } from "../entities/CaptionTagNotification";

@EventSubscriber()
export class CaptionTagSubscription implements EntitySubscriberInterface<CaptionUserTag> {
  listenTo(): any {
    return CaptionUserTag;
  }

  async afterUpdate(event: UpdateEvent<CaptionUserTag>) {
    if (event.entity && event.entity.post_id) {

      const post = await Post.findOne({
        where: {id: event.entity.post_id}
      })
  
      if (post) {
  
        const postUser = await User.findOne({where: {id: post.user_id}})
  
        const taggedUser = await User.findOne({where: {id: event.entity.user_id}})
  
        if (postUser && taggedUser) {
          if (taggedUser.id != postUser.id) {
            const notificationData = await CaptionTagNotification.findOne({
              where: {
                post_id: post.id,
                user_id: taggedUser.id,
                type: NotificationType.capTag
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
                  { parent_id: post.id, user_id: taggedUser.id, type: NotificationType.capTag}
                )
                .execute();
                
                await tm.createQueryBuilder()
                .update(CaptionTagNotification)
                .set({
                  updatedAt: new Date()
                })
                .where(
                  "post_id = :post_id and user_id = :user_id and type = :type", 
                  { post_id: post.id, user_id: taggedUser.id, type: NotificationType.capTag}
                )
                .execute();
              })
            } else {
              await getConnection().transaction(async (tm) => {
                await tm.query(`
                  insert into "notification" ("parent_id", "user_id", "type")
                  values ($1, $2, $3)
                `, [post.id, taggedUser.id, NotificationType.capTag]);
                await tm.query(`
                  insert into "caption_tag_notification" ("post_id", "user_id", "type")
                  values ($1, $2, $3)
                `, [post.id, taggedUser.id, NotificationType.capTag]);
              })
            }
            const deviceTokens = await DeviceToken.find({where: {
              user_id: taggedUser.id
            }});
    
            console.log(deviceTokens);
    
            const message = `${postUser.username} tagged you in a clip`;
            
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