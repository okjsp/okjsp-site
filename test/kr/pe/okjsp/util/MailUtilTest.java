package kr.pe.okjsp.util;

import java.io.FileNotFoundException;

import javax.mail.MessagingException;

import junit.framework.TestCase;

public class MailUtilTest extends TestCase {
	public void testSend() throws FileNotFoundException, MessagingException {
		String mailto = "kenu@okjsp.pe.kr";
		String subject = "[OKJSP]Confirmation Mail";
		String textMessage = "Thank you for your joining OKJSP\n"
				+ "\nYour temporary password : " + "123412341234"
				+ "\nAfter login you can change your password as you like."
				+ "\nhttps://www.okjsp.pe.kr/jsp/member/info.jsp" 
				+ "\n\nJSP/Eclipse developer community http://www.okjsp.pe.kr ";
		new MailUtil().send(mailto, subject, textMessage);
	}
}
