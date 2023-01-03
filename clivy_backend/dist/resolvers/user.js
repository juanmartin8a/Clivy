"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
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
exports.UserResolver = void 0;
const validateInput_1 = require("../utils/user/validateInput");
const type_graphql_1 = require("type-graphql");
const User_1 = require("../entities/User");
const argon2_1 = __importDefault(require("argon2"));
const typeorm_1 = require("typeorm");
const userInput_1 = require("../utils/user/userInput");
const globalInput_1 = require("../utils/global/globalInput");
const getUser_1 = require("../utils/main/getUser");
const createTokens_1 = require("../utils/global/createTokens");
const invalidateJWT_1 = require("../utils/user/invalidateJWT");
const isAuth_1 = require("../middleware/isAuth");
const generateUpdateUserSQL_1 = require("../utils/user/generateUpdateUserSQL");
const graphql_upload_1 = require("graphql-upload");
const uploadImage_1 = require("../utils/global/uploadImage");
const createElasticUser_1 = require("../utils/user/createElasticUser");
const UserSearches_1 = require("../entities/UserSearches");
const Follow_1 = require("../entities/Follow");
const postInput_1 = require("../utils/post/postInput");
const DeviceToken_1 = require("../entities/DeviceToken");
const sendEmail_1 = require("../utils/global/sendEmail");
const signIn_1 = require("../utils/user/signIn");
const changePassword_1 = require("../utils/user/changePassword");
const VideogameGenreVideogame_1 = require("../entities/VideogameGenreVideogame");
const VideogameUserPreferences_1 = require("../entities/VideogameUserPreferences");
const VideogameGenreUserPreferences_1 = require("../entities/VideogameGenreUserPreferences");
const uuid_1 = require("uuid");
let UserResolver = class UserResolver {
    followState(user, { followLoader, userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!userId || userId === undefined) {
                console.log('sapotoro');
                return null;
            }
            const follow = yield followLoader.load({
                followerId: userId,
                followingId: user.id
            });
            return follow ? true : false;
        });
    }
    file(user, { fileLoader }) {
        return fileLoader.load(user.file_key);
    }
    smallFile(user, { fileLoader }) {
        console.log(user);
        console.log(user.small_file_key);
        return fileLoader.load(user.small_file_key);
    }
    register(input, deviceInput) {
        return __awaiter(this, void 0, void 0, function* () {
            const errors = yield (0, validateInput_1.validateRegister)(input);
            if (errors.length > 0) {
                return {
                    errors: errors
                };
            }
            const hashPassword = yield argon2_1.default.hash(input.password);
            let user;
            const defaultProfileImg = 'user/default-profile-img.jpg?v=0';
            const smallDefaultProfileImg = 'userSmall/default-profile-img.jpg?v=0';
            const birthday = new Date(parseInt(input.birthday));
            const result = yield (0, typeorm_1.getConnection)().query(`
			insert into "user" (name, username, email, password, file_key, small_file_key, birthday)
			values ($1, $2, $3, $4, $5, $6, $7)
			returning *
		`, [input.name, input.username, input.email, hashPassword, defaultProfileImg, smallDefaultProfileImg, birthday]);
            user = result[0];
            if (deviceInput.deviceToken) {
                yield (0, typeorm_1.getConnection)().query(`
				insert into "device_token" ("user_id", "token", "platform")
				values ($1, $2, $3)
			`, [
                    user.id,
                    deviceInput.deviceToken,
                    deviceInput.platformIsIOS == true
                        ? DeviceToken_1.Platforms.iOS
                        : DeviceToken_1.Platforms.Android
                ]);
            }
            yield (0, createElasticUser_1.addUserToElastic)(result[0]);
            const payload = {
                id: `${user.id}`,
                username: user.username,
                roles: ['user'],
            };
            const { accessToken, refreshToken } = yield (0, createTokens_1.createTokens)(payload);
            return {
                user: user,
                tokens: {
                    accessToken: accessToken,
                    refreshToken: refreshToken
                }
            };
        });
    }
    signIn(input, deviceInput) {
        return __awaiter(this, void 0, void 0, function* () {
            const { errors, user } = yield (0, validateInput_1.validateSignIn)(input);
            if (errors.length > 0 && !user) {
                return {
                    errors: errors
                };
            }
            const { accessToken, refreshToken } = yield (0, signIn_1.signInFunc)(user, deviceInput);
            console.log(user);
            return {
                user: user,
                tokens: {
                    accessToken: accessToken,
                    refreshToken: refreshToken
                }
            };
        });
    }
    signOut(token, { redis, req }) {
        return __awaiter(this, void 0, void 0, function* () {
            const userPayloadFromAccessToken = yield (0, getUser_1.getUserPayloadFromToken)(redis, req.headers.authorization, false);
            const userPayloadFromRefreshToken = yield (0, getUser_1.getUserPayloadFromToken)(redis, token, true);
            if (userPayloadFromAccessToken !== undefined) {
                yield (0, invalidateJWT_1.invalidateJWT)(redis, userPayloadFromAccessToken, req.headers.authorization);
            }
            if (userPayloadFromRefreshToken !== undefined) {
                yield (0, invalidateJWT_1.invalidateJWT)(redis, userPayloadFromRefreshToken, token);
            }
            return true;
        });
    }
    me({ userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield User_1.User.findOne({ where: { id: userId } });
            return user;
        });
    }
    user(userId) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield (0, typeorm_1.getConnection)().query(`
			select u.* from "user" u
			where u.id = $1
			limit 1
	`, [userId]);
            return user[0];
        });
    }
    getAllUsers() {
        return __awaiter(this, void 0, void 0, function* () {
            const users = yield (0, typeorm_1.getConnection)().query(`
			select * from "user"
		`);
            return users;
        });
    }
    refreshToken(token, { redis }) {
        return __awaiter(this, void 0, void 0, function* () {
            const userPayloadFromRefreshToken = yield (0, getUser_1.getUserPayloadFromToken)(redis, token, true);
            if (userPayloadFromRefreshToken === undefined) {
                return {
                    accessToken: "",
                    refreshToken: "",
                };
            }
            const currentTime = Date.now();
            const timeBeforeExpire = userPayloadFromRefreshToken.exp - (currentTime / 1000);
            yield redis.set(`${token}`, `${token}`, 'EX', Math.round(timeBeforeExpire));
            const user = yield User_1.User.findOne({ where: { id: userPayloadFromRefreshToken.id } });
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
            };
            const { accessToken, refreshToken } = yield (0, createTokens_1.createTokens)(payload);
            return {
                accessToken: accessToken,
                refreshToken: refreshToken,
            };
        });
    }
    editUser({ userId }, input, file, smallFile) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield User_1.User.findOne({
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
                };
            }
            const errors = yield (0, validateInput_1.validateUserFields)(input, userId);
            if (errors.length > 0) {
                return {
                    errors: errors
                };
            }
            let key;
            let smallKey;
            if (file && smallFile) {
                const fileKey = 'user/' + userId + '.jpg';
                const smallFileKey = 'userSmall/' + userId + '.jpg';
                let fileVersion = (0, uuid_1.v4)();
                key = fileKey + "?v=" + fileVersion;
                const uploadFileResponse = yield (0, uploadImage_1.uploadFileProcess)(file.createReadStream, fileKey, file.mimetype);
                if (uploadFileResponse === null || uploadFileResponse === void 0 ? void 0 : uploadFileResponse.error) {
                    return {
                        errors: [
                            {
                                field: 'file',
                                message: 'could not upload file',
                            }
                        ]
                    };
                }
                smallKey = smallFileKey + "?v=" + fileVersion;
                const uploadSmallFileResponse = yield (0, uploadImage_1.uploadFileProcess)(smallFile.createReadStream, smallFileKey, smallFile.mimetype);
                if (uploadSmallFileResponse === null || uploadSmallFileResponse === void 0 ? void 0 : uploadSmallFileResponse.error) {
                    return {
                        errors: [
                            {
                                field: 'file',
                                message: 'could not upload file',
                            }
                        ]
                    };
                }
            }
            let generatedUpdates = yield (0, generateUpdateUserSQL_1.generateUpdateUserSQL)(input, user.username, user.name, user.bio);
            if (generatedUpdates === {} && !file) {
                return {
                    errors: [{
                            field: 'all',
                            message: 'No Changes'
                        }]
                };
            }
            const newUser = yield (0, typeorm_1.getConnection)()
                .createQueryBuilder()
                .update(User_1.User)
                .set(file && smallFile
                ? Object.assign(Object.assign({}, generatedUpdates), { file_key: key, small_file_key: smallKey }) : generatedUpdates)
                .where("id = :id", { id: userId })
                .returning('*')
                .execute();
            if (generatedUpdates.bio) {
                delete generatedUpdates.bio;
            }
            yield (0, createElasticUser_1.updateUser)(file
                ? Object.assign(Object.assign({}, generatedUpdates), { file_key: key, small_file_key: smallKey }) : generatedUpdates, userId);
            return {
                user: newUser.raw[0]
            };
        });
    }
    searchUsers(search) {
        return __awaiter(this, void 0, void 0, function* () {
            const users = yield (0, createElasticUser_1.searchForUsers)(search);
            console.log(users);
            return users;
        });
    }
    userTapped(id, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield User_1.User.findOne({ where: { id: id } });
            if (!user) {
                return undefined;
            }
            const userSearch = yield UserSearches_1.UserSearch.findOne({ where: { userId: userId, searchedUserId: id } });
            if (userSearch) {
                yield (0, typeorm_1.getConnection)().createQueryBuilder()
                    .update(UserSearches_1.UserSearch)
                    .set({ updatedAt: new Date() })
                    .where('"userId" = :userId AND "searchedUserId" = :searchedUserId', { userId: userId, searchedUserId: id })
                    .execute().catch((err) => {
                    console.log(err);
                });
            }
            else {
                yield (0, typeorm_1.getConnection)().createQueryBuilder()
                    .insert()
                    .into(UserSearches_1.UserSearch)
                    .values({ userId: userId, searchedUserId: id })
                    .execute().catch((err) => {
                    console.log(err);
                });
            }
            return user;
        });
    }
    followUnfollowUser(followUserId, clientId, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const follow = yield Follow_1.Follow.findOne({ where: {
                    followerId: userId,
                    followingId: followUserId
                } });
            if (!follow) {
                if (userId != followUserId) {
                    yield (0, typeorm_1.getConnection)().createQueryBuilder()
                        .insert()
                        .into(Follow_1.Follow)
                        .values({ followerId: userId, followingId: followUserId })
                        .execute();
                }
            }
            else {
                yield Follow_1.Follow.remove(follow);
            }
            return {
                value: follow ? -1 : 1,
                clientId: clientId
            };
        });
    }
    sendResetPasswordEmail(email, { redis }) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield User_1.User.findOne({
                where: {
                    email: email
                }
            });
            if (user) {
                const code = Math.random().toString().substring(2, 8);
                yield redis.set(user.id.toString(), code, "EX", 1000 * 60 * 15);
                (0, sendEmail_1.sendEmail)(user.email, "Password Change", "/Users/juanma/development/flutter/release-untitled-startup/untitled_server/src/views/forgotEmail.html", {
                    username: user.username,
                    code: code
                });
                return true;
            }
            return true;
        });
    }
    verifyResetCode(email, code, { redis }) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield User_1.User.findOne({
                where: {
                    email: email
                }
            });
            if (user) {
                let codeIsValid = false;
                yield redis.get(user.id.toString(), (err, res) => {
                    if (err || (typeof res) === null) {
                        console.log("expired");
                    }
                    else {
                        console.log(res);
                        if (res === code) {
                            console.log("code is valid");
                            codeIsValid = true;
                        }
                        else {
                            console.log("invalid");
                        }
                    }
                });
                if (codeIsValid) {
                    return true;
                }
            }
            return false;
        });
    }
    changePasswordAndSignIn(deviceInput, email, code, newPassword, { redis }) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield User_1.User.findOne({
                where: {
                    email: email
                }
            });
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
            yield redis.get(user.id.toString(), (err, res) => {
                if (err || (typeof res) === null) {
                    console.log("expired");
                }
                else {
                    console.log(res);
                    console.log(code);
                    if (res === code) {
                        console.log("code is valid");
                        codeIsValid = true;
                    }
                    else {
                        console.log("invalid");
                    }
                }
            });
            if (codeIsValid) {
                const errors = yield (0, changePassword_1.changePassword)(user, newPassword);
                if (errors.length > 0) {
                    return {
                        errors: errors
                    };
                }
                const { accessToken, refreshToken } = yield (0, signIn_1.signInFunc)(user, deviceInput);
                return {
                    user: user,
                    tokens: {
                        accessToken: accessToken,
                        refreshToken: refreshToken
                    }
                };
            }
            return {
                errors: [
                    {
                        field: 'newPassword',
                        message: 'code expired'
                    }
                ]
            };
        });
    }
    addUserInterests(videogameGenreIds, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            for (var i = 0; i < videogameGenreIds.length; i++) {
                const videogameUserGenre = yield VideogameGenreUserPreferences_1.VideogameGenreUserPreferences.findOne({
                    where: {
                        user_id: userId,
                        genre_id: videogameGenreIds[i]
                    }
                });
                if (!videogameUserGenre) {
                    yield (0, typeorm_1.getConnection)().query(`
					insert into videogame_genre_user_preferences ("user_id", "genre_id", "likeCount", "viewCount")
					values ($1, $2, $3, $4)
				`, [userId, videogameGenreIds[i], 20, 20]);
                }
                const videogames = yield VideogameGenreVideogame_1.VideogameGenreVideogame.find({
                    where: {
                        videogame_genre_id: videogameGenreIds[i]
                    }
                });
                for (var j = 0; j < videogames.length; j++) {
                    const videogameUserPref = yield VideogameUserPreferences_1.VideogameUserPreferences.findOne({ where: {
                            user_id: userId,
                            videogame_id: videogames[j].videogame_id
                        } });
                    if (videogameUserPref) {
                        yield (0, typeorm_1.getConnection)().query(`
						update videogame_user_preferences
						set "viewCount" = "viewCount" + 5,
							"likeCount" = "likeCount" + 5
						where "user_id" = $1 and "videogame_id" = $2
					`, [
                            userId,
                            videogames[j].videogame_id
                        ]);
                    }
                    else {
                        yield (0, typeorm_1.getConnection)().query(`
						insert into videogame_user_preferences ("user_id", "videogame_id", "likeCount", "viewCount")
						values ($1, $2, $3, $4)
					`, [userId, videogames[j].videogame_id, 20, 20]);
                    }
                }
            }
            return true;
        });
    }
    addNewDeviceToken(deviceInput, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const deviceToken = yield DeviceToken_1.DeviceToken.findOne({
                where: {
                    user_id: userId,
                    token: deviceInput.deviceToken
                }
            });
            if (!deviceToken) {
                yield (0, typeorm_1.getConnection)().query(`
				insert into "device_token" ("user_id", "token", "platform")
				values ($1, $2, $3)
			`, [
                    userId,
                    deviceInput.deviceToken,
                    deviceInput.platformIsIOS == true
                        ? DeviceToken_1.Platforms.iOS
                        : DeviceToken_1.Platforms.Android
                ]);
            }
            return true;
        });
    }
    userFollowers(followUserId, idsList, limit, cursor, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const realLimit = Math.min(20, limit);
            const realLimitLength = realLimit + 1;
            const cursorArray = [followUserId, userId, idsList, realLimitLength];
            if (cursor) {
                cursorArray.push(new Date(parseInt(cursor)));
            }
            const users = yield (0, typeorm_1.getConnection)().query(`
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
			
		`, cursorArray);
            return {
                users: users.slice(0, realLimit),
                hasMore: users.length === realLimitLength,
                userId: followUserId
            };
        });
    }
    userFollowing(followUserId, idsList, limit, cursor, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const realLimit = Math.min(20, limit);
            const realLimitLength = realLimit + 1;
            const cursorArray = [followUserId, userId, idsList, realLimitLength];
            if (cursor) {
                cursorArray.push(new Date(parseInt(cursor)));
            }
            const users = yield (0, typeorm_1.getConnection)().query(`
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
			
		`, cursorArray);
            return {
                users: users.slice(0, realLimit),
                hasMore: users.length === realLimitLength,
                userId: followUserId
            };
        });
    }
    deleteUser({ userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield User_1.User.find({
                where: {
                    id: userId
                }
            });
            yield User_1.User.remove(user);
            return true;
        });
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => Follow_1.Follow),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [User_1.User, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "followState", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => globalInput_1.FileResponse),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [User_1.User, Object]),
    __metadata("design:returntype", void 0)
], UserResolver.prototype, "file", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => globalInput_1.FileResponse),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [User_1.User, Object]),
    __metadata("design:returntype", void 0)
], UserResolver.prototype, "smallFile", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => userInput_1.UserMutationResponse),
    __param(0, (0, type_graphql_1.Arg)("input", () => userInput_1.RegisterInput)),
    __param(1, (0, type_graphql_1.Arg)("deviceInput", () => globalInput_1.DeviceInput)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [userInput_1.RegisterInput,
        globalInput_1.DeviceInput]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "register", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => userInput_1.UserMutationResponse),
    __param(0, (0, type_graphql_1.Arg)("input", () => userInput_1.SignInInput)),
    __param(1, (0, type_graphql_1.Arg)("deviceInput", () => globalInput_1.DeviceInput)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [userInput_1.SignInInput,
        globalInput_1.DeviceInput]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "signIn", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    __param(0, (0, type_graphql_1.Arg)("token", () => String)),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "signOut", null);
