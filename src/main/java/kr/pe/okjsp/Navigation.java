package kr.pe.okjsp;

import java.util.Enumeration;
import java.util.ResourceBundle;

import kr.pe.okjsp.util.CommonUtil;

public class Navigation {
	private static ResourceBundle urls = ResourceBundle.getBundle("URL");
	public static String getPath(String key) {
		return CommonUtil.a2kProp(urls.getString(key));
	}
	public static Enumeration<String> getKeys() {
		return urls.getKeys();
	}
}
