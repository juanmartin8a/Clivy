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
exports.ReplyLikeSubscription = void 0;
const publishNotification_1 = require("../utils/aws/publishNotification");
const typeorm_1 = require("typeorm");
const User_1 = require("../entities/User");
const DeviceToken_1 = require("../entities/DeviceToken");
const Notification_1 = require("../entities/Notification");
const ReplyLike_1 = require("../entities/ReplyLike");
const Reply_1 = require("../entities/Reply");
const ReplyLikeNotification_1 = require("../entities/ReplyLikeNotification");
let ReplyLikeSubscription = class ReplyLikeSubscription {
    listenTo() {
        return ReplyLike_1.ReplyLike;
    }
    afterInsert(event) {
        return __awaiter(this, void 0, void 0, function* () {
            const repliesById = yield Reply_1.Reply.find({
                where: {
                    id: event.entity.reply_id
                }
            });
            if (repliesById.length > 0) {
                const reply = repliesById[0];
                yield (0, typeorm_1.getConnection)().query(`
        update "reply"
        set "likeCount" = "likeCount" + 1
        where "id" = $1
      `, [event.entity.reply_id]);
                const user = yield User_1.User.findOne({ where: { id: event.entity.user_id } });
                if (user) {
                    if (user.id != reply.user_id) {
                        const notificationData = yield ReplyLikeNotification_1.ReplyLikeNotification.findOne({
                            where: {
                                reply_id: reply.id,
                                user_id: reply.user_id,
                                type: Notification_1.NotificationType.replyLike
                            }
                        });
                        if (notificationData) {
                            yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                yield tm.createQueryBuilder()
                                    .update(Notification_1.Notification)
                                    .set({
                                    updatedAt: new Date()
                                })
                                    .where("parent_id = :parent_id and user_id = :user_id and type = :type", { parent_id: reply.id, user_id: reply.user_id, type: Notification_1.NotificationType.replyLike })
                                    .execute();
                                yield tm.createQueryBuilder()
                                    .update(ReplyLikeNotification_1.ReplyLikeNotification)
                                    .set({
                                    updatedAt: new Date()
                                })
                                    .where("reply_id = :reply_id and user_id = :user_id and type = :type", { reply_id: reply.id, user_id: reply.user_id, type: Notification_1.NotificationType.replyLike })
                                    .execute();
                            }));
                        }
                        else {
                            (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                yield tm.createQueryBuilder()
                                    .insert()
                                    .into(Notification_1.Notification)
                                    .values({
                                    parent_id: reply.id,
                                    user_id: reply.user_id,
                                    type: Notification_1.NotificationType.replyLike,
                                })
                                    .execute();
                                yield tm.createQueryBuilder()
                                    .insert()
                                    .into(ReplyLikeNotification_1.ReplyLikeNotification)
                                    .values({
                                    reply_id: reply.id,
                                    user_id: reply.user_id,
                                    type: Notification_1.NotificationType.replyLike,
                                })
                                    .execute();
                            }));
                        }
                        const theReply = yield Notification_1.Notification.find({});
                        console.log(theReply);
                        const deviceTokens = yield DeviceToken_1.DeviceToken.find({ where: {
                                user_id: reply.user_id
                            } });
                        const message = `${user.username} has liked your reply`;
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
ReplyLikeSubscription = __decorate([
    (0, typeorm_1.EventSubscriber)()
], ReplyLikeSubscription);
exports.ReplyLikeSubscription = ReplyLikeSubscription;
//# sourceMappingURL=likeReplySubscription.js.map