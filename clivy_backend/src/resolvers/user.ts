import { validateRegister, validateSignIn, validateUserFields } from "../utils/user/validateInput";
import { Arg, Ctx, FieldResolver, Int, Mutation, Query, Resolver, Root, UseMiddleware } from "type-graphql";
import { User } from "../entities/User";
import argon2 from 'argon2';
import { getConnection } from "typeorm";
import { PaginatedFollow, RegisterInput, SignInInput, UserMutationResponse, UserUpdateInput } from "../utils/user/userInput";
import { MyContext } from "../myContext";
import { DeviceInput, FileResponse, TokenResponse } from "../utils/global/globalInput";
import { getUserPayloadFromToken } from "../utils/main/getUser";
import { createTokens } from "../utils/global/createTokens";
import { invalidateJWT } from "../utils/user/invalidateJWT";
import { isAuth } from "../middleware/isAuth";
import { generateUpdateUserSQL } from "../utils/user/generateUpdateUserSQL";
import { FileUpload, GraphQLUpload } from "graphql-upload";
import { uploadFileProcess } from "../utils/global/uploadImage";
import { addUserToElastic, searchForUsers, updateUser } from "../utils/user/createElasticUser";
import { UserSearch } from "../entities/UserSearches";
import { Follow } from "../entities/Follow";
import { LikeResponse } from "../utils/post/postInput";
import { DeviceToken, Platforms } from "../entities/DeviceToken";
import { sendEmail } from "../utils/global/sendEmail";
import { signInFunc } from "../utils/user/signIn";
import { changePassword } from "../utils/user/changePassword";
import { VideogameGenreVideogame } from "../entities/VideogameGenreVideogame";
import { VideogameUserPreferences } from "../entities/VideogameUserPreferences";
import { VideogameGenreUserPreferences } from "../entities/VideogameGenreUserPreferences";
import { v4 as uuid } from 'uuid';

@Resolver(User)
export class UserResolver {

	@FieldResolver(() => Follow)
  async followState(
    @Root() user: User,
		@Ctx() { followLoader, userId }: MyContext
  ) {
		if (!userId || userId === undefined) {
			console.log('sapotoro');
      return null;
    }

		const follow = await followLoader.load({
      followerId: userId,
      followingId: user.id!
    });

    return follow ? true : false;
  }
	
	@FieldResolver(() => FileResponse)
	file(
		@Root() user: User,
		@Ctx() { fileLoader }: MyContext
	) {
		return fileLoader.load(user.file_key);
	}

	@FieldResolver(() => FileResponse)
	smallFile(
		@Root() user: User,
		@Ctx() { fileLoader }: MyContext
	) {
		console.log(user);
		console.log(user.small_file_key);
		return fileLoader.load(user.small_file_key);
	}

	@Mutation(() => UserMutationResponse)
	async register(
		@Arg("input", () => RegisterInput) input: RegisterInput,
		// @Arg("deviceToken", () => String, {nullable: true}) deviceToken: string,
		@Arg("deviceInput", () => DeviceInput) deviceInput: DeviceInput
		//@Ctx() {req, userId: user_id}: MyContext
	): Promise<UserMutationResponse> {

		const errors = await validateRegister(input);

		if (errors.length > 0) {
			return {
				errors: errors
			};
		}

		const hashPassword = await argon2.hash(input.password);

		let user;

		const defaultProfileImg = 'user/default-profile-img.jpg?v=0';
		const smallDefaultProfileImg = 'userSmall/default-profile-img.jpg?v=0';

		const birthday = new Date(parseInt(input.birthday));

		const result: User[] = await getConnection().query(`
			insert into "user" (name, username, email, password, file_key, small_file_key, birthday)
			values ($1, $2, $3, $4, $5, $6, $7)
			returning *
		`, [input.name, input.username, input.email, hashPassword, defaultProfileImg, smallDefaultProfileImg, birthday]);
		// await getConnection().transaction(async (tm) => {

		user = result[0];

		if (deviceInput.deviceToken) {
			// const deviceTokenData = await DeviceToken.findOne({where: {
			// 	// device_uuid: deviceInput.deviceUUID,
			// 	device_token: deviceInput.deviceToken,
			// 	user_id: user.id,
			// }})
			// if (!deviceTokenData) {
				// const endpointARN = await	createPlatformEndpoint(deviceInput.deviceToken)
				// if (endpointARN) {
			await getConnection().query(`
				insert into "device_token" ("user_id", "token", "platform")
				values ($1, $2, $3)
			`, [
				user.id, 
				deviceInput.deviceToken, 
				deviceInput.platformIsIOS == true 
					? Platforms.iOS 
					: Platforms.Android
			]);
				// }
			// } else {
			// 	// await deletePlatformEndpoint(deviceTokenData.endpoint_arn)
			// 	// const endpointARN = await	createPlatformEndpoint(deviceInput.deviceToken)
			// 	// if (endpointARN) {
			// 		await getConnection().query(`
			// 			update "device"
			// 			set "endpoint_arn" = $1,
			// 				"user_id" = $2
			// 				"device_token" = $3
			// 			where device_uuid = $4
			// 		`, [
			// 			endpointARN, user!.id, deviceInput.deviceToken, deviceInput.deviceUUID
			// 		]);
			// 	}
			// }
		}

		await addUserToElastic(result[0]);

		const payload = {
      id: `${(user as User).id}`,
      username: (user as User).username,
      roles: ['user'],
    }

		const {accessToken, refreshToken} = await createTokens(payload);

		return {
			user: user,
			tokens: {
				accessToken: accessToken,
				refreshToken: refreshToken
			}
		}
	}

