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
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserSearchResolver = void 0;
const UserSearches_1 = require("../entities/UserSearches");
const type_graphql_1 = require("type-graphql");
const User_1 = require("../entities/User");
const typeorm_1 = require("typeorm");
const isAuth_1 = require("../middleware/isAuth");
let UserSearchResolver = class UserSearchResolver {
    user(userSearch, { userLoader }) {
        return userLoader.load(userSearch.userId);
    }
    searchedUser(userSearch, { userLoader }) {
        return userLoader.load(userSearch.searchedUserId);
    }
    searchedUsers({ userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            console.log("sapotoro");
            const searchedUsersQuery = yield (0, typeorm_1.getConnection)().query(`
			select * from user_search us
      where us."userId" = $1
      order by us."updatedAt" desc
		`, [userId]);
            return searchedUsersQuery;
        });
    }
    deleteUserSearch(searchedUserId, { userId }) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                yield (0, typeorm_1.getConnection)().query(`
        delete from "user_search" us
        where us."userId" = $1 and us."searchedUserId" = $2
      `, [userId, searchedUserId]);
                return true;
            }
            catch (e) {
                console.log(e);
                return false;
            }
        });
    }
};
__decorate([
    (0, type_graphql_1.FieldResolver)(() => User_1.User),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [UserSearches_1.UserSearch, Object]),
    __metadata("design:returntype", void 0)
], UserSearchResolver.prototype, "user", null);
__decorate([
    (0, type_graphql_1.FieldResolver)(() => User_1.User),
    __param(0, (0, type_graphql_1.Root)()),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [UserSearches_1.UserSearch, Object]),
    __metadata("design:returntype", void 0)
], UserSearchResolver.prototype, "searchedUser", null);
__decorate([
    (0, type_graphql_1.Query)(() => [UserSearches_1.UserSearch]),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], UserSearchResolver.prototype, "searchedUsers", null);
__decorate([
    (0, type_graphql_1.Mutation)(() => Boolean),
    (0, type_graphql_1.UseMiddleware)(isAuth_1.isAuth),
    __param(0, (0, type_graphql_1.Arg)("searchedUserId", () => type_graphql_1.Int)),
    __param(1, (0, type_graphql_1.Ctx)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Object]),
    __metadata("design:returntype", Promise)
], UserSearchResolver.prototype, "deleteUserSearch", null);
UserSearchResolver = __decorate([
    (0, type_graphql_1.Resolver)(UserSearches_1.UserSearch)
], UserSearchResolver);
exports.UserSearchResolver = UserSearchResolver;
//# sourceMappingURL=userSearch.js.map