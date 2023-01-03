import { UserSearch } from "../entities/UserSearches";
import { Arg, Ctx, FieldResolver, Int, Mutation, Query, Resolver, Root, UseMiddleware } from "type-graphql";
import { User } from "../entities/User";
import { MyContext } from "../myContext";
import { getConnection } from "typeorm";
import { isAuth } from "../middleware/isAuth";

@Resolver(UserSearch)
export class UserSearchResolver {
  @FieldResolver(() => User)
  user(
    @Root() userSearch: UserSearch,
		@Ctx() { userLoader }: MyContext
  ) {
    return userLoader.load(userSearch.userId);
  }

  @FieldResolver(() => User)
  searchedUser(
    @Root() userSearch: UserSearch,
		@Ctx() { userLoader }: MyContext
  ) {
    return userLoader.load(userSearch.searchedUserId);
  }

  @Query(() => [UserSearch])
  @UseMiddleware(isAuth)
	async searchedUsers(
		@Ctx() { userId }: MyContext
	): Promise<UserSearch[]> {
    console.log("sapotoro");
		const searchedUsersQuery = await getConnection().query(`
			select * from user_search us
      where us."userId" = $1
      order by us."updatedAt" desc
		`, [userId]);

		return searchedUsersQuery;
	}

  @Mutation(() => Boolean)
  @UseMiddleware(isAuth)
  async deleteUserSearch(
    @Arg("searchedUserId", () => Int) searchedUserId: number,
    @Ctx() { userId }: MyContext
  ): Promise<Boolean> {
    try {
      await getConnection().query(`
        delete from "user_search" us
        where us."userId" = $1 and us."searchedUserId" = $2
      `, [userId, searchedUserId]);
      return true;
    } catch(e) {
      console.log(e);
      return false;
    }
  }
}