	@Mutation(() => UserMutationResponse)
	async signIn(
		@Arg("input", () => SignInInput) input: SignInInput,
		@Arg("deviceInput", () => DeviceInput) deviceInput: DeviceInput
	): Promise<UserMutationResponse> {

		const {errors, user} = await validateSignIn(input);

		if (errors.length > 0 && !user) {
			return {
				errors: errors
			};
		}

		// console.log("sign in");

		// console.log(deviceInput.deviceToken);

		// if (deviceInput.deviceToken) {
		// 	console.log(deviceInput.deviceToken);
		// 	const deviceToken = await DeviceToken.findOne({where: {
		// 		token: deviceInput.deviceToken,
		// 		user_id: user!.id, 
		// 	}});
		// 	if (!deviceToken) {
		// 		await getConnection().query(`
		// 			insert into "device_token" ("user_id", "token", "platform")
		// 			values ($1, $2, $3)
		// 		`, [
		// 			user!.id,
		// 			deviceInput.deviceToken,
		// 			deviceInput.platformIsIOS == true
		// 				? Platforms.iOS
		// 				: Platforms.Android
		// 		]);
		// 	}
		// }

		// const payload = {
    //   id: `${(user as User).id}`,
    //   username: (user as User).username,
    //   roles: ['user'],
    // }

		// const {accessToken, refreshToken} = await createTokens(payload);
		const {accessToken, refreshToken} = await signInFunc(user!, deviceInput);

		console.log(user);

		return {
			user: user as User,
			tokens: {
				accessToken: accessToken,
				refreshToken: refreshToken
			}
		}
	}

	@Mutation(() => Boolean)
	async signOut(
		@Arg("token", () => String) token: string, //refresh token
		@Ctx() { redis, req }: MyContext //req to get access token from auth headers
	): Promise<boolean> {
		// always returns true;

		const userPayloadFromAccessToken = await getUserPayloadFromToken(redis, req.headers.authorization, false);
		const userPayloadFromRefreshToken = await getUserPayloadFromToken(redis, token, true);

		// invalidate token if it exists
		if (userPayloadFromAccessToken !== undefined) {
			await invalidateJWT(redis, userPayloadFromAccessToken, req.headers.authorization!);
		}

		if (userPayloadFromRefreshToken !== undefined) {
			await invalidateJWT(redis, userPayloadFromRefreshToken, token);
		}

		// return true
		return true;
	}

	@Query(() => User)
	@UseMiddleware(isAuth)
	async me(
		// @Arg("token", () => String, {nullable: true}) token: string,
		@Ctx() { userId }: MyContext
	) {

		// const userIdFromToken = await getUserIdFromToken(redis, token);

		// console.log(userIdFromToken)

		// if (userIdFromToken === undefined) {
		// 	throw new Error('Not Authenticated')
		// }

    const user = await User.findOne({where: {id: userId}});

    return user;
	}

	@Query(() => User, {nullable: true})
	async user(
		@Arg("userId", () => Int) userId: number
	): Promise<User> {

		const user = await getConnection().query(`
			select u.* from "user" u
			where u.id = $1
			limit 1
	`, [userId]);
		
		return user[0];
	} 

	@Query(() => [User], {nullable: true})
	//@UseMiddleware(isAuth)
	async getAllUsers() {
		const users = await getConnection().query(`
			select * from "user"
		`);
		return users;
	}

