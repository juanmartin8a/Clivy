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
exports.UserSearchSubscription = void 0;
const UserSearches_1 = require("../entities/UserSearches");
const typeorm_1 = require("typeorm");
let UserSearchSubscription = class UserSearchSubscription {
    listenTo() {
        return UserSearches_1.UserSearch;
    }
    afterInsert(event) {
        return __awaiter(this, void 0, void 0, function* () {
            console.log("event: ");
            yield (0, typeorm_1.getConnection)().query(`
      DELETE FROM "user_search" us1
      WHERE us1."userId" = $1 AND us1."searchedUserId" NOT IN (
        select us."searchedUserId" from "user_search" us
        where us."userId" = $1
        order by us."updatedAt" DESC
        limit 10
      )
    `, [event.entity.userId]);
        });
    }
};
UserSearchSubscription = __decorate([
    (0, typeorm_1.EventSubscriber)()
], UserSearchSubscription);
exports.UserSearchSubscription = UserSearchSubscription;
//# sourceMappingURL=userSearchSubscription.js.map