"use strict";
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
exports.replyPostIdField1648777445823 = void 0;
class replyPostIdField1648777445823 {
    constructor() {
        this.name = 'replyPostIdField1648777445823';
    }
    up(queryRunner) {
        return __awaiter(this, void 0, void 0, function* () {
            yield queryRunner.query(`ALTER TABLE "public"."reply" ADD "post_id" integer NOT NULL`);
            yield queryRunner.query(`ALTER TABLE "public"."like_notification" ADD CONSTRAINT "REL_b195062a5b770c1ec8aecef0d2" UNIQUE ("post_id", "user_id", "type")`);
            yield queryRunner.query(`ALTER TABLE "public"."caption_tag_notification" ADD CONSTRAINT "REL_5d75aa58bb1fc6bed264e5f7b9" UNIQUE ("post_id", "user_id", "type")`);
            yield queryRunner.query(`ALTER TABLE "public"."comment_notification" ADD CONSTRAINT "REL_f0672195675dfe991ebf82ea63" UNIQUE ("comment_id", "user_id", "type")`);
            yield queryRunner.query(`ALTER TABLE "public"."comment_tag_notification" ADD CONSTRAINT "REL_00a1b89674b8d7a82dc22f08b3" UNIQUE ("comment_id", "user_id", "type")`);
            yield queryRunner.query(`ALTER TABLE "public"."follow_notification" ADD CONSTRAINT "REL_9cd5f20a15086889490f971e90" UNIQUE ("follower_id", "user_id", "type")`);
            yield queryRunner.query(`ALTER TABLE "public"."reply_notification" ADD CONSTRAINT "REL_853624bc4b28dedf5880d4ada3" UNIQUE ("reply_id", "user_id", "type")`);
            yield queryRunner.query(`ALTER TABLE "public"."reply_tag_notification" ADD CONSTRAINT "REL_8b9da585fe61d8316af1220863" UNIQUE ("reply_id", "user_id", "type")`);
            yield queryRunner.query(`ALTER TABLE "public"."reply_like_notification" ADD CONSTRAINT "REL_d9662dcdc2abbce45cfcb17060" UNIQUE ("reply_id", "user_id", "type")`);
            yield queryRunner.query(`ALTER TABLE "public"."comment_like_notification" ADD CONSTRAINT "REL_c14091a63b0d6b1431e7be1e91" UNIQUE ("comment_id", "user_id", "type")`);
        });
    }
    down(queryRunner) {
        return __awaiter(this, void 0, void 0, function* () {
            yield queryRunner.query(`ALTER TABLE "public"."comment_like_notification" DROP CONSTRAINT "REL_c14091a63b0d6b1431e7be1e91"`);
            yield queryRunner.query(`ALTER TABLE "public"."reply_like_notification" DROP CONSTRAINT "REL_d9662dcdc2abbce45cfcb17060"`);
            yield queryRunner.query(`ALTER TABLE "public"."reply_tag_notification" DROP CONSTRAINT "REL_8b9da585fe61d8316af1220863"`);
            yield queryRunner.query(`ALTER TABLE "public"."reply_notification" DROP CONSTRAINT "REL_853624bc4b28dedf5880d4ada3"`);
            yield queryRunner.query(`ALTER TABLE "public"."follow_notification" DROP CONSTRAINT "REL_9cd5f20a15086889490f971e90"`);
            yield queryRunner.query(`ALTER TABLE "public"."comment_tag_notification" DROP CONSTRAINT "REL_00a1b89674b8d7a82dc22f08b3"`);
            yield queryRunner.query(`ALTER TABLE "public"."comment_notification" DROP CONSTRAINT "REL_f0672195675dfe991ebf82ea63"`);
            yield queryRunner.query(`ALTER TABLE "public"."caption_tag_notification" DROP CONSTRAINT "REL_5d75aa58bb1fc6bed264e5f7b9"`);
            yield queryRunner.query(`ALTER TABLE "public"."like_notification" DROP CONSTRAINT "REL_b195062a5b770c1ec8aecef0d2"`);
            yield queryRunner.query(`ALTER TABLE "public"."reply" DROP COLUMN "post_id"`);
        });
    }
}
exports.replyPostIdField1648777445823 = replyPostIdField1648777445823;
//# sourceMappingURL=1648777445823-replyPostIdField.js.map