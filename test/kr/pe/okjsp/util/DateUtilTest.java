package kr.pe.okjsp.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import junit.framework.TestCase;

public class DateUtilTest extends TestCase {
	public void testIsValidDate() {
		assertTrue(isValidDate("20080229"));
		assertFalse(isValidDate("20090229"));
	}

	public boolean isValidDate(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String format = null;
		try {
			format = sdf.format(sdf.parse(date));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date.equals(format);
	}
}
