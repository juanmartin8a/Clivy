import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, UpdateEvent } from "typeorm";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Notification, NotificationType } from "../entities/Notification";
import { Comment } from '../entities/Comments';
import { CommentUserTag } from "../entities/CommentUserTags";
import { CommentTagNotification } from "../entities/CommentTagNotification";

@EventSubscriber()
export class CommentTagSubscription implements EntitySubscriberInterface<CommentUserTag> {
  listenTo(): any {
    return CommentUserTag; 
  }

  async afterUpdate(event: UpdateEvent<CommentUserTag>) {
    if (event.entity && event.entity.comment_id) {

      const comment = await Comment.findOne({
        where: {id: event.entity.comment_id}
      })
    
      if (comment) {
  
        const commentUser = await User.findOne({where: {id: comment.user_id}})
  
        const taggedUser = await User.findOne({where: {id: event.entity.user_id}})
  
        if (commentUser && taggedUser) {
          if (taggedUser.id != commentUser.id) {
            const notificationData = await CommentTagNotification.findOne({
              where: {
                comment_id: comment.id, //event.entity.id
                user_id: taggedUser.id,
                type: NotificationType.commentTag
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
                  { parent_id: comment.id, user_id: taggedUser.id, type: NotificationType.commentTag}
                )
                .execute();
                
                await tm.createQueryBuilder()
                .update(CommentTagNotification)
                .set({
                  updatedAt: new Date()
                })
                .where(
                  "comment_id = :comment_id and user_id = :user_id and type = :type", 
                  { comment_id: comment.id, user_id: taggedUser.id, type: NotificationType.commentTag}
                )
                .execute();
              })
            } else {
              await getConnection().transaction(async (tm) => {
                await tm.query(`
                  insert into "notification" ("parent_id", "user_id", "type")
                  values ($1, $2, $3)
                `, [comment.id, taggedUser.id, NotificationType.commentTag]);
                await tm.query(`
                  insert into "comment_tag_notification" ("comment_id", "user_id", "type")
                  values ($1, $2, $3)
                `, [comment.id, taggedUser.id, NotificationType.commentTag]);
              })
            }
            const deviceTokens = await DeviceToken.find({where: {
              user_id: taggedUser.id
            }});
    
            console.log(deviceTokens);
    
            const message = `${commentUser.username} tagged you in a comment`;
            
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