	@Mutation(() => TokenResponse)
	async refreshToken(
		@Arg("token") token: string,
		@Ctx() { redis }: MyContext
	): Promise<TokenResponse> {

		const userPayloadFromRefreshToken = await getUserPayloadFromToken(redis, token, true);

		if (userPayloadFromRefreshToken === undefined) {
			return {
				accessToken: "",
				refreshToken: "",
			};
		}

		const currentTime = Date.now();
		const timeBeforeExpire = (userPayloadFromRefreshToken as any).exp - (currentTime / 1000);

		await redis.set(`${token}`, `${token}`, 'EX', Math.round(timeBeforeExpire));

		const user = await User.findOne({where: {id: (userPayloadFromRefreshToken as any).id}});

		if (!user) {
			return {
				accessToken: "",
				refreshToken: "",
			}; 
		}

		const payload = {
			id: `${user.id}`,
			username: user.username,
			roles: ['user'],
		}

		const {accessToken, refreshToken} = await createTokens(payload);

		return {
			accessToken: accessToken,
			refreshToken: refreshToken,
		};
	}

	@Mutation(() => UserMutationResponse)
	@UseMiddleware(isAuth)
	async editUser(
		@Ctx() { userId }: MyContext,
		@Arg("input", () => UserUpdateInput) input: UserUpdateInput,
		@Arg("file", () => GraphQLUpload, {nullable: true}) file?: FileUpload,
		@Arg("smallFile", () => GraphQLUpload, {nullable: true}) smallFile?: FileUpload,
	): Promise<UserMutationResponse> {

		const user = await User.findOne({
			where: {
				id: userId
			}
		});

		if (!user) {
			return {
				errors: [{
					field: 'all',
					message: 'no user'
				}]
			}
		}

		const errors = await validateUserFields(input, userId!);

		if (errors.length > 0) {
			return {
				errors: errors
			}
		}

		let key: string;
		let smallKey: string;
		if (file && smallFile) {
			const fileKey = 'user/' + userId + '.jpg';
			const smallFileKey = 'userSmall/' + userId + '.jpg';
			let fileVersion: string = uuid();

			key = fileKey + "?v=" + fileVersion;
			const uploadFileResponse = await uploadFileProcess(file.createReadStream, fileKey, file.mimetype);
			if (uploadFileResponse?.error) {
				return {
					errors: [
						{
							field: 'file',
							message: 'could not upload file',
						}
					]//[uploadFileResponse.error]
				};
			}

			smallKey = smallFileKey + "?v=" + fileVersion;
			const uploadSmallFileResponse = await uploadFileProcess(smallFile.createReadStream, smallFileKey, smallFile.mimetype);
			if (uploadSmallFileResponse?.error) {
				return {
					errors: [
						{
							field: 'file',
							message: 'could not upload file',
						}
					]//[uploadFileResponse.error]
				};
			}
		}

		let generatedUpdates = await generateUpdateUserSQL(
			input,
			user.username,
			user.name,
			user.bio,
		);

		if (generatedUpdates === {} && !file) {
			return {
				errors: [{
					field: 'all',
					message: 'No Changes'
				}]
			}
		}
		
		const newUser = await getConnection()
		.createQueryBuilder()
		.update(User)
		.set(file && smallFile
			? {...generatedUpdates, file_key: key!, small_file_key: smallKey!} 
			: generatedUpdates
		)
		.where("id = :id", { id: userId })
		.returning('*')
		.execute();

		if (generatedUpdates.bio) {
			delete generatedUpdates.bio;
		}

		await updateUser(
			file 
				? {...generatedUpdates, file_key: key!, small_file_key: smallKey!} 
				: generatedUpdates, 
			userId!
		)

		return {
			user: newUser.raw[0]
		};
	}

	@Query(() => [User]) 
	@UseMiddleware(isAuth)
	async searchUsers(
		@Arg("search", () => String) search: string,
	): Promise<User[]> {
		const users = await searchForUsers(search);
		console.log(users)
		return users;
	}

