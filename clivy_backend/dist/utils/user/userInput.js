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
Object.defineProperty(exports, "__esModule", { value: true });
exports.PaginatedFollow = exports.UserUpdateInput = exports.UserMutationResponse = exports.SignInInput = exports.RegisterInput = void 0;
const User_1 = require("../../entities/User");
const type_graphql_1 = require("type-graphql");
const globalInput_1 = require("../global/globalInput");
let RegisterInput = class RegisterInput {
};
__decorate([
    (0, type_graphql_1.Field)(),
    __metadata("design:type", String)
], RegisterInput.prototype, "name", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    __metadata("design:type", String)
], RegisterInput.prototype, "username", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    __metadata("design:type", String)
], RegisterInput.prototype, "email", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    __metadata("design:type", String)
], RegisterInput.prototype, "password", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    __metadata("design:type", String)
], RegisterInput.prototype, "birthday", void 0);
RegisterInput = __decorate([
    (0, type_graphql_1.InputType)()
], RegisterInput);
exports.RegisterInput = RegisterInput;
let SignInInput = class SignInInput {
};
__decorate([
    (0, type_graphql_1.Field)(),
    __metadata("design:type", String)
], SignInInput.prototype, "usernameOrEmail", void 0);
__decorate([
    (0, type_graphql_1.Field)(),
    __metadata("design:type", String)
], SignInInput.prototype, "password", void 0);
SignInInput = __decorate([
    (0, type_graphql_1.InputType)()
], SignInInput);
exports.SignInInput = SignInInput;
let UserMutationResponse = class UserMutationResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => User_1.User, { nullable: true }),
    __metadata("design:type", User_1.User)
], UserMutationResponse.prototype, "user", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => globalInput_1.TokenResponse, { nullable: true }),
    __metadata("design:type", globalInput_1.TokenResponse)
], UserMutationResponse.prototype, "tokens", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => [globalInput_1.ErrorResponse], { nullable: true }),
    __metadata("design:type", Array)
], UserMutationResponse.prototype, "errors", void 0);
UserMutationResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], UserMutationResponse);
exports.UserMutationResponse = UserMutationResponse;
let UserUpdateInput = class UserUpdateInput {
};
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], UserUpdateInput.prototype, "name", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], UserUpdateInput.prototype, "username", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], UserUpdateInput.prototype, "bio", void 0);
UserUpdateInput = __decorate([
    (0, type_graphql_1.InputType)()
], UserUpdateInput);
exports.UserUpdateInput = UserUpdateInput;
let PaginatedFollow = class PaginatedFollow {
};
__decorate([
    (0, type_graphql_1.Field)(() => [User_1.User]),
    __metadata("design:type", Array)
], PaginatedFollow.prototype, "users", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean),
    __metadata("design:type", Boolean)
], PaginatedFollow.prototype, "hasMore", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => type_graphql_1.Int),
    __metadata("design:type", Number)
], PaginatedFollow.prototype, "userId", void 0);
PaginatedFollow = __decorate([
    (0, type_graphql_1.ObjectType)()
], PaginatedFollow);
exports.PaginatedFollow = PaginatedFollow;
//# sourceMappingURL=userInput.js.map