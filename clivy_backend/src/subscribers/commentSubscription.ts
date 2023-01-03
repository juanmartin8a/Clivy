import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, RemoveEvent, UpdateEvent } from "typeorm";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Notification, NotificationType } from "../entities/Notification";
import { Comment } from '../entities/Comments';
import { CommentNotification } from "../entities/CommentNotification";
import { Post } from '../entities/Post'
// import { Notification } from "../entities/Notification"

@EventSubscriber()
export class CommentSubscription implements EntitySubscriberInterface<Comment> {
  listenTo(): any {
    return Comment; 
  }

  // async beforeRemove(event: RemoveEvent<Comment>) {
  //   if (event.entityId) {
  //     //  onmouseleave.lo()
  //     const comment = await Comment.findOne({ where: {
  //       id: event.entityId
  //     }});
  //     console.log(comment);
  //     console.log("comment up")
  //     if (comment) {
  //       await getConnection().query(`
  //         update "post"
  //         set "commentCount" = "commentCount" - (1 + $2)
  //         where id = $1
  //       `, [comment.post_id, comment.replyCount]);
  //     }
  //   }
  // }

  async afterUpdate(event: UpdateEvent<Comment>) {


    if (event.entity && event.entity.id) {
      const commentRow = await Comment.findOne({
        where: {id: event.entity.id}
      })

      if (commentRow) {
        const post = await Post.findOne({
          where: {
            id: commentRow.post_id
          }
        })

        if (post) {
          // await getConnection().query(`
          //   update "post"
          //   set "commentCount" = "commentCount" + 1
          //   where id = $1
          // `, [post.id]);

          const user = await User.findOne({where: {id: commentRow.user_id}})

          if (user) {
            if (user.id != post.user_id) {
              const notificationData = await CommentNotification.findOne({
                where: {
                  comment_id: commentRow.id, //event.entity.id
                  user_id: post.user_id,
                  type: NotificationType.comment
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
                    { parent_id: commentRow.id, user_id: post.user_id, type: NotificationType.comment}
                  )
                  .execute();
                  
                  await tm.createQueryBuilder()
                  .update(CommentNotification)
                  .set({
                    updatedAt: new Date()
                  })
                  .where(
                    "comment_id = :comment_id and user_id = :user_id and type = :type", 
                    { comment_id: commentRow.id, user_id: post.user_id, type: NotificationType.comment}
                  )
                  .execute();
                })
              } else {
                await getConnection().transaction(async (tm) => {
                  await tm.query(`
                    insert into "notification" ("parent_id", "user_id", "type")
                    values ($1, $2, $3)
                  `, [commentRow.id, post.user_id, NotificationType.comment]);
                  await tm.query(`
                    insert into "comment_notification" ("comment_id", "user_id", "type")
                    values ($1, $2, $3)
                  `, [commentRow.id, post.user_id, NotificationType.comment]);
                })
              }
              const deviceTokens = await DeviceToken.find({where: {
                user_id: post.user_id
              }});
      
              console.log(deviceTokens);
      
              const message = `${user.username} commented on your post`;
              
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