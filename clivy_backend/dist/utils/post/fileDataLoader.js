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
exports.fileDataLoader = void 0;
const aws_sdk_1 = __importDefault(require("aws-sdk"));
const dataloader_1 = __importDefault(require("dataloader"));
const cloudfrontKeys_1 = require("../cloudfrontKeys");
const fileDataLoader = () => new dataloader_1.default((fileKeys) => __awaiter(void 0, void 0, void 0, function* () {
    const cloudfront = new aws_sdk_1.default.CloudFront.Signer('K3D1IQ9SZ0X79C', cloudfrontKeys_1.PRIVATE_KEY);
    const fileResponses = [];
    yield fileKeys.forEach((key) => __awaiter(void 0, void 0, void 0, function* () {
        const filePromise = new Promise((resolve) => {
            cloudfront.getSignedUrl({
                url: 'https://d20af6jrxb8p1.cloudfront.net/' + key,
                expires: Math.floor(new Date().getTime() / 1000) + (60 * 60 * 24 * 2)
            }, (err, url) => {
                if (err) {
                    resolve({
                        key: key,
                        file: {
                            error: 'could not load image'
                        }
                    });
                }
                resolve({
                    key: key,
                    file: {
                        file: url
                    }
                });
            });
        });
        yield filePromise.then((file) => {
            fileResponses.push(file);
        });
    }));
    const fileResponseMap = {};
    fileResponses.forEach((fileRes) => {
        fileResponseMap[fileRes.key] = fileRes.file;
    });
    return fileKeys.map(fileKey => fileResponseMap[fileKey]);
}));
exports.fileDataLoader = fileDataLoader;
//# sourceMappingURL=fileDataLoader.js.map