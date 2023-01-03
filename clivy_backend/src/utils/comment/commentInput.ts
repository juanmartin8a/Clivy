import { Comment } from "../../entities/Comments";
import { Field, InputType, Int, ObjectType } from "type-graphql";
import { Reply } from "../../entities/Reply";

@ObjectType()
export class CreateCommentResponse {
    @Field(() => Comment, {nullable: true})
    comment?: Comment;

    @Field(() => Int, {nullable: true})
    postId?: number;

    @Field(() => Boolean, {nullable: true})
    error?: boolean;
}

@ObjectType()
export class CreateReplyResponse {
    @Field(() => Reply, {nullable: true})
    reply?: Reply;

    @Field(() => Int, {nullable: true})
    commentId?: number;

    @Field(() => Int, {nullable: true})
    postId?: number;

    @Field(() => Boolean, {nullable: true})
    error?: boolean;
}

@ObjectType()
export class CommentResponse {
    @Field(() => [Comment])
    comments: Comment[];

    @Field(() => Boolean)
    hasMore: boolean;

    @Field(() => Int)
    postId: number;
}

@ObjectType()
export class ReplyResponse {
    @Field(() => [Reply])
    replies: Reply[];

    @Field(() => Boolean)
    hasMore: boolean;

    @Field(() => Int)
    commentId: number;

    @Field(() => Int)
    postId: number;
}

@InputType()
export class UserTagInput {
    @Field(() => String)
    userString: String;

    @Field(() => Int)
    userId: number;
}