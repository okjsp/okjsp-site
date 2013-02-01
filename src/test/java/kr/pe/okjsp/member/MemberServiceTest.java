package kr.pe.okjsp.member;

import java.io.FileNotFoundException;

import javax.mail.MessagingException;

import junit.framework.TestCase;

public class MemberServiceTest extends TestCase {
	MemberService service;
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		service = new MemberService();
	}

	public void _testSendRecoverPassword() throws FileNotFoundException, MessagingException {
		String email = "kenu.heo@gmail.com";
		service.sendRecoverPassword(email);
	}
	
	public void testChangePassword() {
		String email = "okjspgwt@gmail.com";
		String password = "okpass";
		String passwordConfirm = "okpass";
		assertEquals(1, service.changePassword(email, password, passwordConfirm));
	}
	
	public void testChangePasswordDiffPassword() {
		String email = "okjspgwt@gmail.com";
		String password = "okpass";
		String passwordConfirm = "other";
		assertEquals(2, service.changePassword(email, password, passwordConfirm));
	}

	public void testChangePasswordNoUser() {
		String email = "okjspgwt2@gmail.com";
		String password = "okpass";
		String passwordConfirm = "okpass";
		assertEquals(3, service.changePassword(email, password, passwordConfirm));
	}
}
