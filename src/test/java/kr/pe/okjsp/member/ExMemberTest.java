package kr.pe.okjsp.member;

import junit.framework.TestCase;

public class ExMemberTest extends TestCase {
	public void testHasSid() throws Exception {
		MemberService service = new MemberService();
		boolean checkBySid = service.checkBySid(21100L);
		assertFalse(checkBySid);
	}
}
