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
exports.DeviceInput = exports.ErrorResponse = exports.TokenResponse = exports.CheckIsAuth = exports.FileResponse = void 0;
const type_graphql_1 = require("type-graphql");
let FileResponse = class FileResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], FileResponse.prototype, "file", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], FileResponse.prototype, "error", void 0);
FileResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], FileResponse);
exports.FileResponse = FileResponse;
let CheckIsAuth = class CheckIsAuth {
};
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], CheckIsAuth.prototype, "token", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], CheckIsAuth.prototype, "error", void 0);
CheckIsAuth = __decorate([
    (0, type_graphql_1.InputType)()
], CheckIsAuth);
exports.CheckIsAuth = CheckIsAuth;
let TokenResponse = class TokenResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => String),
    __metadata("design:type", String)
], TokenResponse.prototype, "accessToken", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    __metadata("design:type", String)
], TokenResponse.prototype, "refreshToken", void 0);
TokenResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], TokenResponse);
exports.TokenResponse = TokenResponse;
let ErrorResponse = class ErrorResponse {
};
__decorate([
    (0, type_graphql_1.Field)(() => String),
    __metadata("design:type", String)
], ErrorResponse.prototype, "field", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => String),
    __metadata("design:type", String)
], ErrorResponse.prototype, "message", void 0);
ErrorResponse = __decorate([
    (0, type_graphql_1.ObjectType)()
], ErrorResponse);
exports.ErrorResponse = ErrorResponse;
let DeviceInput = class DeviceInput {
};
__decorate([
    (0, type_graphql_1.Field)(() => String, { nullable: true }),
    __metadata("design:type", String)
], DeviceInput.prototype, "deviceToken", void 0);
__decorate([
    (0, type_graphql_1.Field)(() => Boolean, { nullable: true }),
    __metadata("design:type", Boolean)
], DeviceInput.prototype, "platformIsIOS", void 0);
DeviceInput = __decorate([
    (0, type_graphql_1.InputType)()
], DeviceInput);
exports.DeviceInput = DeviceInput;
//# sourceMappingURL=globalInput.js.map