	@Mutation(() => User, {nullable: true})
	@UseMiddleware(isAuth) 
	async userTapped(
		@Arg("id", () => Int) id: number,
		@Ctx() { userId }: MyContext
	): Promise<User | undefined> {
		const user = await User.findOne({where: {id: id}});

		if (!user) {
			return undefined;
		}

		const userSearch = await UserSearch.findOne(
			{where: { userId: userId, searchedUserId: id }}
		);

		if (userSearch) {
			await getConnection().createQueryBuilder()
			.update(UserSearch)
			.set({ updatedAt: new Date()})
			.where(
				'"userId" = :userId AND "searchedUserId" = :searchedUserId', 
				{ userId: userId, searchedUserId: id}
			)
			.execute().catch((err) => {
				console.log(err);
			});
		} else {
			await getConnection().createQueryBuilder()
			.insert()
			.into(UserSearch)
			.values({ userId: userId, searchedUserId: id })
			.execute().catch((err) => {
				console.log(err);
			});
		}

		return user!;
	}

	@Mutation(() => LikeResponse)
	@UseMiddleware(isAuth)
	async followUnfollowUser(
		@Arg("followUserId", () => Int) followUserId: number,
		@Arg("clientId") clientId: string,
		@Ctx() { userId }: MyContext
	): Promise<LikeResponse> {

		const follow = await Follow.findOne({where: {
			followerId: userId,
			followingId: followUserId
		}});

		// console.log("sapo: " + userFollows);

		if (!follow) {
			if (userId != followUserId) {
				await getConnection().createQueryBuilder()
				.insert()
				.into(Follow)
				.values({ followerId: userId, followingId: followUserId })
				.execute()
			}
		} else {
			await Follow.remove(follow)
		}

		return {
			value:  follow ? -1 : 1,
			clientId: clientId
		};
	}

	@Mutation(() => Boolean)
	async sendResetPasswordEmail(
		@Arg("email", () => String) email: string,
		// @Arg("uuid", () => String) uuid: string,
		@Ctx() { redis }: MyContext,
	) {
		const user = await User.findOne({
			where: {
				email: email	
			}
		});

		if (user) {
			const code = Math.random().toString().substring(2, 8);
			await redis.set(
				user.id.toString(),
				code,
				"EX",
				1000 * 60 * 15 // 15 mins
			);
			sendEmail(
				user.email,
				"Password Change",
				"/Users/juanma/development/flutter/release-untitled-startup/untitled_server/src/views/forgotEmail.html",
				{
					username: user.username,
					code: code
				}
			);
			
			return true;
		}

		return true
	}

	@Query(() => Boolean)
	async verifyResetCode(
		@Arg("email", () => String) email: string,
		@Arg("code", () => String) code: string,
		@Ctx() { redis }: MyContext
	): Promise<boolean> {
		const user = await User.findOne({
			where: {
				email: email	
			}
		});

		if (user) {
			let codeIsValid = false;
			await redis.get(user.id.toString(), (err, res) => {
				if (err || (typeof res) === null) {
					console.log("expired");
				} else {
					console.log(res);
					if (res === code) {
						console.log("code is valid")
						codeIsValid = true;
					} else {
						console.log("invalid");
					}
				}
			});

			if (codeIsValid) {
				return true;
			}
		}

		return false;
	}

	@Mutation(() => UserMutationResponse)	
	async changePasswordAndSignIn(
		@Arg("deviceInput", () => DeviceInput) deviceInput: DeviceInput,
		@Arg("email", () => String) email: string,
		@Arg("code", () => String) code: string,
		@Arg("newPassword", () => String) newPassword: string,
		@Ctx() { redis }: MyContext
	): Promise<UserMutationResponse> {
		const user = await User.findOne({
			where: {
				email: email
			}
		})

		if (!user) {
			return {
				errors: [
					{
						field: 'newPassword',
						message: 'user does not exist'
          }
        ]
			};
		}
		
		let codeIsValid;
		await redis.get(user.id.toString(), (err, res) => {
			if (err || (typeof res) === null) {
				console.log("expired");
			} else {
				console.log(res);
				console.log(code)
				if (res === code) {
					console.log("code is valid")
					codeIsValid = true;
				} else {
					console.log("invalid");
				}
			}
		});
		if (codeIsValid) {
			const errors = await changePassword(user!, newPassword)
			if (errors.length > 0) {
				return {
					errors: errors
				}
			}
			const {accessToken, refreshToken} = await signInFunc(user!, deviceInput);
			// console.log("aaaaa");
			return {
				user: user as User,
				tokens: {
					accessToken: accessToken,
					refreshToken: refreshToken
				}
			}
		}

		return {
			errors: [
				{
					field: 'newPassword',
					message: 'code expired'
				}
			]
		}

		// change For You algorith
		// add videogame genres to ui sign up flow
		// user choces videogame genres and all videogames belonging to that genre are added to 
		// fix refresh token
		// add listener to device token changes and if it updates update the db
		// send notifications to each user once every 3 days if error 410 then erase from db
		
		// edit user screen fix
		// configurations ui && ux
		// add 50 videogames 
		// lower videogame thumbnail quality
		// bottom nav bar fix
		// user posts animations fix
		// profile screen improvement

	}

