package kr.pe.okjsp.member;

import java.sql.SQLException;

import junit.framework.TestCase;

public class MemberHandlerTest extends TestCase {
	public void testAdd() {
		MemberHandler handler = new MemberHandler();
		boolean idExist = false;
		try {
			idExist = handler.isIdExist("ke-nu");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		assertFalse(idExist);
	}

}
