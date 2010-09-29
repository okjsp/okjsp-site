package kr.pe.okjsp.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;


/**
 * �� ���ø����̼ǿ� ����ϴ� ��� �޼ҵ带 ��Ƴ��� ���� Ŭ�����Դϴ�.
 * <p><a href="http://okjsp.pe.kr/lecture/lec04/package01.html">������ ���</a> </p>
 * @author kenu
 * <a href="http://okjsp.pe.kr" target="_blank">http://okjsp.pe.kr</a>
 * @version 1.1 - 2003/02/08
 */
public class CommonUtil {

	/**
	 * Method a2k. 8859_1 ���� MS949 �� ���ڼ�Ʈ��ȯ
	 * # 20091025 ��� ť�긮��� �ٲ�鼭 ���ڼ��� �ٲ� ��ȯ�� �ʿ�������
	 *   �����޼ҵ��� ������ a2kProp���� ����ϸ� �ȴ�.
	 * @param str �ٲٷ��� ���ڿ�
	 * @return String
	 */
	public static String a2k(String str) {
		try {
//			return new String(str.getBytes("8859_1"),"MS949");
			return str;
		} catch (Exception e) {
		    return "";
		}
	}

	/**
	 * <pre>
	 * ������ a2k�� ������ ������ �ϴ� �Լ�
	 * Navigation.getPath()������ ���
	 * </pre>
	 * @param str
	 * @return
	 */
	public static String a2kProp(String str) {
		try {
			return new String(str.getBytes("8859_1"),"MS949");
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * Method k2a. MS949 ���� 8859_1 �� ���ڼ�Ʈ��ȯ
	 * @param str �ٲٷ��� ���ڿ�
	 * @return String
	 */
    public static String k2a(String str) {
		return str;
	}

	/**
	 * Method formatDate.
	 * @param date Date �� ��¥
	 * @param format ��¥ ����
	 * @return String
	 */
	public static String formatDate(java.util.Date date, String format) {
	    if(date==null || format == null)
	        return null;
	    SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}

	/**
	 * Method showHtml. �±� ���̰�, �ٹٲ� ���ڸ� &lt;br> �±׷� ��ȯ
	 * @param str
	 * @return String
	 */
	public static String showHtml(String str) {
	    if(str==null)
	        return "";
		return rplc( rplc(str, "<", "&lt;"),
		             "\n", "<br>");
	}

	/**
	 * Method nchk.
	 * @param str
	 * @return String
	 */
	public static String nchk(String str) {
		return nchk(str, "");
	}

	/**
	 * Method nchk.
	 * @param str
	 * @param defaultStr
	 * @return String
	 */
	public static String nchk(String str, String defaultStr) {
		return (str==null)?defaultStr:str;
	}

    /**
     * Method rplc
     * author �ɹο� mailto:minwoo1975@hanmail.net
     * from; http://javaservice.net
     * @param mainString
     * @param oldString
     * @param newString
     * @return String
     */
    public static String rplc(
    	String mainString,
    	String oldString,
    	String newString) {
    	if (mainString == null) {
    		return null;
    	}
    	if (oldString == null || oldString.length() == 0 || newString == null) {
    		return mainString;
    	}

    	int i = mainString.lastIndexOf(oldString);
    	if (i < 0)
    		return mainString;

    	StringBuffer mainSb = new StringBuffer(mainString);

    	while (i >= 0) {
    		mainSb.replace(i, (i + oldString.length()), newString);
    		i = mainString.lastIndexOf(oldString, i - 1);
    	}
    	return mainSb.toString();
    }

   /**
	 * Method crop. ���ڿ� �ڸ�����ŭ �����ֱ�
	 * @param str ���ڿ�
	 * @param i �ڸ���
	 * @return String
	 */
	public static String crop(String str, int i) {
    	if (str==null) return "";
    	return (str.length()>i)
    			? str.substring(0,i)+"..."
    			: str;
    }

    /**
	 * Method cropByte. ���ڿ� ����Ʈ����ŭ �����ְ�, ��ǥ���ϱ�
	 * @param str ���ڿ�
	 * @param i ����Ʈ��
	 * @param trail �� ���ڿ�. ��) "..."
	 * @return String
	 */
	public static String cropByte(String str, int i, String trail) {
    	if (str==null) return "";
    	String tmp = str;
    	int slen = 0, blen = 0;
    	char c;
    	try {
        	if(tmp.getBytes("MS949").length>i) {
        		while (blen+1 < i) {
        			c = tmp.charAt(slen);
        			blen++;
        			slen++;
        			if ( c  > 127 ) blen++;  //2-byte character..
        		}
        		tmp=tmp.substring(0,slen)+trail;
        	}
        } catch(java.io.UnsupportedEncodingException e) {
        	System.out.println("Unsupported Encoding:"+str);
        }
    	return tmp;
    }

    /**
	 * Method setCookie.
	 * @param response
	 * @param name111
	 * @param value
	 * @param iMinute
	 * @throws UnsupportedEncodingException
	 */
//	public static void setCookie(HttpServletResponse response,
//                                 String name,
//                                 String value,
//                                 int iMinute)
//                                 throws java.io.UnsupportedEncodingException {
//    	Cookie cookie = new Cookie(name, java.net.URLEncoder.encode(
//    		CommonUtil.nchk(value), "utf-8"));
//    	cookie.setMaxAge(60 * iMinute);
//    	cookie.setPath("/");
////    	cookie.setDomain("127.0.0.1");
//    	cookie.setDomain("okjsp.pe.kr");
//    	response.addCookie(cookie);
//    }

    /**
	 * Method setCookie.
	 * @param response
	 * @param name
	 * @param value
	 * @throws UnsupportedEncodingException
	 */
//	public static void setCookie(HttpServletResponse response,
//                                 String name,
//                                 String value)
//                                 throws java.io.UnsupportedEncodingException {
//        setCookie(response, name, value, 60*24*15);
//    }

    /**
	 * Method getCookie.
	 * @param request
	 * @param cookieName
	 * @return String
	 * @throws Exception
	 */
//	public static String getCookie(HttpServletRequest request, String cookieName) {
//    	Cookie [] cookies = request.getCookies();
//    	if (cookies==null) return "";
//    	String value = "";
//    	for(int i=0;i<cookies.length;i++) {
//    		if(cookieName.equals(cookies[i].getName())) {
//    			try {
//					value = java.net.URLDecoder.decode(cookies[i].getValue(),"utf-8");
//				} catch (UnsupportedEncodingException e) {
//					e.printStackTrace();
//				}
//    			break;
//    		}
//    	}
//    	return value;
//    }
//	
//	public static long getCookieLong(HttpServletRequest request, String cookieName) {
//		long value = 0;
//		try {
//			value = Long.parseLong(getCookie(request, cookieName));
//		} catch (Exception e) {
//		}
//		return value;
//	}

	/**
	 * �±� ���� ���;
	 * author: hsboy@aboutjsp.com
	 * @param str
	 * @param delimiter "<" or else
	 * @return String
	 */
	public static String removeTag(String str, String delimiter){
		int lt = str.indexOf(delimiter);
		
		if ( lt != -1 ) {
			int gt = str.indexOf(">", lt);
			if ( (gt != -1) ) {
				str = str.substring( 0, lt ) + str.substring( gt + 1 );
				// ��� ȣ��
				str = removeTag(str, delimiter);
			}
		}
		return str;
	}
	
	/**
	 * �±� ���� ���(2010.03.25 ������[Coma] �߰�);
	 * @param str
	 * ��ó : http://ecogeo.tistory.com/tag/html%ED%83%9C%EA%B7%B8%EC%A0%9C%EA%B1%B0
	 * @return
	 */
	public static String removeTag(String str){
		String strNoHTMLString = "<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>";
		String strReturn = "";
		
		strReturn = str.replaceAll(strNoHTMLString, "");
		return strReturn;
	}

	
	/**
	 * seq number �ҷ�����
	 * @param pathInfo
	 * @return
	 */
	public static long getNumberedSeq(String pathInfo) {
		long seq = 0;
		try {
			seq = Long.parseLong(pathInfo.substring(1));
		} catch (NumberFormatException e) {
			int length = pathInfo.length();
			for (int i = 1; i < length; i++) {
				char charAt = pathInfo.charAt(i);
				if (charAt >= '0' && charAt <= '9') {
					seq = seq*10 + (charAt - '0');
				} else {
					break;
				}
			}
		}
		return seq;
	}

}