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
exports.ReplyTagSubscription = void 0;
const publishNotification_1 = require("../utils/aws/publishNotification");
const typeorm_1 = require("typeorm");
const User_1 = require("../entities/User");
const DeviceToken_1 = require("../entities/DeviceToken");
const Notification_1 = require("../entities/Notification");
const ReplyUserTags_1 = require("../entities/ReplyUserTags");
const Reply_1 = require("../entities/Reply");
const ReplyTagNotification_1 = require("../entities/ReplyTagNotification");
let ReplyTagSubscription = class ReplyTagSubscription {
    listenTo() {
        return ReplyUserTags_1.ReplyUserTag;
    }
    afterInsert(event) {
        return __awaiter(this, void 0, void 0, function* () {
            const reply = yield Reply_1.Reply.findOne({
                where: { id: event.entity.reply_id }
            });
            if (reply) {
                const replyUser = yield User_1.User.findOne({ where: { id: reply.user_id } });
                const taggedUser = yield User_1.User.findOne({ where: { id: event.entity.user_id } });
                if (replyUser && taggedUser) {
                    if (taggedUser.id != replyUser.id) {
                        const notificationData = yield ReplyTagNotification_1.ReplyTagNotification.findOne({
                            where: {
                                reply_id: reply.id,
                                user_id: taggedUser.id,
                                type: Notification_1.NotificationType.replyTag
                            }
                        });
                        if (notificationData) {
                            yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                yield tm.createQueryBuilder()
                                    .update(Notification_1.Notification)
                                    .set({
                                    updatedAt: new Date()
                                })
                                    .where("parent_id = :parent_id and user_id = :user_id and type = :type", { parent_id: reply.id, user_id: taggedUser.id, type: Notification_1.NotificationType.replyTag })
                                    .execute();
                                yield tm.createQueryBuilder()
                                    .update(ReplyTagNotification_1.ReplyTagNotification)
                                    .set({
                                    updatedAt: new Date()
                                })
                                    .where("reply_id = :reply_id and user_id = :user_id and type = :type", { reply_id: reply.id, user_id: taggedUser.id, type: Notification_1.NotificationType.replyTag })
                                    .execute();
                            }));
                        }
                        else {
                            yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                yield tm.query(`
                insert into "notification" ("parent_id", "user_id", "type")
                values ($1, $2, $3)
              `, [reply.id, taggedUser.id, Notification_1.NotificationType.replyTag]);
                                yield tm.query(`
                insert into "reply_tag_notification" ("reply_id", "user_id", "type")
                values ($1, $2, $3)
              `, [reply.id, taggedUser.id, Notification_1.NotificationType.replyTag]);
                            }));
                        }
                        const deviceTokens = yield DeviceToken_1.DeviceToken.find({ where: {
                                user_id: taggedUser.id
                            } });
                        console.log(deviceTokens);
                        const message = `${replyUser.username} tagged you in a reply`;
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
ReplyTagSubscription = __decorate([
    (0, typeorm_1.EventSubscriber)()
], ReplyTagSubscription);
exports.ReplyTagSubscription = ReplyTagSubscription;
//# sourceMappingURL=replyTagSubscroption.js.map