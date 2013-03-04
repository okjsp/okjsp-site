package kr.pe.okjsp.util;

import java.io.IOException;

public class Spam {

	public static void checkSpammer(long sid) throws IOException {
		if  (sid == 21100 || sid == 20323 
				|| sid == 19765 || sid == 17004 || sid == 19384|| sid == 19826) {
			throw new IOException("NO RIGHT TO USE!!!");
		}
	}

}