	@Mutation(() => Boolean)
	@UseMiddleware(isAuth)
	async addUserInterests(
		@Arg("videogameGenresIds", () => [Int]) videogameGenreIds: number[],
		@Ctx() { userId }: MyContext
	) {
		for (var i = 0; i < videogameGenreIds.length; i++) {
			const videogameUserGenre = await VideogameGenreUserPreferences.findOne({
				where: {
					user_id: userId,
					genre_id: videogameGenreIds[i]
				}
			})
			if (!videogameUserGenre) {
				await getConnection().query(`
					insert into videogame_genre_user_preferences ("user_id", "genre_id", "likeCount", "viewCount")
					values ($1, $2, $3, $4)
				`, [userId, videogameGenreIds[i], 20, 20]);
			}
			const videogames = await VideogameGenreVideogame.find({
				where: {
					videogame_genre_id: videogameGenreIds[i]
				}
			});

			for (var j = 0; j < videogames.length; j++) {
				const videogameUserPref = await VideogameUserPreferences.findOne(
          {where: {
            user_id: userId,
            videogame_id: videogames[j].videogame_id
          }}
        );
				if (videogameUserPref) {
					await getConnection().query(`
						update videogame_user_preferences
						set "viewCount" = "viewCount" + 5,
							"likeCount" = "likeCount" + 5
						where "user_id" = $1 and "videogame_id" = $2
					`, [
						userId, 
						videogames[j].videogame_id
					]);
				} else {
					await getConnection().query(`
						insert into videogame_user_preferences ("user_id", "videogame_id", "likeCount", "viewCount")
						values ($1, $2, $3, $4)
					`, [userId, videogames[j].videogame_id, 20, 20]);
				}
			}
		}
		
		return true;
	}

	@Mutation(() => Boolean)
	@UseMiddleware(isAuth)
	async addNewDeviceToken(
		@Arg("deviceInput", () => DeviceInput) deviceInput: DeviceInput,
		@Ctx() { userId }: MyContext
	) {
		const deviceToken = await DeviceToken.findOne({
			where: {
				user_id: userId,
				token: deviceInput.deviceToken
			}
		});
		if (!deviceToken) {
			await getConnection().query(`
				insert into "device_token" ("user_id", "token", "platform")
				values ($1, $2, $3)
			`, [
				userId, 
				deviceInput.deviceToken,
				deviceInput.platformIsIOS == true
					? Platforms.iOS
					: Platforms.Android
			]);
		}

		return true
	}

	@Query(() => PaginatedFollow)
	@UseMiddleware(isAuth)
	async userFollowers(
		@Arg("followUserId", () => Int) followUserId: number,
		@Arg("idsList", () => [Int]) idsList: number[],
		@Arg("limit", () => Int) limit: number,
		@Arg("cursor", () => String, {nullable: true}) cursor: string,
		@Ctx() { userId }: MyContext
	): Promise<PaginatedFollow> {
		const realLimit = Math.min(20, limit);
		const realLimitLength = realLimit + 1;

		const cursorArray: any[] = [followUserId, userId, idsList, realLimitLength];
		
		if (cursor) {
			cursorArray.push(new Date(parseInt(cursor)));
		}

		const users = await getConnection().query(`
			select u.* from "user" u

			left join "follow" f
				on f."followerId" = u.id
				and f."followingId" = $1

			left join "follow" ff
				on ff."followerId" = f."followingId"
				and ff."followingId" = $2

			where 
				f is not null
				and not (u.id = ANY ($3))
				${cursor ? `and date_trunc('millisecond', (f."createdAt" at time zone 'utc')) > date_trunc('millisecond', ($5::timestamptz at time zone 'utc'))` : ""}

			order by (ff is not null) desc,
				f."createdAt" desc
			
			limit $4;
			
		`, cursorArray)

		return {
			users: users.slice(0, realLimit),
			hasMore: users.length === realLimitLength,
			userId: followUserId
		};
	}

