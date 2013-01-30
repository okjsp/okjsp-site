package kr.pe.okjsp.member;

import java.sql.SQLException;

import kr.pe.okjsp.util.MailUtil;

public class MemberService {

	public String[] sendRecoverPassword(String email) {
		String mailto = "kenu@okjsp.pe.kr";
		String subject = "[OKJSP]비밀번호 변경 안내";
		String textMessage = "<h1>OKJSP 비밀번호 변경이 요청되었습니다.</h1>"
				+ "요청하지 않은 메일이라면 무시하시기 바랍니다."
				+ "<br /><br /><a href=\"http://dev.okjsp.pe.kr/jsp/member/forgot/recoverPassword.jsp?p="
				+ email + "\">비번 변경하기</a><br />";

		String success;
		String message;
		try {
			new MailUtil().send(mailto, subject, textMessage,
					"text/html; charset=euc-kr");
			success = "true";
			message = email + "로 메일을 발송했습니다.";
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.toString() + "\nfailed: " + email);
			success = "false";
			message = email + "로 발송하지 못했습니다.";
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
