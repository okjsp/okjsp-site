package kr.pe.okjsp.member;

import java.io.IOException;

public class ProfileUtil {

	public final static String defaultName = "0.jpg";

	public int copyDefaultProfile(String contextRoot, long sid) {
		String sourcePath = contextRoot + "/profile/base/" + defaultName;
		String destPath = contextRoot + "/profile/" + sid + ".jpg";
		int result = 0;
		try {
			result = 1 - copy(sourcePath, destPath);
		} catch (IOException e) {
			System.out.println(e);
		} catch (InterruptedException e) {
			System.out.println(e);
		}
		return result;
	}

	public int copy(String sourcePath, String destPath) throws IOException,
			InterruptedException {
		Runtime runtime = Runtime.getRuntime();
		Process exec = runtime.exec("cp " + sourcePath + " " + destPath);
		exec.waitFor();
		return exec.exitValue();
	}
}
