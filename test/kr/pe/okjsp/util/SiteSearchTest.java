/*
 * Created on 2003. 4. 28.
 *
 */
package kr.pe.okjsp.util;

import java.util.Collection;
import junit.framework.TestCase;
import kr.pe.okjsp.PopDb;
import kr.pe.okjsp.SiteSearch;

/**
 * @author kenu
 *
 */
public class SiteSearchTest extends TestCase {

	/**
	 * Constructor for SiteSearchTest.
	 * @param arg0
	 */
	public SiteSearchTest(String arg0) {
		super(arg0);
	}

	public void testGetResult() {
		String keyword="kenu";
		SiteSearch ss = new SiteSearch();
		ss.setKeyword(keyword);
		try {
			Collection hmap = ss.getResult();
			assertNotNull(hmap);
			assertTrue(hmap.size()>0);
			System.out.println(hmap.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		PopDb pd = new PopDb();
		super.setUp();
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		// 
		super.tearDown();
	}

}
