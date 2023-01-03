import { EntitySubscriberInterface, EventSubscriber, getConnection, RemoveEvent, UpdateEvent } from "typeorm";
import { Post } from '../entities/Post'
// import { Notification } from "../entities/Notification"

@EventSubscriber()
export class PostSubscription implements EntitySubscriberInterface<Post> {
  listenTo(): any {
    return Post;
  }

  // async beforeRemove(event: RemoveEvent<Post>) {
  //   if (event.entityId) {
  //     const postRow = await Post.findOne({
  //       where: {id: event.entityId}
  //     })
  //     if (postRow) {
  //       await getConnection().query(`
  //         update "user"
  //         set "postCount" = "postCount" - 1
  //         where id = $1
  //       `, [postRow.user_id])

  //       await getConnection().query(`
	// 				update "videogame"
	// 				set "postCount" = "postCount" - 1
	// 				where id = $1
	// 			`, [postRow.videogame_id])
  //     }
  //   }
  // }

  // async afterUpdate(event: UpdateEvent<Post>) {
  //   if (event.entity && event.entity.id) {
  //     const postRow = await Post.findOne({
  //       where: {id: event.entity.id}
  //     })

  //     if (postRow) {
  //       await getConnection().query(`
  //         update "user"
  //         set "postCount" = "postCount" + 1
  //         where id = $1
  //       `, [postRow.user_id])

  //       await getConnection().query(`
	// 				update "videogame"
	// 				set "postCount" = "postCount" + 1
	// 				where id = $1
	// 			`, [postRow.videogame_id])
  //     }
  //   }
  // }
}