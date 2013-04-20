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
		if (url.toLowerCase().startsWith("http://okjsp.")) {
			url = url.replaceFirst("http://", "http://www.");
		}
		return url;
	}

	public static String getDomain(String url) {
		if (url == null || url.length() <= 8 ) return url;
		int idx = url.indexOf("/", 8);
		
		return url.substring(0, idx);
	}

	public static String getDomain(StringBuffer url) {
		return getDomain(url.toString());
	}

	public static String getSecureDomain(String url) {
		return getSecureURL(getDomain(url));
	}
	
	public static String getSecureDomain(StringBuffer url) {
		return getSecureURL(getDomain(url.toString()));
	}

	public static String getBaseDomain(String url) {
		int idx = url.indexOf("www.");
		return getDomain(url).substring(idx + 4);
	}
	
	public static String getBaseDomain(StringBuffer url) {
		return getBaseDomain(url.toString());
	}


}
