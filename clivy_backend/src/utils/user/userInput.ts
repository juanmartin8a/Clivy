import { User } from "../../entities/User";
import { Field, InputType, Int, ObjectType } from "type-graphql";
import { ErrorResponse, TokenResponse } from "../global/globalInput";

@InputType()
export class RegisterInput {
	@Field()
	name: string

	@Field()
	username: string

	@Field()
	email: string

	@Field()
	password: string

  @Field()
	birthday: string
}

@InputType()
export class SignInInput {
	@Field()
	usernameOrEmail: string

	@Field()
	password: string
}

@ObjectType()
export class UserMutationResponse {
  @Field(() => User, {nullable: true})
  user?: User;

  @Field(() => TokenResponse, {nullable: true})
  tokens?: TokenResponse;
  
  @Field(() => [ErrorResponse], {nullable: true})
  errors?: ErrorResponse[];
}

@InputType()
export class UserUpdateInput {
  @Field(() => String, {nullable: true})
  name?: string;

  @Field(() => String, {nullable: true})
  username?: string;
  
  @Field(() => String, {nullable: true})
  bio?: string;
}

// @ObjectType()
// export class PaginatedUsers {
//   @Field(() => [User])
//   users?: User[];

//   @Field(() => Boolean)
//   hasMore?: boolean;
// }

@ObjectType()
export class PaginatedFollow {
  @Field(() => [User])
  users: User[];

  @Field(() => Boolean)
  hasMore: boolean;

  @Field(() => Int)
  userId: number;
}

// @ObjectType()
// export class PaginatedUsers {
//   @Field(() => [User], {nullable: true})
//   users?: User[];

//   @Field(() => TokenResponse, {nullable: true})
//   hasMore?: TokenResponse;

//   @Field(() => TokenResponse, {nullable: true})
//   page?: TokenResponse;
// }