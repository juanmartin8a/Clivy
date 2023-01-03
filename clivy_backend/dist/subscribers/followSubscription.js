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
exports.FollowSubscription = void 0;
const publishNotification_1 = require("../utils/aws/publishNotification");
const typeorm_1 = require("typeorm");
const User_1 = require("../entities/User");
const DeviceToken_1 = require("../entities/DeviceToken");
const Notification_1 = require("../entities/Notification");
const Follow_1 = require("../entities/Follow");
const FollowNotification_1 = require("../entities/FollowNotification");
let FollowSubscription = class FollowSubscription {
    listenTo() {
        return Follow_1.Follow;
    }
    afterInsert(event) {
        return __awaiter(this, void 0, void 0, function* () {
            const following = yield User_1.User.findOne({
                where: {
                    id: event.entity.followingId
                }
            });
            const follower = yield User_1.User.findOne({
                where: {
                    id: event.entity.followerId
                }
            });
            if (following && follower) {
                yield (0, typeorm_1.getConnection)().query(`
        update "user"
        set "followingCount" = "followingCount" + 1
        where id = $1
      `, [follower.id]);
                yield (0, typeorm_1.getConnection)().query(`
        update "user"
        set "followersCount" = "followersCount" + 1
        where id = $1
      `, [following.id]);
                if (following.id != follower.id) {
                    const notificationData = yield FollowNotification_1.FollowNotification.findOne({
                        where: {
                            follower_id: follower.id,
                            user_id: following.id,
                            type: Notification_1.NotificationType.follow
                        }
                    });
                    if (notificationData) {
                        yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                            yield tm.createQueryBuilder()
                                .update(Notification_1.Notification)
                                .set({
                                updatedAt: new Date()
                            })
                                .where("parent_id = :parent_id and user_id = :user_id and type = :type", { parent_id: follower.id, user_id: following.id, type: Notification_1.NotificationType.follow })
                                .execute();
                            yield tm.createQueryBuilder()
                                .update(FollowNotification_1.FollowNotification)
                                .set({
                                updatedAt: new Date()
                            })
                                .where("follower_id = :follower_id and user_id = :user_id and type = :type", { follower_id: follower.id, user_id: following.id, type: Notification_1.NotificationType.follow })
                                .execute();
                        }));
                    }
                    else {
                        yield (0, typeorm_1.getConnection)().transaction((tm) => __awaiter(this, void 0, void 0, function* () {
                            yield tm.query(`
              insert into "notification" ("parent_id", "user_id", "type")
              values ($1, $2, $3)
            `, [follower.id, following.id, Notification_1.NotificationType.follow]);
                            yield tm.query(`
              insert into "follow_notification" ("follower_id", "user_id", "type")
              values ($1, $2, $3)
            `, [follower.id, following.id, Notification_1.NotificationType.follow]);
                        }));
                    }
                    const deviceTokens = yield DeviceToken_1.DeviceToken.find({ where: {
                            user_id: following.id
                        } });
                    console.log(deviceTokens);
                    const message = `${follower.username} started following you`;
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
        });
    }
};
FollowSubscription = __decorate([
    (0, typeorm_1.EventSubscriber)()
], FollowSubscription);
exports.FollowSubscription = FollowSubscription;
//# sourceMappingURL=followSubscription.js.map