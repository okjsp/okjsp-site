package kr.pe.okjsp.member;

import junit.framework.TestCase;

public class MemberHandlerTest extends TestCase {
	public void testAdd() {
		int a = 10;
		a = a++;
		assertEquals(10, a);
	}

}
