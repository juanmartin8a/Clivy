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
exports.uploadImageToS3 = void 0;
const aws_sdk_1 = __importDefault(require("aws-sdk"));
const uploadImageToS3 = (key, compressedBuffer, contentType) => __awaiter(void 0, void 0, void 0, function* () {
    const s3 = new aws_sdk_1.default.S3({
        region: 'us-east-2',
    });
    const result = yield new Promise((resolve) => {
        s3.upload({
            Bucket: '',
            Key: key,
            Body: compressedBuffer,
            ContentType: contentType,
            ContentEncoding: 'H.264'
        }, (err) => {
            if (err) {
                console.log('the error is: ' + err);
                resolve(false);
            }
            resolve(true);
        });
    });
    return result;
});
exports.uploadImageToS3 = uploadImageToS3;
//# sourceMappingURL=uploadToBucket.js.map