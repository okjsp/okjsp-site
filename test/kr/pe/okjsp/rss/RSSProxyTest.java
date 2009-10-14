package kr.pe.okjsp.rss;

import java.io.IOException;

import junit.framework.TestCase;

public class RSSProxyTest extends TestCase {
	public void testGetXML() throws IOException {
		String url = "http://www.okjsp.pe.kr/rss/okjsp-rss2.jsp?bbs=bbs4";

		assertNotNull(RSSProxy.getXML(url, "euc-kr"));
		String xmlDefault = RSSProxy.getCachedXML(url, "1");
		assertNotNull(xmlDefault);
		assertNotNull(xmlDefault, RSSProxy.getXML(url, "utf-8"));
	}
}
