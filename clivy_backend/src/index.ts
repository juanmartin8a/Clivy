 import express from 'express';
import { createConnection } from 'typeorm';
import cors from 'cors';
import { ApolloServer } from "apollo-server-express";
import { buildSchema } from 'type-graphql';
import http from 'http';
import { UserResolver } from './resolvers/user';
import Redis from 'ioredis';
import { MyContext } from './myContext';
import { PostResolver } from './resolvers/post';
import AWS from "aws-sdk";
import { graphqlUploadExpress } from 'graphql-upload';
import { fileDataLoader } from './utils/post/fileDataLoader';
import { userDataLoader } from './utils/user/userDataLoader';
import { getUserIdFromToken } from './utils/main/getUser';
import { commentLikeDataLoader, likeDataLoader, replyLikeDataLoader } from './utils/like/likeDataLoader';
import { CommentResolver, CommentUserTagResolver } from './resolvers/comment';
import { UserSearchResolver } from './resolvers/userSearch';
import { followDataLoader } from './utils/user/followDataLoader';
import { ReplyResolver, ReplyUserTagResolver } from './resolvers/reply';
import { commentUserTagsDataLoader, replyUserTagsDataLoader } from './utils/comment/commentUserTagsDataLoader';
import { captionUserTagsDataLoader } from './utils/post/captionUserTagsDataLoader';
import { ApolloServerPluginLandingPageGraphQLPlayground } from 'apollo-server-core';
import { VideogameGenreVideogameResolver, VideogameResolver } from './resolvers/videogame';
import { videogameGenreDataLoader, videogameGenreVideogameDataLoader } from './utils/videogameGenre/videogameGenreDataLoader';
import { NotificationResolver } from './resolvers/notification';

const main = async () => {
	await createConnection();
	
	const app = express();
	const httpServer = http.createServer(app);

	const redis = new Redis();

	var credentials = new AWS.SharedIniFileCredentials({profile: 's3_access'});
 	AWS.config.credentials = credentials;

	const apolloServer = new ApolloServer({
		schema: await buildSchema({
			resolvers: [ 
				UserResolver, 
				PostResolver, 
				CommentResolver,
				ReplyResolver, 
				UserSearchResolver,
				ReplyUserTagResolver,
				CommentUserTagResolver,
				VideogameResolver,
				VideogameGenreVideogameResolver,
				NotificationResolver,
			],
			validate: false
		}),
		context: async ({ req, res }): Promise<MyContext> => ({
			req,
			res,
			redis,
			userId: await getUserIdFromToken(redis, req.headers.authorization),
			fileLoader: fileDataLoader(),
			userLoader: userDataLoader(),
			likeLoader: likeDataLoader(),
			commentLikeLoader: commentLikeDataLoader(),
			replyLikeLoader: replyLikeDataLoader(),
			followLoader: followDataLoader(),
			commentUserTagsLoader: commentUserTagsDataLoader(),
			replyUserTagsLoader: replyUserTagsDataLoader(),
			captionUserTagsLoader: captionUserTagsDataLoader(),
			videogameGenreVideogamesLoader: videogameGenreVideogameDataLoader(),
			videogameGenreLoader: videogameGenreDataLoader()
		}),
		plugins: [
			ApolloServerPluginLandingPageGraphQLPlayground(),
		],
		// uploads: false
	});

	await apolloServer.start()

	app.use(graphqlUploadExpress({ maxFileSize: 1000000000000, maxFiles: 10 }));

	apolloServer.applyMiddleware({
		app,
		cors: false,
	});
	
	app.use(cors({}));

	httpServer.listen(4002, () => {
		console.log('server started at localhost:4002')
	});

}

main().catch(err => {
	console.log("Error: " + err);
});