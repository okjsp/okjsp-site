package kr.pe.okjsp.member;


import java.io.File;

import junit.framework.TestCase;

public class ProfileUtilTest extends TestCase {
	ProfileUtil profileUtil = new ProfileUtil();
	public void testCopy() throws Exception {
		String basePath = "web/profile/base/";
		String path = "web/profile/";
		String sourceImage = basePath + ProfileUtil.defaultName;
		String destImage = path + ProfileUtil.defaultName;
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
		int result = profileUtil.copyDefaultProfile("web", 0);
		assertEquals(1, result);
	}
}
