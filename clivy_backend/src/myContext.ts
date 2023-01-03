import { Response, Request} from "express";
import { Redis } from 'ioredis';
import { commentUserTagsDataLoader, replyUserTagsDataLoader } from "./utils/comment/commentUserTagsDataLoader";
import { commentLikeDataLoader, likeDataLoader, replyLikeDataLoader } from "./utils/like/likeDataLoader";
import { captionUserTagsDataLoader } from "./utils/post/captionUserTagsDataLoader";
import { fileDataLoader } from "./utils/post/fileDataLoader";
import { followDataLoader } from "./utils/user/followDataLoader";
import { userDataLoader } from "./utils/user/userDataLoader";
import { videogameGenreDataLoader, videogameGenreVideogameDataLoader } from "./utils/videogameGenre/videogameGenreDataLoader";

export type MyContext = {
    req: Request;
    res: Response;
    userId?: number;
    redis: Redis;
    fileLoader: ReturnType<typeof fileDataLoader>;
    userLoader: ReturnType<typeof userDataLoader>;
    likeLoader: ReturnType<typeof likeDataLoader>;
    commentLikeLoader: ReturnType<typeof commentLikeDataLoader>;
    replyLikeLoader: ReturnType<typeof replyLikeDataLoader>;
    followLoader: ReturnType<typeof followDataLoader>;
    commentUserTagsLoader: ReturnType<typeof commentUserTagsDataLoader>;
    replyUserTagsLoader: ReturnType<typeof replyUserTagsDataLoader>;
    captionUserTagsLoader: ReturnType<typeof captionUserTagsDataLoader>;
    videogameGenreVideogamesLoader: ReturnType<typeof videogameGenreVideogameDataLoader>;
    videogameGenreLoader: ReturnType<typeof videogameGenreDataLoader>;
}