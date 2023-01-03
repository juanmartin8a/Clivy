"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ReplyLikeResolver = exports.CommentLikeResolver = exports.LikeResolver = void 0;
const Like_1 = require("../entities/Like");
const type_graphql_1 = require("type-graphql");
const CommentLike_1 = require("../entities/CommentLike");
const ReplyLike_1 = require("../entities/ReplyLike");
let LikeResolver = class LikeResolver {
};
LikeResolver = __decorate([
    (0, type_graphql_1.Resolver)(Like_1.Like)
], LikeResolver);
exports.LikeResolver = LikeResolver;
let CommentLikeResolver = class CommentLikeResolver {
};
CommentLikeResolver = __decorate([
    (0, type_graphql_1.Resolver)(CommentLike_1.CommentLike)
], CommentLikeResolver);
exports.CommentLikeResolver = CommentLikeResolver;
let ReplyLikeResolver = class ReplyLikeResolver {
};
ReplyLikeResolver = __decorate([
    (0, type_graphql_1.Resolver)(ReplyLike_1.ReplyLike)
], ReplyLikeResolver);
exports.ReplyLikeResolver = ReplyLikeResolver;
//# sourceMappingURL=like.js.map