package kr.pe.okjsp.member;

import java.sql.SQLException;

import kr.pe.okjsp.util.MailUtil;

public class MemberService {

	public String[] sendRecoverPassword(String email) {
		String mailto = "kenu@okjsp.pe.kr";
		String subject = "[OKJSP]��й�ȣ ���� �ȳ�";
		String textMessage = "<h1>OKJSP ��й�ȣ ������ ��û�Ǿ����ϴ�.</h1>"
				+ "��û���� ���� �����̶�� �����Ͻñ� �ٶ��ϴ�."
				+ "<br /><br /><a href=\"http://dev.okjsp.pe.kr/jsp/member/forgot/recoverPassword.jsp?p="
				+ email + "\">��� �����ϱ�</a><br />";

		String success;
		String message;
		try {
			new MailUtil().send(mailto, subject, textMessage,
					"text/html; charset=euc-kr");
			success = "true";
			message = email + "�� ������ �߼��߽��ϴ�.";
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.toString() + "\nfailed: " + email);
			success = "false";
			message = email + "�� �߼����� ���߽��ϴ�.";
		}
		return new String[] { success, message };
	}

	public int changePassword(String email, String password,
			String passwordConfirm) {
		if (password == null || !password.equals(passwordConfirm)) {
			return 2;
		}
		if (!isMemberEmail(email)) {
			return 3;
		}
		MemberDao dao = new MemberDao();
		int result = 0;
		try {
			result = dao.setPasswordByEmail(email, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	private boolean isMemberEmail(String email) {
		MemberHandler handler = new MemberHandler();
		boolean emailExist = false;
		try {
			emailExist = handler.isEmailExist(email);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return emailExist;
	}

}
