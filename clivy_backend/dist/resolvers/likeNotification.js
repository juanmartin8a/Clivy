"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ReplyLikeNotificationResolver = exports.CommentLikeNotificationResolver = exports.LikeNotificationResolver = void 0;
const LikeNotification_1 = require("../entities/LikeNotification");
const type_graphql_1 = require("type-graphql");
const CommentLikeNotification_1 = require("../entities/CommentLikeNotification");
const ReplyLikeNotification_1 = require("../entities/ReplyLikeNotification");
let LikeNotificationResolver = class LikeNotificationResolver {
};
LikeNotificationResolver = __decorate([
    (0, type_graphql_1.Resolver)(LikeNotification_1.LikeNotification)
], LikeNotificationResolver);
exports.LikeNotificationResolver = LikeNotificationResolver;
let CommentLikeNotificationResolver = class CommentLikeNotificationResolver {
};
CommentLikeNotificationResolver = __decorate([
    (0, type_graphql_1.Resolver)(CommentLikeNotification_1.CommentLikeNotification)
], CommentLikeNotificationResolver);
exports.CommentLikeNotificationResolver = CommentLikeNotificationResolver;
let ReplyLikeNotificationResolver = class ReplyLikeNotificationResolver {
};
ReplyLikeNotificationResolver = __decorate([
    (0, type_graphql_1.Resolver)(ReplyLikeNotification_1.ReplyLikeNotification)
], ReplyLikeNotificationResolver);
exports.ReplyLikeNotificationResolver = ReplyLikeNotificationResolver;
//# sourceMappingURL=likeNotification.js.map