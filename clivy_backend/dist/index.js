"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const typeorm_1 = require("typeorm");
const cors_1 = __importDefault(require("cors"));
const apollo_server_express_1 = require("apollo-server-express");
const type_graphql_1 = require("type-graphql");
const http_1 = __importDefault(require("http"));
const user_1 = require("./resolvers/user");
const ioredis_1 = __importDefault(require("ioredis"));
const post_1 = require("./resolvers/post");
const aws_sdk_1 = __importDefault(require("aws-sdk"));
const graphql_upload_1 = require("graphql-upload");
const fileDataLoader_1 = require("./utils/post/fileDataLoader");
const userDataLoader_1 = require("./utils/user/userDataLoader");
const getUser_1 = require("./utils/main/getUser");
const likeDataLoader_1 = require("./utils/like/likeDataLoader");
const comment_1 = require("./resolvers/comment");
const userSearch_1 = require("./resolvers/userSearch");
const followDataLoader_1 = require("./utils/user/followDataLoader");
const reply_1 = require("./resolvers/reply");
const commentUserTagsDataLoader_1 = require("./utils/comment/commentUserTagsDataLoader");
const captionUserTagsDataLoader_1 = require("./utils/post/captionUserTagsDataLoader");
const apollo_server_core_1 = require("apollo-server-core");
const videogame_1 = require("./resolvers/videogame");
const videogameGenreDataLoader_1 = require("./utils/videogameGenre/videogameGenreDataLoader");
const notification_1 = require("./resolvers/notification");
const main = () => __awaiter(void 0, void 0, void 0, function* () {
    yield (0, typeorm_1.createConnection)();
    const app = (0, express_1.default)();
    const httpServer = http_1.default.createServer(app);
    const redis = new ioredis_1.default();
    var credentials = new aws_sdk_1.default.SharedIniFileCredentials({ profile: 's3_access' });
    aws_sdk_1.default.config.credentials = credentials;
    const apolloServer = new apollo_server_express_1.ApolloServer({
        schema: yield (0, type_graphql_1.buildSchema)({
            resolvers: [
                user_1.UserResolver,
                post_1.PostResolver,
                comment_1.CommentResolver,
                reply_1.ReplyResolver,
                userSearch_1.UserSearchResolver,
                reply_1.ReplyUserTagResolver,
                comment_1.CommentUserTagResolver,
                videogame_1.VideogameResolver,
                videogame_1.VideogameGenreVideogameResolver,
                notification_1.NotificationResolver,
            ],
            validate: false
        }),
        context: ({ req, res }) => __awaiter(void 0, void 0, void 0, function* () {
            return ({
                req,
                res,
                redis,
                userId: yield (0, getUser_1.getUserIdFromToken)(redis, req.headers.authorization),
                fileLoader: (0, fileDataLoader_1.fileDataLoader)(),
                userLoader: (0, userDataLoader_1.userDataLoader)(),
                likeLoader: (0, likeDataLoader_1.likeDataLoader)(),
                commentLikeLoader: (0, likeDataLoader_1.commentLikeDataLoader)(),
                replyLikeLoader: (0, likeDataLoader_1.replyLikeDataLoader)(),
                followLoader: (0, followDataLoader_1.followDataLoader)(),
                commentUserTagsLoader: (0, commentUserTagsDataLoader_1.commentUserTagsDataLoader)(),
                replyUserTagsLoader: (0, commentUserTagsDataLoader_1.replyUserTagsDataLoader)(),
                captionUserTagsLoader: (0, captionUserTagsDataLoader_1.captionUserTagsDataLoader)(),
                videogameGenreVideogamesLoader: (0, videogameGenreDataLoader_1.videogameGenreVideogameDataLoader)(),
                videogameGenreLoader: (0, videogameGenreDataLoader_1.videogameGenreDataLoader)()
            });
        }),
        plugins: [
            (0, apollo_server_core_1.ApolloServerPluginLandingPageGraphQLPlayground)(),
        ],
    });
    yield apolloServer.start();
    app.use((0, graphql_upload_1.graphqlUploadExpress)({ maxFileSize: 1000000000000, maxFiles: 10 }));
    apolloServer.applyMiddleware({
        app,
        cors: false,
    });
    app.use((0, cors_1.default)({}));
    httpServer.listen(4002, () => {
        console.log('server started at localhost:4002');
    });
});
main().catch(err => {
    console.log("Error: " + err);
});
//# sourceMappingURL=index.js.map