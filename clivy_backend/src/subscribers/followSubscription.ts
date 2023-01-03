import { publishNotification } from "../utils/aws/publishNotification";
import { EntitySubscriberInterface, EventSubscriber, getConnection, InsertEvent, RemoveEvent } from "typeorm";
import { User } from "../entities/User";
import { DeviceToken } from "../entities/DeviceToken";
import { Notification, NotificationType } from "../entities/Notification";
import { Follow } from "../entities/Follow";
import { FollowNotification } from "../entities/FollowNotification";
// import { Notification } from "../entities/Notification"

@EventSubscriber()
export class FollowSubscription implements EntitySubscriberInterface<Follow> {
  listenTo(): any {
    return Follow; 
  }

  // async afterRemove(event: RemoveEvent<Follow>) {
  //   if (event.entityId) {
  //     const follower = await User.findOne({ where: {
  //       id: event.entityId.followerId
  //     }});
  //     const following = await User.findOne({ where: {
  //       id: event.entityId.followingId
  //     }});
  //     if (follower && following) {
  //       await getConnection().query(`
  //         update "user"
  //         set "followingCount" = "followingCount" - 1
  //         where id = $1
  //       `, [follower.id]);
  //       await getConnection().query(`
  //         update "user"
  //         set "followersCount" = "followersCount" - 1
  //         where id = $1
  //       `, [following.id]);
  //       await Notification.delete({
  //         parent_id: follower.id,
  //         user_id: following.id,
  //         type: NotificationType.follow
  //       })
  //     }
  //   }
  // }

  async afterInsert(event: InsertEvent<Follow>) {
    const following = await User.findOne({
      where: {
        id: event.entity.followingId
      }
    })

    const follower = await User.findOne({
      where: {
        id: event.entity.followerId
      }
    })

    if (following && follower) {
      await getConnection().query(`
        update "user"
        set "followingCount" = "followingCount" + 1
        where id = $1
      `, [follower.id]);
      await getConnection().query(`
        update "user"
        set "followersCount" = "followersCount" + 1
        where id = $1
      `, [following.id]);

      if (following.id != follower.id) {
        const notificationData = await FollowNotification.findOne({
          where: {
            follower_id: follower.id,
            user_id: following.id,
            type: NotificationType.follow
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
              { parent_id: follower.id, user_id: following.id, type: NotificationType.follow}
            )
            .execute();
            
            await tm.createQueryBuilder()
            .update(FollowNotification)
            .set({
              updatedAt: new Date()
            })
            .where(
              "follower_id = :follower_id and user_id = :user_id and type = :type", 
              { follower_id: follower.id, user_id: following.id, type: NotificationType.follow}
            )
            .execute();
          })
        } else {
          await getConnection().transaction(async (tm) => {
            await tm.query(`
              insert into "notification" ("parent_id", "user_id", "type")
              values ($1, $2, $3)
            `, [follower.id, following.id, NotificationType.follow]);
            await tm.query(`
              insert into "follow_notification" ("follower_id", "user_id", "type")
              values ($1, $2, $3)
            `, [follower.id, following.id, NotificationType.follow]);
          })
        }
        const deviceTokens = await DeviceToken.find({where: {
          user_id: following.id
        }});

        console.log(deviceTokens);

        const message = `${follower.username} started following you`;
        
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