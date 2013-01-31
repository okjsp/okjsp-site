package kr.pe.okjsp.util;

import junit.framework.TestCase;

public class DomainUtilTest extends TestCase {
	public void testGetSecureURL() {
		String url = "http://www.okjsp.pe.kr/mashup/ip.jsp";
		String secureURL = DomainUtil.getSecureURL(url);
		assertEquals("https://www.okjsp.pe.kr/mashup/ip.jsp", secureURL);
	}
	
	public void testFailedURL() {
		assertEquals("http://", DomainUtil.getSecureURL("http://"));
	}
	
	public void testFixedDomain() {
		assertEquals("", DomainUtil.getFixedURL(null));
		assertEquals("http://www.okjsp.pe.kr", DomainUtil.getFixedURL("http://okjsp.pe.kr"));
		assertEquals("http://www.okjsp.pe.kr/bbs", DomainUtil.getFixedURL("http://okjsp.pe.kr/bbs"));
		assertEquals("http://www.OKJSP.pe.kr", DomainUtil.getFixedURL("http://OKJSP.pe.kr"));
	}
}
