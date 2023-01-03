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
exports.generateUpdateUserSQL = void 0;
const generateUpdateUserSQL = (input, username, name, bio) => __awaiter(void 0, void 0, void 0, function* () {
    let updateValues = "";
    Object.entries(input).map(([key, value]) => {
        if (value !== undefined && value !== null) {
            if ((value !== username && key === "username") ||
                (value !== name && key === "name") ||
                (value !== bio && key === "bio")) {
                if (updateValues === "") {
                    updateValues = updateValues + `"${key}": "${value}"`;
                }
                else {
                    updateValues = updateValues + ", " + `"${key}": "${value}"`;
                }
            }
        }
    });
    if (updateValues === "") {
        return {};
    }
    const updatedInput = "{" + updateValues + "}";
    const parsedUpdatedInput = yield JSON.parse(updatedInput);
    return parsedUpdatedInput;
});
exports.generateUpdateUserSQL = generateUpdateUserSQL;
//# sourceMappingURL=generateUpdateUserSQL.js.map