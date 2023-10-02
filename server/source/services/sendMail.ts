import nodemailer from "nodemailer";
import { env } from "../env";

interface ISendMailParams {
    toEmail: string;
    subject: string;
    content: string;
}

export function sendMail({
    toEmail,
    content,
    subject,
}: ISendMailParams) {
    let transporter = nodemailer.createTransport({
        host: "smtp.zoho.com",
        secure: true,
        port: 465,
        auth: {
            user: env.MAIL,
            pass: env.MAIL_PASSWORD
        },
    });

    var mailOptions = {
        from: env.MAIL,
        to: toEmail,
        subject: subject,
        text: content,
    };

    transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
            console.log(error);
        } else {
            console.log(`Email sent to ${toEmail}` + info.response);
        }
    });
}
