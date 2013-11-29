package kr.pe.okjsp.util;

import java.io.IOException;

public class Spam {

	public static void checkSpammer(long sid) throws IOException {
		if  (sid == 21797 || sid == 6297 || sid == 15548 || sid == 19847 || sid == 24706 || sid == 24830) {
			throw new IOException("NO RIGHT TO USE!!!");
		}
	}

}
