package kr.pe.okjsp;

import java.util.ArrayList;

import junit.framework.TestCase;

public class MemoHandlerTest extends TestCase {
	public void testGetRecent() {
		MemoHandler handler = new MemoHandler();
		try {
			ArrayList<MemoBean> recent = handler.getRecent(1);
			assertNotNull(recent);
			assertEquals(20,recent.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
