/*
 * Created on 2003. 4. 28.
 *
 */
package kr.pe.okjsp.util;

import java.util.Collection;

import junit.framework.TestCase;
import kr.pe.okjsp.BbsInfoBean;
import kr.pe.okjsp.SiteSearch;

/**
 * @author kenu
 *
 */
public class SiteSearchTest extends TestCase {

	public void testSearchContentWith() {
		String keyword="hello";
		SiteSearch ss = new SiteSearch();
		try {
			Collection<BbsInfoBean> result = ss.searchContentWith(keyword);
			assertNotNull(result);
			assertTrue(result.size()>0);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
