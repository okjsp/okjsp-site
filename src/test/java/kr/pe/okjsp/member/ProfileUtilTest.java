package kr.pe.okjsp.member;


import java.io.File;

import junit.framework.TestCase;

public class ProfileUtilTest extends TestCase {
	ProfileUtil profileUtil = new ProfileUtil();
	public void testCopy() throws Exception {
		String basePath = "src/main/webapp/profile/base/";
		String path = "src/main/webapp/profile/";
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
		int result = profileUtil.copyDefaultProfile("src/main/webapp", 0);
		assertEquals(1, result);
	}
}
