"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
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
exports.CommentLikeSubscription = void 0;
const publishNotification_1 = require("../utils/aws/publishNotification");
const typeorm_1 = require("typeorm");
const User_1 = require("../entities/User");
const DeviceToken_1 = require("../entities/DeviceToken");
const Notification_1 = require("../entities/Notification");
const CommentLike_1 = require("../entities/CommentLike");
const Comments_1 = require("../entities/Comments");
const CommentLikeNotification_1 = require("../entities/CommentLikeNotification");
let CommentLikeSubscription = class CommentLikeSubscription {
    listenTo() {
        return CommentLike_1.CommentLike;
    }
    afterInsert(event) {
        return __awaiter(this, void 0, void 0, function* () {
            const comment = yield Comments_1.Comment.findOne({
                where: {
                    id: event.entity.comment_id
                }
            });
            if (comment) {
                yield (0, typeorm_1.getConnection)().query(`
        update "comment"
        set "likeCount" = "likeCount" + 1
        where "id" = $1
        `, [event.entity.comment_id]);
                const user = yield User_1.User.findOne({ where: { id: event.entity.user_id } });
                if (user) {
                    if (user.id != comment.user_id) {
                        const notificationData = yield CommentLikeNotification_1.CommentLikeNotification.findOne({
                            where: {
                                comment_id: comment.id,
                                user_id: comment.user_id,
                                type: Notification_1.NotificationType.commentLike
                            }
                        });
                        if (notificationData) {
                            yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                yield tm.createQueryBuilder()
                                    .update(Notification_1.Notification)
                                    .set({
                                    updatedAt: new Date()
                                })
                                    .where("parent_id = :parent_id and user_id = :user_id and type = :type", { parent_id: comment.id, user_id: comment.user_id, type: Notification_1.NotificationType.commentLike })
                                    .execute();
                                yield tm.createQueryBuilder()
                                    .update(CommentLikeNotification_1.CommentLikeNotification)
                                    .set({
                                    updatedAt: new Date()
                                })
                                    .where("comment_id = :comment_id and user_id = :user_id and type = :type", { comment_id: comment.id, user_id: comment.user_id, type: Notification_1.NotificationType.commentLike })
                                    .execute();
                            }));
                        }
                        else {
                            yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                yield tm.query(`
                insert into "notification" ("parent_id", "user_id", "type")
                values ($1, $2, $3)
                returning *
              `, [comment.id, comment.user_id, Notification_1.NotificationType.commentLike]);
                                yield tm.query(`
                insert into "comment_like_notification" ("comment_id", "user_id", "type")
                values ($1, $2, $3)
              `, [comment.id, comment.user_id, Notification_1.NotificationType.commentLike]);
                            }));
                        }
                        const deviceTokens = yield DeviceToken_1.DeviceToken.find({ where: {
                                user_id: comment.user_id
                            } });
                        console.log(deviceTokens);
                        const message = `${user.username} has liked your comment`;
                        for (var i = 0; i < deviceTokens.length; i++) {
                            const deviceToken = deviceTokens[i];
                            const payload = {
                                "aps": {
                                    "sound": "default",
                                    "badge": 1,
                                    "alert": {
                                        "title": "Clivy",
                                        "body": message
                                    }
                                }
                            };
                            yield (0, publishNotification_1.publishNotification)(payload, deviceToken.token, deviceToken.platform == 'iOS');
                        }
                    }
                }
            }
        });
    }
};
CommentLikeSubscription = __decorate([
    (0, typeorm_1.EventSubscriber)()
], CommentLikeSubscription);
exports.CommentLikeSubscription = CommentLikeSubscription;
//# sourceMappingURL=likeCommentSubscription.js.map