	@Query(() => PaginatedFollow)
	@UseMiddleware(isAuth)
	async userFollowing(
		@Arg("followUserId", () => Int) followUserId: number,
		@Arg("idsList", () => [Int]) idsList: number[],
		@Arg("limit", () => Int) limit: number,
		@Arg("cursor", () => String, {nullable: true}) cursor: string,
		@Ctx() { userId }: MyContext
	): Promise<PaginatedFollow> {
		const realLimit = Math.min(20, limit);
		const realLimitLength = realLimit + 1;

		const cursorArray: any[] = [followUserId, userId, idsList, realLimitLength];
		
		if (cursor) {
			cursorArray.push(new Date(parseInt(cursor)));
		}

		const users = await getConnection().query(`
			select u.* from "user" u

			left join "follow" f
				on (f."followingId" = u.id)
				and (f."followerId" = $1)

			left join "follow" ff
				on ff."followerId" = $2
				and ff."followingId" = f."followingId"

			where 
				f is not null
				and not (u.id = ANY ($3))
				${cursor ? `and date_trunc('millisecond', (f."createdAt" at time zone 'utc')) > date_trunc('millisecond', ($5::timestamptz at time zone 'utc'))` : ""}

			order by (ff is not null) desc,
				f."createdAt" desc
			
			limit $4;
			
		`, cursorArray)

		return {
			users: users.slice(0, realLimit),
			hasMore: users.length === realLimitLength,
			userId: followUserId
		};
	}

	@Mutation(() => Boolean)
	@UseMiddleware(isAuth)
	async deleteUser(
		@Ctx() { userId }: MyContext
	) {
		const user = await User.find({
			where: {
				id: userId
			}
		});

		await User.remove(user);

		return true;
	}

	// @Query(() => PaginatedFollow)
	// @UseMiddleware(isAuth)
	// async followingList(
	// 	@Arg("selectedUserId", () => Int) selectedUserId: number,
	// 	@Arg("idsList", () => [Int]) idsList: number[],
	// 	@Arg("limit", () => Int) limit: number,
	// 	@Arg("cursor", () => String, {nullable: true}) cursor: string,
	// 	@Ctx() { userId }: MyContext
	// ): Promise<PaginatedFollow> {
	// 	const realLimit = Math.min(20, limit);
	// 	const realLimitLength = realLimit + 1;

	// 	const cursorArray: any[] = [selectedUserId, userId, idsList, realLimitLength];
		
	// 	const following = await getConnection().query(`
	// 		select u.* from "user" u

	// 		left join "follow" f
	// 			on (f."followingId" = u.id)
	// 			and (f."followerId" = $1)

	// 		left join "follow" ff
	// 			on ff."followerId" = $2
	// 			and ff."followingId" = f."followingId"

	// 		where 
	// 			f is not null
	// 			and not (u.id = ANY ($3))
	// 			and date_trunc('millisecond', (f."createdAt" at time zone 'utc')) > date_trunc('millisecond', ($3::timestamptz at time zone 'utc'))

	// 		order by (ff is not null) desc,
	// 			f."createdAt" desc
			
	// 		limit $4
			
	// 	`, cursorArray)

	// 	console.log(following);

	// 	return {
	// 		users: following.slice(0, realLimit),
	// 		hasMore: following.length === realLimitLength,
	// 		userId: selectedUserId
	// 	};
	// }

	// @Query(() => PaginatedFollow)
	// @UseMiddleware(isAuth)
	// async followersList(
	// 	@Arg("selectedUserId", () => Int) selectedUserId: number,
	// 	@Arg("idsList", () => [Int]) idsList: number[],
	// 	@Arg("limit", () => Int) limit: number,
	// 	@Ctx() { userId }: MyContext
	// ): Promise<PaginatedFollow> {
	// 	const realLimit = Math.min(20, limit);
	// 	const realLimitLength = realLimit + 1;

	// 	const cursorArray: any[] = [selectedUserId, userId, idsList, realLimitLength];

	// 	const followers = await getConnection().query(`
	// 		select u.* from "user" u

	// 		left join "follow" f
	// 			on f."followerId" = u.id
	// 			and f."followingId" = $1

	// 		left join "follow" ff
	// 			on ff."followerId" = f."followingId"
	// 			and ff."followingId" = $2

	// 		where 
	// 			f is not null
	// 			and not (u.id = ANY ($3))

	// 		order by (ff is not null) desc,
	// 			f."createdAt" desc
			
	// 		limit $4
			
	// 	`, cursorArray)

	// 	return {
	// 		users: followers.slice(0, realLimit),
	// 		hasMore: followers.length === realLimitLength,
	// 		userId: selectedUserId
	// 	};
	// }

}