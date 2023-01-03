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
exports.createPlatformEndpointFunc = void 0;
const aws_sdk_1 = __importDefault(require("aws-sdk"));
const createPlatformEndpointFunc = (token) => __awaiter(void 0, void 0, void 0, function* () {
    var sns = new aws_sdk_1.default.SNS();
    const applicationPlatformARN = "arn:aws:sns:us-east-1:113054727247:app/GCM/DevClivy";
    yield sns.createPlatformEndpoint({
        PlatformApplicationArn: applicationPlatformARN,
        Token: token
    }, (err, data) => {
        console.log(err);
        console.log(data);
    });
});
exports.createPlatformEndpointFunc = createPlatformEndpointFunc;
//# sourceMappingURL=createPlatformEndpoint.js.map