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
exports.changePassword = void 0;
const typeorm_1 = require("typeorm");
const argon2_1 = __importDefault(require("argon2"));
const changePassword = (user, newPassword) => __awaiter(void 0, void 0, void 0, function* () {
    const spacesRegex = /\s/g;
    const passwordRegex = /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}/;
    const errorsArray = [];
    const passwordHasSpace = spacesRegex.test(newPassword);
    if (newPassword.length < 8 || !passwordRegex.test(newPassword)
        || passwordHasSpace) {
        if (newPassword.length < 8) {
            errorsArray.push({
                field: 'newPassword',
                message: 'password must have at least 8 characters'
            });
        }
        else if (passwordHasSpace) {
            errorsArray.push({
                field: 'newPassword',
                message: 'password must not have any spaces'
            });
        }
        else if (!passwordRegex.test(newPassword)) {
            errorsArray.push({
                field: 'newPassword',
                message: 'password must have at least one lower case and one number'
            });
        }
    }
    const hashPassword = yield argon2_1.default.hash(newPassword);
    yield (0, typeorm_1.getConnection)().query(`
    update "user"
    set password = $1
    where id = $2
  `, [hashPassword, user.id]);
    return errorsArray;
});
exports.changePassword = changePassword;
//# sourceMappingURL=changePassword.js.map