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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.publishNotification = void 0;
const apn_1 = __importDefault(require("apn"));
const publishNotification = (rawPayload, token, isIOS) => __awaiter(void 0, void 0, void 0, function* () {
    let tokenDoesNotExist = false;
    const pfxPath = "";
    const options = {
        pfx: pfxPath,
        passphrase: "",
        production: false,
    };
    const apnProvider = new apn_1.default.Provider(options);
    let notification = new apn_1.default.Notification();
    notification.rawPayload = rawPayload;
    yield apnProvider.send(notification, [token]).then((result) => {
        if (result.failed[0] && result.failed[0].status === "410") {
            tokenDoesNotExist = true;
        }
    });
    return tokenDoesNotExist;
});
exports.publishNotification = publishNotification;
//# sourceMappingURL=publishNotification.js.map