import fs from 'fs';
import handlebars from 'handlebars';
import nodemailer from 'nodemailer';

export const sendEmail = (to: string, subject: string, html: string, data: Object) => {
  let transporter = nodemailer.createTransport({
		service: 'gmail',
    auth: {
      user: "clivyapp@gmail.com", // generated ethereal user
      pass: "yueg bzcs erqg akbj"//"#Clivy!App$$BlackGreen%8a239", // generated ethereal password
    },
	})

	// var html;
	fs.readFile(html, {encoding: "utf-8"}, async (err, htmlData) => {
		if (!err) {
			var template = handlebars.compile(htmlData);
		
			let mailOptions = {
				from: 'clivyapp@gmail.com', // sender address
				to: to, // list of receivers
				subject: subject, // Subject line
				html: template(data),
			}
		
			transporter.sendMail(mailOptions, (err, data) => {
				console.log(err);
				console.log(data)
			})
		}
	});
}