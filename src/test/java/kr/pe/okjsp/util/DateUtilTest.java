package kr.pe.okjsp.util;

import java.util.Calendar;
import java.util.Date;

import junit.framework.TestCase;

public class DateUtilTest extends TestCase {
	public void testIsValidDate() {
		assertTrue(DateUtil.isValidDate("2008-02-29"));
		assertFalse(DateUtil.isValidDate("2009-02-29"));
	}
	
	public void testAddDate() {
		assertEquals("2012-05-02", DateUtil.addDate("2012-05-01", 1));
		assertEquals("2012-05-01", DateUtil.addDate("2012-04-30", 1));
	}

	public void testParse() {
		Calendar c1 = Calendar.getInstance();
		c1.set(2012, 5-1, 1, 0, 0, 0);
		c1.set(Calendar.MILLISECOND, 0);
		Date date = c1.getTime();
		assertEquals(date, DateUtil.parse("2012-05-01"));
	}
	
}
