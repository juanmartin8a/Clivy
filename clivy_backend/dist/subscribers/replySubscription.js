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
exports.ReplySubscription = void 0;
const publishNotification_1 = require("../utils/aws/publishNotification");
const typeorm_1 = require("typeorm");
const User_1 = require("../entities/User");
const DeviceToken_1 = require("../entities/DeviceToken");
const Notification_1 = require("../entities/Notification");
const Reply_1 = require("../entities/Reply");
const Comments_1 = require("../entities/Comments");
const ReplyNotification_1 = require("../entities/ReplyNotification");
let ReplySubscription = class ReplySubscription {
    listenTo() {
        return Reply_1.Reply;
    }
    afterUpdate(event) {
        return __awaiter(this, void 0, void 0, function* () {
            if (event.entity && event.entity.id) {
                const replyRow = yield Reply_1.Reply.findOne({
                    where: { id: event.entity.id }
                });
                if (replyRow) {
                    const comment = yield Comments_1.Comment.findOne({
                        where: {
                            id: replyRow.comment_id
                        }
                    });
                    if (comment) {
                        const user = yield User_1.User.findOne({ where: { id: replyRow.user_id } });
                        if (user) {
                            if (user.id != comment.user_id) {
                                const notificationData = yield ReplyNotification_1.ReplyNotification.findOne({
                                    where: {
                                        reply_id: replyRow.id,
                                        user_id: comment.user_id,
                                        type: Notification_1.NotificationType.reply
                                    }
                                });
                                if (notificationData) {
                                    yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                        yield tm.createQueryBuilder()
                                            .update(Notification_1.Notification)
                                            .set({
                                            updatedAt: new Date()
                                        })
                                            .where("parent_id = :parent_id and user_id = :user_id and type = :type", { parent_id: replyRow.id, user_id: comment.user_id, type: Notification_1.NotificationType.reply })
                                            .execute();
                                        yield tm.createQueryBuilder()
                                            .update(ReplyNotification_1.ReplyNotification)
                                            .set({
                                            updatedAt: new Date()
                                        })
                                            .where("reply_id = :reply_id and user_id = :user_id and type = :type", { reply_id: replyRow.id, user_id: comment.user_id, type: Notification_1.NotificationType.reply })
                                            .execute();
                                    }));
                                }
                                else {
                                    yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                        yield tm.query(`
                    insert into "notification" ("parent_id", "user_id", "type")
                    values ($1, $2, $3)
                  `, [replyRow.id, comment.user_id, Notification_1.NotificationType.reply]);
                                        yield tm.query(`
                    insert into "reply_notification" ("reply_id", "user_id", "type")
                    values ($1, $2, $3)
                  `, [replyRow.id, comment.user_id, Notification_1.NotificationType.reply]);
                                    }));
                                }
                                const deviceTokens = yield DeviceToken_1.DeviceToken.find({ where: {
                                        user_id: comment.user_id
                                    } });
                                console.log(deviceTokens);
                                const message = `${user.username} replied to your comment`;
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
                }
            }
        });
    }
};
ReplySubscription = __decorate([
    (0, typeorm_1.EventSubscriber)()
], ReplySubscription);
exports.ReplySubscription = ReplySubscription;
//# sourceMappingURL=replySubscription.js.map