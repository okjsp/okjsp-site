package kr.pe.okjsp.util;

import java.io.IOException;

public class Spam {

	public static void checkSpammer(long sid) throws IOException {
		if  (sid == 21797) {
			throw new IOException("NO RIGHT TO USE!!!");
		}
	}

}
