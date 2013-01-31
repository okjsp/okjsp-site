package kr.pe.okjsp.util;

import java.io.File;

import junit.framework.TestCase;

public class PropertyManagerTest extends TestCase {
	public void testFileCheck() {
		File file = new File("/etc/DB.properties");
		assertTrue(file.exists());
		String property = PropertyManager.getString("BITLYID");
		assertEquals("okjsp", property);
	}
}
