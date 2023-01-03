import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, InsertEvent, RemoveEvent } from "typeorm";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Notification, NotificationType } from "../entities/Notification";
import { CommentLike } from "../entities/CommentLike";
import { Comment } from "../entities/Comments";
import { CommentLikeNotification } from "../entities/CommentLikeNotification";
// import { Notification } from "../entities/Notification"

@EventSubscriber()
export class CommentLikeSubscription implements EntitySubscriberInterface<CommentLike> {
  listenTo(): any {
    return CommentLike; 
  }

  // async afterRemove(event: RemoveEvent<CommentLike>) {
  //   const comment = await Comment.findOne({
  //     where: {
  //       id: event.entityId.comment_id
  //     }
  //   });
  //   if (comment) {
  //     // await event.manager.decrement(Comment, {id: event.entityId.comment_id}, "likeCount", 1);
  //     await getConnection().query(`
  //       update "comment"
  //       set "likeCount" = "likeCount" - 1
  //       where "id" = $1
  //     `, [event.entityId.comment_id]);
  //     await Notification.delete({
  //       parent_id: comment.id,
  //       user_id: comment.user_id,
  //       type: NotificationType.commentLike
  //     })
  //   }
  // }

  async afterInsert(event: InsertEvent<CommentLike>) {
    // console.log("hello there")
    // console.log(event.entity.post_id);
    const comment = await Comment.findOne({
      where: {
        id: event.entity.comment_id
      }
    });
    if (comment) {

      await getConnection().query(`
        update "comment"
        set "likeCount" = "likeCount" + 1
        where "id" = $1
        `, [event.entity.comment_id]);

      const user = await User.findOne({where: {id: event.entity.user_id}});

      if (user) {
        if (user.id != comment.user_id) {
          const notificationData = await CommentLikeNotification.findOne({
            where: {
              comment_id: comment.id,
              user_id: comment.user_id,
              type: NotificationType.commentLike
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
                { parent_id: comment.id, user_id: comment.user_id, type: NotificationType.commentLike}
              )
              .execute();
              
              await tm.createQueryBuilder()
              .update(CommentLikeNotification)
              .set({
                updatedAt: new Date()
              })
              .where(
                "comment_id = :comment_id and user_id = :user_id and type = :type", 
                { comment_id: comment.id, user_id: comment.user_id, type: NotificationType.commentLike}
              )
              .execute();
            })
          } else {
            await getConnection().transaction(async (tm) => {
              await tm.query(`
                insert into "notification" ("parent_id", "user_id", "type")
                values ($1, $2, $3)
                returning *
              `, [comment.id, comment.user_id, NotificationType.commentLike]);
              await tm.query(`
                insert into "comment_like_notification" ("comment_id", "user_id", "type")
                values ($1, $2, $3)
              `, [comment.id, comment.user_id, NotificationType.commentLike]);
            })
          }
          const deviceTokens = await DeviceToken.find({where: {
            user_id: comment.user_id
          }});
    
          console.log(deviceTokens);
    
          const message = `${user.username} has liked your comment`;
          
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