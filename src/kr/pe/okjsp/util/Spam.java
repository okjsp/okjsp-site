package kr.pe.okjsp.util;

import java.io.IOException;

public class Spam {

	public static void checkSpammer(long sid) throws IOException {
		if  (sid == 19765 || sid == 17004 || sid == 19384) {
			throw new IOException("NO RIGHT TO USE!!!");
		}
	}

}
