/*
 * Created on 2004. 11. 22.
 */
package kr.pe.okjsp.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 * @author kenu_at_okjsp.pe.kr
 *
 */
public class StringHelper {
    /**
     * read unicode string as character string
     * @param encodedString
     * @return decodedString
     * @author kenu_at_okjsp.pe.kr
     */
    public static String readUnicode(String encodedString) {
    	if (encodedString == null) return null;
        String [] part = encodedString.split("&#");
        int idx = 0;
        char decodedChar = 0;
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < part.length; i++) {
            idx = part[i].indexOf(';');
            if (idx > 0) {
            	int unit;
                String unicodeStr = part[i].substring(0,idx);
                if(unicodeStr.startsWith("x")) {
                	unicodeStr = unicodeStr.substring(1);
                	unit = 16;
                } else {
                	unit = 10;
                }
				decodedChar = (char) Integer.parseInt(unicodeStr, unit);
                part[i] = decodedChar + part[i].substring(idx+1);
            }
            sb.append(part[i]);
        }
        return sb.toString();
    }
    
	public static String getURLString(String input) {
		String encode = null;
		try {
			encode = URLEncoder.encode(input, "utf-8");
			encode = encode.replaceAll("%3A", ":");
			encode = encode.replaceAll("%2F", "/");
			encode = encode.replaceAll("%3F", "?");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return encode;
	}

}