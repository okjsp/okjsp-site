package kr.pe.okjsp.util;

import java.util.Locale;

import junit.framework.TestCase;
import kr.pe.okjsp.util.DateLabel;

public class DateLabelTest extends TestCase {
	public void testDiff() {
		DateLabel.setLocale(Locale.KOREAN);
		String now = "20070717120303";
		assertEquals(DateLabel.getString("DateLabel.lessthan5seconds"),
				DateLabel.getTimeDiffLabel(now, now));
		assertEquals(DateLabel.getString("DateLabel.lessthan5seconds"),
				DateLabel.getTimeDiffLabel("20070717120259", now));
		assertEquals("6초전",
				DateLabel.getTimeDiffLabel("20070717120257", now));
		assertEquals("10초전", DateLabel.getTimeDiffLabel("20070717120253", now));
		assertEquals("50초전", DateLabel.getTimeDiffLabel("20070717120213", now));
		assertEquals("1분전", DateLabel.getTimeDiffLabel("20070717120203", now));
		assertEquals("1분전", DateLabel.getTimeDiffLabel("20070717120133", now));
		assertEquals("59분전", DateLabel.getTimeDiffLabel("20070717110304", now));
		assertEquals("1시간전", DateLabel.getTimeDiffLabel("20070717110303", now));
		assertEquals("어제", DateLabel.getTimeDiffLabel("20070716120303", now));
		assertEquals("그저께", DateLabel.getTimeDiffLabel("20070715120303", now));
		assertEquals("3일전", DateLabel.getTimeDiffLabel("20070714120303", now));
		assertEquals("한달전", DateLabel.getTimeDiffLabel("20070617120303", now));
	}
	public void testMonthBug() {
		DateLabel.setLocale(Locale.KOREAN);
		String now = "20070824035303";
		assertEquals("한달전", DateLabel.getTimeDiffLabel("20070723231503", now));
	}
	public void testSpace() {
		DateLabel.setLocale(Locale.ENGLISH);
		String now = "20070812092303";
		assertEquals("2 days ago", DateLabel.getTimeDiffLabel("20070810092303", now));
		assertEquals("3 days ago", DateLabel.getTimeDiffLabel("20070809092303", now));
		assertEquals("10 days ago", DateLabel.getTimeDiffLabel("20070802092303", now));
		assertEquals("11 days ago", DateLabel.getTimeDiffLabel("20070801092303", now));
		assertEquals("12 days ago", DateLabel.getTimeDiffLabel("20070731092303", now));
		assertEquals("13 days ago", DateLabel.getTimeDiffLabel("20070730092303", now));
		assertEquals("23 days ago", DateLabel.getTimeDiffLabel("20070720092303", now));
		assertEquals("29 days ago", DateLabel.getTimeDiffLabel("20070714092303", now));
	}
	public void testLocale() {
		String now = "20070717120303";
		DateLabel.setLocale(Locale.ENGLISH);
		assertEquals(DateLabel.getString("DateLabel.lessthan5seconds"),
				DateLabel.getTimeDiffLabel(now, now));
		DateLabel.setLocale(Locale.KOREAN);
		assertEquals(DateLabel.getString("DateLabel.lessthan5seconds"),
				DateLabel.getTimeDiffLabel(now, now));
		assertEquals("지금막",
				DateLabel.getTimeDiffLabel(now, now));
	}


}
