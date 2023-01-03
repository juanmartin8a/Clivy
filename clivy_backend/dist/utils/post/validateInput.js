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
exports.validatePost = void 0;
const validatePost = (caption, file) => __awaiter(void 0, void 0, void 0, function* () {
    if (!file) {
        console.log('saposalsa');
        return {
            field: 'file',
            message: 'no file selected'
        };
    }
    if (caption.length > 160) {
        return {
            field: 'caption',
            message: 'caption length must not exceed 160 characters'
        };
    }
    return null;
});
exports.validatePost = validatePost;
//# sourceMappingURL=validateInput.js.map