__decorate([
    (0, type_graphql_1.Query)(() => User_1.User),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "me", null);
__decorate([
    (0, type_graphql_1.Query)(() => User_1.User, { nullable: true }),
    __param(0, (0, type_graphql_1.Arg)("userId", () => type_graphql_1.Int)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "user", null);
__decorate([
    (0, type_graphql_1.Query)(() => [User_1.User], { nullable: true }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "getAllUsers", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => globalInput_1.TokenResponse),
    __param(0, (0, type_graphql_1.Arg)("token")),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "refreshToken", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => userInput_1.UserMutationResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Ctx)()),
    __param(1, (0, type_graphql_1.Arg)("input", () => userInput_1.UserUpdateInput)),
    __param(2, (0, type_graphql_1.Arg)("file", () => graphql_upload_1.GraphQLUpload, { nullable: true })),
    __param(3, (0, type_graphql_1.Arg)("smallFile", () => graphql_upload_1.GraphQLUpload, { nullable: true })),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, userInput_1.UserUpdateInput, Object, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "editUser", null);
__decorate([
    (0, type_graphql_1.Query)(() => [User_1.User]),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("search", () => String)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "searchUsers", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => User_1.User, { nullable: true }),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("id", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "userTapped", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => postInput_1.LikeResponse),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("followUserId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("clientId")),
    __param(2, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, String, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "followUnfollowUser", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    __param(0, (0, type_graphql_1.Arg)("email", () => String)),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "sendResetPasswordEmail", null);
__decorate([
    (0, type_graphql_1.Query)(() => Boolean),
    __param(0, (0, type_graphql_1.Arg)("email", () => String)),
    __param(1, (0, type_graphql_1.Arg)("code", () => String)),
    __param(2, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "verifyResetCode", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => userInput_1.UserMutationResponse),
    __param(0, (0, type_graphql_1.Arg)("deviceInput", () => globalInput_1.DeviceInput)),
    __param(1, (0, type_graphql_1.Arg)("email", () => String)),
    __param(2, (0, type_graphql_1.Arg)("code", () => String)),
    __param(3, (0, type_graphql_1.Arg)("newPassword", () => String)),
    __param(4, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [globalInput_1.DeviceInput, String, String, String, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "changePasswordAndSignIn", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("videogameGenresIds", () => [type_graphql_1.Int])),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Array, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "addUserInterests", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("deviceInput", () => globalInput_1.DeviceInput)),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [globalInput_1.DeviceInput, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "addNewDeviceToken", null);
__decorate([
    (0, type_graphql_1.Query)(() => userInput_1.PaginatedFollow),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("followUserId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("idsList", () => [type_graphql_1.Int])),
    __param(2, (0, type_graphql_1.Arg)("limit", () => type_graphql_1.Int)),
    __param(3, (0, type_graphql_1.Arg)("cursor", () => String, { nullable: true })),
    __param(4, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Array, Number, String, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "userFollowers", null);
__decorate([
    (0, type_graphql_1.Query)(() => userInput_1.PaginatedFollow),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("followUserId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Arg)("idsList", () => [type_graphql_1.Int])),
    __param(2, (0, type_graphql_1.Arg)("limit", () => type_graphql_1.Int)),
    __param(3, (0, type_graphql_1.Arg)("cursor", () => String, { nullable: true })),
    __param(4, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Array, Number, String, Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "userFollowing", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], UserResolver.prototype, "deleteUser", null);
UserResolver = __decorate([
    (0, type_graphql_1.Resolver)(User_1.User)
], UserResolver);
exports.UserResolver = UserResolver;
//# sourceMappingURL=user.js.map