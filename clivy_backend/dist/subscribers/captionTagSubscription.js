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
exports.CaptionTagSubscription = void 0;
const publishNotification_1 = require("../utils/aws/publishNotification");
const typeorm_1 = require("typeorm");
const User_1 = require("../entities/User");
const DeviceToken_1 = require("../entities/DeviceToken");
const Notification_1 = require("../entities/Notification");
const CaptionUserTags_1 = require("../entities/CaptionUserTags");
const Post_1 = require("../entities/Post");
const CaptionTagNotification_1 = require("../entities/CaptionTagNotification");
let CaptionTagSubscription = class CaptionTagSubscription {
    listenTo() {
        return CaptionUserTags_1.CaptionUserTag;
    }
    afterUpdate(event) {
        return __awaiter(this, void 0, void 0, function* () {
            if (event.entity && event.entity.post_id) {
                const post = yield Post_1.Post.findOne({
                    where: { id: event.entity.post_id }
                });
                if (post) {
                    const postUser = yield User_1.User.findOne({ where: { id: post.user_id } });
                    const taggedUser = yield User_1.User.findOne({ where: { id: event.entity.user_id } });
                    if (postUser && taggedUser) {
                        if (taggedUser.id != postUser.id) {
                            const notificationData = yield CaptionTagNotification_1.CaptionTagNotification.findOne({
                                where: {
                                    post_id: post.id,
                                    user_id: taggedUser.id,
                                    type: Notification_1.NotificationType.capTag
                                }
                            });
                            if (notificationData) {
                                yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                    yield tm.createQueryBuilder()
                                        .update(Notification_1.Notification)
                                        .set({
                                        updatedAt: new Date()
                                    })
                                        .where("parent_id = :parent_id and user_id = :user_id and type = :type", { parent_id: post.id, user_id: taggedUser.id, type: Notification_1.NotificationType.capTag })
                                        .execute();
                                    yield tm.createQueryBuilder()
                                        .update(CaptionTagNotification_1.CaptionTagNotification)
                                        .set({
                                        updatedAt: new Date()
                                    })
                                        .where("post_id = :post_id and user_id = :user_id and type = :type", { post_id: post.id, user_id: taggedUser.id, type: Notification_1.NotificationType.capTag })
                                        .execute();
                                }));
                            }
                            else {
                                yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                                    yield tm.query(`
                  insert into "notification" ("parent_id", "user_id", "type")
                  values ($1, $2, $3)
                `, [post.id, taggedUser.id, Notification_1.NotificationType.capTag]);
                                    yield tm.query(`
                  insert into "caption_tag_notification" ("post_id", "user_id", "type")
                  values ($1, $2, $3)
                `, [post.id, taggedUser.id, Notification_1.NotificationType.capTag]);
                                }));
                            }
                            const deviceTokens = yield DeviceToken_1.DeviceToken.find({ where: {
                                    user_id: taggedUser.id
                                } });
                            console.log(deviceTokens);
                            const message = `${postUser.username} tagged you in a clip`;
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
        });
    }
};
CaptionTagSubscription = __decorate([
    (0, typeorm_1.EventSubscriber)()
], CaptionTagSubscription);
exports.CaptionTagSubscription = CaptionTagSubscription;
//# sourceMappingURL=captionTagSubscription.js.map