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
exports.uploadFileProcess = void 0;
const uploadToBucket_1 = require("../aws/uploadToBucket");
const getFileBuffer_1 = require("./getFileBuffer");
const uploadFileProcess = (createReadStream, key, contentType) => __awaiter(void 0, void 0, void 0, function* () {
    const buffer = yield (0, getFileBuffer_1.getFileBuffer)(createReadStream);
    if (buffer === 'could not read file') {
        return { error: {
                field: 'post',
                message: buffer
            }
        };
    }
    console.log(buffer);
    const s3Result = yield (0, uploadToBucket_1.uploadImageToS3)(key, buffer, contentType);
    if (s3Result === false) {
        return { error: {
                field: 'post',
                message: 'could not upload post'
            }
        };
    }
    return;
});
exports.uploadFileProcess = uploadFileProcess;
//# sourceMappingURL=uploadImage.js.map