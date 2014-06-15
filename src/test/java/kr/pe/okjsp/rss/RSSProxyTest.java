package kr.pe.okjsp.rss;

import java.io.IOException;

import junit.framework.TestCase;

public class RSSProxyTest extends TestCase {
	public void _testGetXML() throws IOException {
		String url = "http://www.okjsp.pe.kr/rss/okjsp-rss2.jsp?bbs=bbs4";

		assertNotNull(RSSProxy.getXML(url, "euc-kr"));
		String xmlDefault = RSSProxy.getCachedXML(url, "1");
		assertNotNull(xmlDefault);
	}
	public void testGetXMLSeoul() throws IOException {
		String url = "http://openapi.seoul.go.kr:8088/4150495f323038396b656e7568656f/xml/ListRainfallService/1/50/";
		String xml = RSSProxy.getXML(url, "utf-8");
		assertNotNull(xml);
		String xmlDefault = RSSProxy.getCachedXML(url, "1");
		assertNotNull(xmlDefault);
//		System.out.println(xmlDefault);
		assertEquals('<', xmlDefault.charAt(0));
		
	}
	
}
