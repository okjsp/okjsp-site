package kr.pe.okjsp.util;

import junit.framework.TestCase;

public class DateUtilTest extends TestCase {
	public void testIsValidDate() {
		assertTrue(DateUtil.isValidDate("2008-02-29"));
		assertFalse(DateUtil.isValidDate("2009-02-29"));
	}
	
	public void testAddDate() {
		assertEquals("2012-05-02", DateUtil.addDate("2012-05-01", 1));
	}

}
