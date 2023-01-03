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
exports.sendEmail = void 0;
const fs_1 = __importDefault(require("fs"));
const handlebars_1 = __importDefault(require("handlebars"));
const nodemailer_1 = __importDefault(require("nodemailer"));
const sendEmail = (to, subject, html, data) => {
    let transporter = nodemailer_1.default.createTransport({
        service: 'gmail',
        auth: {
            user: "clivyapp@gmail.com",
            pass: "yueg bzcs erqg akbj"
        },
    });
    fs_1.default.readFile(html, { encoding: "utf-8" }, (err, htmlData) => __awaiter(void 0, void 0, void 0, function* () {
        if (!err) {
            var template = handlebars_1.default.compile(htmlData);
            let mailOptions = {
                from: 'clivyapp@gmail.com',
                to: to,
                subject: subject,
                html: template(data),
            };
            transporter.sendMail(mailOptions, (err, data) => {
                console.log(err);
                console.log(data);
            });
        }
    }));
};
exports.sendEmail = sendEmail;
//# sourceMappingURL=sendEmail.js.map