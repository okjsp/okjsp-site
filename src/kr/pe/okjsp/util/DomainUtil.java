package kr.pe.okjsp.util;

public class DomainUtil {

	public static String getSecureURL(String url) {
		if (url == null || url.length() <= 7 ) return url;
		if (url.toLowerCase().startsWith("http://")) {
			url = "https://" + url.substring(7);
		}
		return url;
	}

	public static String getFixedURL(String url) {
		if (url == null) return "";
		if (url.toLowerCase().startsWith("http://okjsp.pe.kr")) {
			url = url.replaceFirst("http://", "http://www.");
		}
		return url;
	}

}
