import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, InsertEvent, RemoveEvent } from "typeorm";
import { Like } from "../entities/Like";
import { afterActionFunction } from "../utils/subscriberUtils/afterActionFunction";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Post } from "../entities/Post";
import { Notification, NotificationType } from "../entities/Notification";
import { LikeNotification } from "../entities/LikeNotification";
// import { Notification } from "../entities/Notification"

@EventSubscriber()
export class LikeSubscription implements EntitySubscriberInterface<Like> {
  listenTo(): any {
    return Like; 
  }

  // async afterRemove(event: RemoveEvent<Like>) {
  //   if (event.entityId) {

  //     const post = await Post.findOne({ where: {
  //       id: event.entityId.post_id
  //     }});
  //     if (post) {
  //       await getConnection().query(`
  //         update "post"
  //         set "likeCount" = "likeCount" - 1
  //         where "id" = $1
  //       `, [event.entityId.post_id]);
        
  //       // await Notification.delete({
  //       //   parent_id: post.id,
  //       //   user_id: post.user_id,
  //       //   type: NotificationType.like
  //       // })
  //     }
  //   }
  // }

  async afterInsert(event: InsertEvent<Like>) {
    // console.log("hello there")
    // console.log(event.entity.post_id);
    const post = await Post.findOne({ where: {
      id: event.entity.post_id
    }});
    if (post) {
      // const post: Post = postsById[0];
      await getConnection().query(`
        update "post"
        set "likeCount" = "likeCount" + 1
        where "id" = $1
      `, [event.entity.post_id]);
      
      const user = await User.findOne({where: {id: event.entity.user_id}});
      
      if (user) {
        await afterActionFunction(
          false, event.entity.post_id, event.entity.user_id
        );
        if (user.id != post.user_id) {
          const notificationData = await LikeNotification.findOne({
            where: {
              post_id: post.id,
              user_id: post.user_id,
              type: NotificationType.like
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
                { parent_id: post.id, user_id: post.user_id, type: NotificationType.like}
              )
              .execute();
              
              await tm.createQueryBuilder()
              .update(LikeNotification)
              .set({
                updatedAt: new Date()
              })
              .where(
                "post_id = :post_id and user_id = :user_id and type = :type", 
                { post_id: post.id, user_id: post.user_id, type: NotificationType.like}
              )
              .execute();
            })
          } else {
            await getConnection().transaction(async (tm) => {
              await tm.query(`
                insert into "notification" ("parent_id", "user_id", "type")
                values ($1, $2, $3)
              `, [post.id, post.user_id, NotificationType.like]);
              await tm.query(`
                insert into "like_notification" ("post_id", "user_id", "type")
                values ($1, $2, $3)
              `, [post.id, post.user_id, NotificationType.like]);
            })
          }
          const deviceTokens = await DeviceToken.find({where: {
            user_id: post.user_id
          }});

          console.log("sapo");
  
          console.log(deviceTokens);
  
          const message = `${user.username} has liked your post`;
          
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