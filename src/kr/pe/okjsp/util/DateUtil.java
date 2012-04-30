package kr.pe.okjsp.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	/**
	 * @param date "yyyy-MM-dd"
	 * @return String
	 */
	public static boolean isValidDate(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String format = null;
		try {
			format = sdf.format(sdf.parse(date));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date.equals(format);
	}
	
	/**
	 * @param date "yyyy-MM-dd"
	 * @param numberOfDays
	 * @return String
	 */
	public static String addDate(String date, int numberOfDays) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String format = null;
		try {
			Date d = new Date(sdf.parse(date).getTime() + numberOfDays * 1000 * 60 * 60 * 24);
			format = sdf.format(d);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return format;
	}

	public static Date parse(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return sdf.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
