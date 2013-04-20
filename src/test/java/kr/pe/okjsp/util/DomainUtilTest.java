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
	
	public void testOtherDomain() {
		assertEquals("http://www.okjsp.net/", DomainUtil.getFixedURL("http://www.okjsp.net/"));
	}
	public void testOtherSecureDomain() {
		assertEquals("https://www.okjsp.net/", DomainUtil.getSecureURL("http://www.okjsp.net/"));
	}
	public void testGetDomain() {
		assertEquals("http://www.okjsp.net", DomainUtil.getDomain("http://www.okjsp.net/bbs?act=FIRST_MAIN"));
	}
	
	public void testGetSecureDomain() {
		assertEquals("https://www.okjsp.net", DomainUtil.getSecureDomain("http://www.okjsp.net/bbs?act=FIRST_MAIN"));
	}
	public void testGetSecureDomainFromURL() {
		assertEquals("https://www.okjsp.net", DomainUtil.getSecureDomain("https://www.okjsp.net/jsp/member/login.jsp"));
	}
	
	public void testGetBaseDomain() {
		assertEquals("okjsp.net", DomainUtil.getBaseDomain("https://www.okjsp.net/jsp/member/login.jsp"));
		assertEquals("okjsp.pe.kr", DomainUtil.getBaseDomain("http://www.okjsp.pe.kr/"));
	}
	
}
