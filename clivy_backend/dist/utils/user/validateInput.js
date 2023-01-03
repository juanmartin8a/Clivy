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
exports.validateBio = exports.validateName = exports.validateUsername = exports.validateUsernameExists = exports.validateUserFields = exports.validateSignIn = exports.validateRegister = void 0;
const User_1 = require("../../entities/User");
const argon2_1 = __importDefault(require("argon2"));
const validateRegister = (options) => __awaiter(void 0, void 0, void 0, function* () {
    const emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    const spacesRegex = /\s/g;
    const passwordRegex = /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}/;
    const validateUsernameExistance = yield (0, exports.validateUsernameExists)(options.username);
    if (validateUsernameExistance.length > 0) {
        return validateUsernameExistance;
    }
    const checkIfEmailExists = yield User_1.User.findOne({ where: { email: options.email } });
    if (checkIfEmailExists) {
        return [
            {
                field: 'email',
                message: 'email is already taken'
            }
        ];
    }
    const errorsArray = [];
    const usernameHasSpace = spacesRegex.test(options.username);
    const passwordHasSpace = spacesRegex.test(options.password);
    if (!emailRegex.test(options.email)) {
        errorsArray.push({
            field: 'email',
            message: 'invalid email'
        });
    }
    const validateUsernameInput = yield (0, exports.validateUsername)(options.username, usernameHasSpace);
    if (validateUsernameInput.length > 0) {
        errorsArray.push(...validateUsernameInput);
    }
    const validateNameInput = yield (0, exports.validateName)(options.name);
    if (validateNameInput.length > 0) {
        errorsArray.push(...validateNameInput);
    }
    if (options.password.length < 8 || !passwordRegex.test(options.password)
        || passwordHasSpace) {
        if (options.password.length < 8) {
            errorsArray.push({
                field: 'password',
                message: 'password must have at least 8 characters'
            });
        }
        else if (passwordHasSpace) {
            errorsArray.push({
                field: 'password',
                message: 'password must not have any spaces'
            });
        }
        else if (!passwordRegex.test(options.password)) {
            errorsArray.push({
                field: 'password',
                message: 'password must have at least one lower case and one number'
            });
        }
    }
    return errorsArray;
});
exports.validateRegister = validateRegister;
const validateSignIn = (options) => __awaiter(void 0, void 0, void 0, function* () {
    const emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    const user = yield User_1.User.findOne({ where: emailRegex.test(options.usernameOrEmail)
            ? { email: options.usernameOrEmail }
            : { username: options.usernameOrEmail }
    });
    if (!user) {
        return {
            errors: [
                {
                    field: 'usernameOrEmail',
                    message: 'user does not exist'
                }
            ],
            user: null
        };
    }
    const validatePassword = yield argon2_1.default.verify(user.password, options.password);
    if (!validatePassword) {
        return {
            errors: [
                {
                    field: 'password',
                    message: 'incorrect password'
                }
            ],
            user: null
        };
    }
    return { errors: [], user: user };
});
exports.validateSignIn = validateSignIn;
const validateUserFields = (input, userId) => __awaiter(void 0, void 0, void 0, function* () {
    const errorsArray = [];
    if (input.username) {
        const validate = yield (0, exports.validateUsernameExists)(input.username, userId);
        if (validate.length > 0) {
            return validate;
        }
        const spacesRegex = /\s/g;
        const usernameHasSpace = spacesRegex.test(input.username);
        const validateUsernameInput = yield (0, exports.validateUsername)(input.username, usernameHasSpace);
        if (validateUsernameInput.length > 0) {
            errorsArray.push(...validateUsernameInput);
        }
    }
    if (input.name) {
        const validateNameInput = yield (0, exports.validateName)(input.name);
        if (validateNameInput.length > 0) {
            errorsArray.push(...validateNameInput);
        }
    }
    if (input.bio) {
        const validateBioInput = yield (0, exports.validateBio)(input.bio);
        if (validateBioInput.length > 0) {
            errorsArray.push(...validateBioInput);
        }
    }
    return errorsArray;
});
exports.validateUserFields = validateUserFields;
const validateUsernameExists = (username, usernameId) => __awaiter(void 0, void 0, void 0, function* () {
    const errorsArray = [];
    const checkIfUsernameExists = yield User_1.User.findOne({ where: { username: username } });
    if (usernameId) {
        if (checkIfUsernameExists) {
            if (checkIfUsernameExists.id != usernameId) {
                errorsArray.push({
                    field: 'username',
                    message: 'username is already taken'
                });
            }
        }
    }
    else {
        if (checkIfUsernameExists) {
            errorsArray.push({
                field: 'username',
                message: 'username is already taken'
            });
        }
    }
    return errorsArray;
});
exports.validateUsernameExists = validateUsernameExists;
const validateUsername = (username, usernameHasSpace) => __awaiter(void 0, void 0, void 0, function* () {
    const errorsArray = [];
    if (username.length < 2 || username.length > 30
        || usernameHasSpace || username !== username.toLowerCase()) {
        if (username.length == 0) {
            errorsArray.push({
                field: 'username',
                message: 'username must not be empty'
            });
        }
        else if (username.length < 2) {
            errorsArray.push({
                field: 'username',
                message: 'username must have at least 2 characters'
            });
        }
        else if (usernameHasSpace) {
            errorsArray.push({
                field: 'username',
                message: 'username must not have any spaces'
            });
        }
        else if (username.length > 30) {
            errorsArray.push({
                field: 'username',
                message: 'username must have no more than 30 characters'
            });
        }
        else if (username !== username.toLowerCase()) {
            errorsArray.push({
                field: 'username',
                message: 'username must be in lower case only'
            });
        }
    }
    return errorsArray;
});
exports.validateUsername = validateUsername;
const validateName = (name) => __awaiter(void 0, void 0, void 0, function* () {
    const errorsArray = [];
    if (name.length < 2 || name.length > 30) {
        if (name.length == 0) {
            errorsArray.push({
                field: 'name',
                message: 'name must not be empty'
            });
        }
        else if (name.length < 2) {
            errorsArray.push({
                field: 'name',
                message: 'name must have at least 2 characters'
            });
        }
        else if (name.length > 30) {
            errorsArray.push({
                field: 'name',
                message: 'name must have no more than 30 characters'
            });
        }
    }
    return errorsArray;
});
exports.validateName = validateName;
const validateBio = (bio) => __awaiter(void 0, void 0, void 0, function* () {
    const errorsArray = [];
    if (bio.length > 150) {
        errorsArray.push({
            field: 'bio',
            message: 'bio must have no more than 150 characters'
        });
    }
    return errorsArray;
});
exports.validateBio = validateBio;
//# sourceMappingURL=validateInput.js.map