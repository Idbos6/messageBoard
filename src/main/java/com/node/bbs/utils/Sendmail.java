package com.node.bbs.utils;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class Sendmail {

    public static int send_email(String toEmail,String subjects,String contents) throws IOException, AddressException, MessagingException{

        String to = toEmail;
        String subject = subjects;
        String content = contents;
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.qq.com"); // SMTP服务器地址
        properties.put("mail.smtp.port", "25"); // SMTP服务器的端口号
        properties.put("mail.smtp.auth", "true");
        // 发件人的信息填写
        Authenticator authenticator = new Email_Authenticator("775829060@qq.com", "lufeufaliobxbfjj");
        javax.mail.Session sendMailSession = javax.mail.Session.getDefaultInstance(properties, authenticator);
        MimeMessage mailMessage = new MimeMessage(sendMailSession);
        mailMessage.setFrom(new InternetAddress("775829060@qq.com"));
        // Message.RecipientType.TO属性表示接收者的类型为TO
        mailMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        mailMessage.setSubject(subject, "UTF-8");
        mailMessage.setSentDate(new Date());
        // MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象
        Multipart mainPart = new MimeMultipart();
        // 创建一个包含HTML内容的MimeBodyPart
        BodyPart html = new MimeBodyPart();
        html.setContent(content.trim(), "text/html; charset=utf-8");
        mainPart.addBodyPart(html);
        mailMessage.setContent(mainPart);
        Transport.send(mailMessage);
        return 1;
    }
}

