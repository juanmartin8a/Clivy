import { UserSearch } from "../entities/UserSearches";
import { EntitySubscriberInterface, EventSubscriber, getConnection, InsertEvent } from "typeorm";

@EventSubscriber()
export class UserSearchSubscription implements EntitySubscriberInterface<UserSearch> {
  listenTo() {
    return UserSearch;
  }

  async afterInsert(event: InsertEvent<UserSearch>) {
    console.log("event: ");
    // wtf is this
    await getConnection().query(`
      DELETE FROM "user_search" us1
      WHERE us1."userId" = $1 AND us1."searchedUserId" NOT IN (
        select us."searchedUserId" from "user_search" us
        where us."userId" = $1
        order by us."updatedAt" DESC
        limit 10
      )
    `, [event.entity.userId]);
  }
}