import { Field, ObjectType } from "type-graphql";
import { Notification } from "../../entities/Notification";


@ObjectType()
export class PaginatedNotifications {
  @Field(() => [Notification])
  notifications: Notification[];

  @Field(() => Boolean)
  hasMore: boolean;
}