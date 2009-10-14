package kr.pe.okjsp.member;


import java.io.File;

import junit.framework.TestCase;

public class ProfileUtilTest extends TestCase {
	ProfileUtil profileUtil = new ProfileUtil();
	public void testCopy() throws Exception {
		String basePath = "web/profile/base/";
		String path = "web/profile/";
		String sourceImage = basePath +"default.jpg";
		String destImage = path+"default2.jpg";
		assertTrue(new File(sourceImage).exists());
		File file = new File(destImage);
		if(file.exists()) {
			file.delete();
		}
		assertFalse(file.exists());
		int exitValue = profileUtil.copy(sourceImage, destImage);
		assertEquals(0, exitValue);
	}
	public void testCopyDefaultProfile() {
		int result = profileUtil.copyDefaultProfile("web","id");
		assertEquals(1, result);
	}
}
