package kr.pe.okjsp.ad;

import junit.framework.TestCase;

public class AdLogDaoTest extends TestCase {
	public void testLog() throws Exception {
		AdLogDao dao = new AdLogDao();
		AdLog log = new AdLog();
		log.setUrl("http://test.okjsp.pe.kr/");
		log.setReferer("http://referer.okjsp.pe.kr/");
		log.setSid(0);
		log.setIp("0.0.0.0");
		int result = dao.log(log);
		assertEquals(1, result);
	}
}
