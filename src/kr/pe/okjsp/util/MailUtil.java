package kr.pe.okjsp.util;

import java.io.FileNotFoundException;
import java.security.Security;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {

	private static class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(smtpUsername, smtpPassword);
		}
	}

	public static final String smtpHost = PropertyManager.getString("MAIL_HOST");
	public static final String smtpUsername = PropertyManager.getString("MAIL_SENDER");
	public static final String smtpPassword = PropertyManager.getString("MAIL_PASS");
	public static final String smtpPort = PropertyManager.getString("MAIL_PORT");

	public void send(String mailto, String subject, String textMessage)
			throws FileNotFoundException, MessagingException {
		send(mailto, subject, textMessage, "text/plain; charset=euc-kr");
	}
	public void send(String mailto, String subject, String textMessage, String contentType)
			throws FileNotFoundException, MessagingException {
		Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		Properties props = new Properties();
		props.put("mail.smtp.user", smtpUsername);
		props.put("mail.smtp.host", smtpHost);
		props.put("mail.smtp.port", smtpPort);
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtps.auth", "true");
		props.put("mail.smtp.debug", "true");
		props.put("mail.smtp.socketFactory.port", smtpPort);
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");
		props.put("mail.smtp.ssl", "true");
		
		Authenticator auth = new SMTPAuthenticator();
		Session smtpSession = Session.getInstance(props, auth);
		smtpSession.setDebug(true);
		
		Message message = new MimeMessage(smtpSession);
		InternetAddress[] address = { new InternetAddress(mailto) };
		message.setRecipients(Message.RecipientType.TO, address);
		message.setSubject(subject);
		message.setSentDate(new Date());
		message.setContent(textMessage, contentType);
		
		Transport tr = smtpSession.getTransport("smtp");
		tr.connect(smtpHost, smtpUsername, smtpPassword);
		tr.sendMessage(message, message.getAllRecipients());
		tr.close();
	}

}
