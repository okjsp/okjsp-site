/*
 * Created on 2004. 10. 16.
 */
package kr.pe.okjsp.util;


/**
 * @author kenu_at_okjsp.pe.kr
 *  
 */
public class BannerHelper {

	private String startDate;
	private String endDate;

	/**
	 * @param date
	 * @return
	 */
	public boolean isValid(String date) {
		boolean after = date.compareTo(startDate) > -1;
		boolean before = date.compareTo(endDate) < 1;
		return after && before;
	}

	/**
	 * @param sdate
	 * @param edate
	 */
	public void setDuration(String sdate, String edate) {
		startDate = sdate;
		endDate = edate;
	}

}