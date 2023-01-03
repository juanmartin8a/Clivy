import { Field, InputType, ObjectType } from "type-graphql";

@ObjectType()
export class FileResponse {
  @Field(() => String, {nullable: true})
  file?: string;

  @Field(() => String, {nullable: true})
  error?: string;
}

@InputType()
export class CheckIsAuth {
  @Field(() => String, {nullable: true})
  token?: string;

  @Field(() => String, {nullable: true})
  error?: string;
}

@ObjectType()
export class TokenResponse {
  @Field(() => String)
  accessToken: string;

  @Field(() => String)
  refreshToken: string;
}

@ObjectType()
export class ErrorResponse {
  @Field(() => String)
  field: string;

  @Field(() => String)
  message: string;
}

@InputType()
export class DeviceInput {
  @Field(() => String, {nullable: true})
  deviceToken: string;

  @Field(() => Boolean, {nullable: true})
  platformIsIOS: boolean;
}