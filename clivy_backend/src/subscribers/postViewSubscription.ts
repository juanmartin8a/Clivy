import { EntitySubscriberInterface, EventSubscriber, InsertEvent, UpdateEvent } from "typeorm";
import { afterActionFunction } from "../utils/subscriberUtils/afterActionFunction";
import { PostView } from "../entities/PostView";

@EventSubscriber()
export class PostViewSubscription implements EntitySubscriberInterface<PostView> {
  listenTo(): any {
    return PostView; 
  }

  async afterInsert(event: InsertEvent<PostView>) {
    await afterActionFunction(
      true, event.entity.post_id, event.entity.user_id
    );
  }

  async afterUpdate(event: UpdateEvent<PostView>) {
    if (event.entity) {
      await afterActionFunction(
        true, event.entity.post_id, event.entity.user_id
      );
    }
  }

}