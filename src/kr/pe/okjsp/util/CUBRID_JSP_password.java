package kr.pe.okjsp.util;

import java.security.MessageDigest;
import java.security.GeneralSecurityException;

/**
 * <pre>
 * MySQL의 MD5(), PASSWORD(), OLD_PASSWORD() 함수를 
 * 큐브리드의 자바 저장 함수로 만들어 각 데이터베이스에 
 * 등록해 일반적인 내장 함수처럼 그대로 사용할 수 있도록한 것입니다.
 * 
 * http://www.cubrid.com/online_manual/cubrid_820/syntax/syntax_javasp_settings.htm
 * http://okjsp.pe.kr/seq/110809
 * </pre>
 */

public class CUBRID_JSP_password {
    public static String MD5(String inpara) {
        byte[] bpara = new byte[inpara.length()]; 
        byte[] rethash;
        int i; 

        for (i=0; i < inpara.length(); i++) 
            bpara[i] = (byte)(inpara.charAt(i) & 0xff );

        try {
            MessageDigest md5er = MessageDigest.getInstance("MD5");
            rethash = md5er.digest(bpara);
        } catch (GeneralSecurityException e) { 
            throw new RuntimeException(e); 
        }

        StringBuffer r = new StringBuffer(32);
        for (i=0; i < rethash.length; i++) {
            String x = Integer.toHexString(rethash[i] & 0xff);
            if (x.length()<2) 
                r.append("0");
            r.append(x);
        }
        return r.toString();
    }

    public static String PASSWORD(String inpara) {
        byte[] bpara = new byte[inpara.length()]; 
        byte[] rethash;
        int i; 

        for (i=0; i < inpara.length(); i++) 
            bpara[i] = (byte)(inpara.charAt(i) & 0xff );

        try {
            MessageDigest sha1er = MessageDigest.getInstance("SHA1");
            rethash = sha1er.digest(bpara);     // stage1
            rethash = sha1er.digest(rethash);   // stage2
        } catch (GeneralSecurityException e) { 
            throw new RuntimeException(e); 
        }

        StringBuffer r = new StringBuffer(82);
        r.append("*");
        for (i=0; i < rethash.length; i++) {
            String x = Integer.toHexString(rethash[i] & 0xff).toUpperCase();
            if (x.length()<2) 
                r.append("0");
            r.append(x);
        }
        return r.toString();
    }

    public static String OLD_PASSWORD(String inpara) {
        byte[] bpara = new byte[inpara.length()]; 
        long lvar1 = 1345345333;
        long ladd = 7;
        long lvar2 = 0x12345671;
        int i; 
        
        if (inpara.length() <= 0)
          return "";

        for (i=0; i < inpara.length(); i++) 
          bpara[i] = (byte)(inpara.charAt(i) & 0xff );

        for (i=0; i < inpara.length(); i++) {
            if (bpara[i] == ' ' ||
                bpara[i] == '\t') continue;
          lvar1 ^= (((lvar1 & 63) + ladd) * bpara[i]) + (lvar1 << 8);
          lvar2 += (lvar2 << 8) ^ lvar1;
          ladd += bpara[i];
        }

        lvar1 = lvar1 & 0x7fffffff;
        lvar2 = lvar2 & 0x7fffffff;

        StringBuffer r = new StringBuffer(16);
        String x = Long.toHexString(lvar1);
        for (i = 8; i > x.length(); i --)
          r.append("0");
        r.append(x);
        
        x = Long.toHexString(lvar2);
        for (i = 8; i > x.length(); i --)
          r.append("0");
        r.append(x);
        return r.toString();
    }
}
