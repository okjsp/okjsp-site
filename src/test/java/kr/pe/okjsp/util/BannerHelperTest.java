/*
 * Created on 2004. 10. 16.
 */
package kr.pe.okjsp.util;

import java.text.ParseException;

import junit.framework.TestCase;
import kr.pe.okjsp.util.BannerHelper;

/**
 * @author kenu_at_okjsp.pe.kr
 *  
 */
public class BannerHelperTest extends TestCase {
	public void testIsValid() throws ParseException {
		BannerHelper bh = new BannerHelper();
		bh.setDuration("20041018", "20041020");

		assertFalse(bh.isValid("20041017"));

		assertTrue(bh.isValid("20041018"));
		assertTrue(bh.isValid("20041019"));
		assertTrue(bh.isValid("20041020"));

		assertFalse(bh.isValid("20041021"));
	}
}