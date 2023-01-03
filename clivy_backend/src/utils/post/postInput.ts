import { Post } from "../../entities/Post";
import { Field, InputType, Int, ObjectType } from "type-graphql";
import { FileUpload, GraphQLUpload } from "graphql-upload";
import { ErrorResponse } from "../global/globalInput";

@InputType()
export class CreatePostInput {
    @Field(() => String)
    caption: string;

    @Field(() => GraphQLUpload)
    file: FileUpload
}

@ObjectType()
export class CreatePostResponse {
    @Field(() => Post, {nullable: true})
    post?: Post;

    @Field(() => ErrorResponse, {nullable: true})
    error?: ErrorResponse;
}

@ObjectType()
export class LikeResponse {
    @Field(() => Int, {nullable: true})
    value?: number;

    @Field(() => String, {nullable: true})
    clientId?: string
}

@ObjectType()
export class PaginatedPosts {
    @Field(() => [Post])
    posts?: Post[];

    @Field(() => Boolean)
    hasMore?: boolean;
}

@InputType()
export class FileDimsInput {
    @Field(() => Int)
    fileWidth?: number;

    @Field(() => Int)
    fileHeight?: number;
}