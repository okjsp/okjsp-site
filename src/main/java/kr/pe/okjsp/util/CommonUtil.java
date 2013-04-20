package kr.pe.okjsp.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 웹 어플리케이션에 사용하는 공용 메소드를 모아놓은 헬퍼 클래스입니다.
 * <p><a href="http://okjsp.pe.kr/lecture/lec04/package01.html">컴파일 방법</a> </p>
 * @author kenu
 * <a href="http://okjsp.pe.kr" target="_blank">http://okjsp.pe.kr</a>
 * @version 1.1 - 2003/02/08
 */
public class CommonUtil {

	/**
	 * Method a2k. 8859_1 에서 MS949 로 문자세트변환
	 * # 20091025 디비가 큐브리드로 바뀌면서 문자셋이 바뀌어서 변환이 필요없어졌음
	 *   기존메소드의 역할은 a2kProp으로 사용하면 된다.
	 * @param str 바꾸려는 문자열
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
	 * 기존의 a2k와 동일한 역할을 하는 함수
	 * Navigation.getPath()에서만 사용
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
	 * Method k2a. MS949 에서 8859_1 로 문자세트변환
	 * @param str 바꾸려는 문자열
	 * @return String
	 */
    public static String k2a(String str) {
		return str;
	}

	/**
	 * Method formatDate.
	 * @param date Date 형 날짜
	 * @param format 날짜 패턴
	 * @return String
	 */
	public static String formatDate(java.util.Date date, String format) {
	    if(date==null || format == null)
	        return null;
	    SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}

	/**
	 * Method showHtml. 태그 보이고, 줄바꿈 문자를 &lt;br> 태그로 변환
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
     * author 심민우 mailto:minwoo1975@hanmail.net
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
	 * Method crop. 문자열 자리수만큼 끊어주기
	 * @param str 문자열
	 * @param i 자리수
	 * @return String
	 */
	public static String crop(String str, int i) {
    	if (str==null) return "";
    	return (str.length()>i)
    			? str.substring(0,i)+"..."
    			: str;
    }

    /**
	 * Method cropByte. 문자열 바이트수만큼 끊어주고, 생략표시하기
	 * @param str 문자열
	 * @param i 바이트수
	 * @param trail 생략 문자열. 예) "..."
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
	 * 바이트로 문자열 substring
	 * @param string
	 * @param begin
	 * @param end
	 * @return
	 */
	public static String cropByte(String string, int begin, int end) {
    	int beginPos = 0, endPos = 0, bytelen = 0;
    	char c;
    	try {
        	if(string.getBytes("MS949").length>end) {
        		while (bytelen < end) {
        			c = string.charAt(endPos);
        			if ( bytelen < begin ) beginPos++;
        			bytelen++;
        			endPos++;
        			if ( c  > 127 ) bytelen++;  //2-byte character..
        		}
        		string=string.substring(beginPos,endPos);
        	}
        } catch(java.io.UnsupportedEncodingException e) {
        	System.out.println("Unsupported Encoding:"+string);
        }
    	return string;
	}

    /**
	 * Method setCookie.
	 * @param response
	 * @param name111
	 * @param value
	 * @param iMinute
     * @param domain 
	 * @throws UnsupportedEncodingException
	 */
	public static void setCookie(String domain,
                                 HttpServletResponse response,
                                 String name,
                                 String value,
                                 int iMinute)
                                 throws java.io.UnsupportedEncodingException {
    	Cookie cookie = new Cookie(name, java.net.URLEncoder.encode(
    		CommonUtil.nchk(value), "utf-8"));
    	cookie.setMaxAge(60 * iMinute);
    	cookie.setPath("/");
    	cookie.setDomain(domain);
    	response.addCookie(cookie);
    }

    /**
	 * Method setCookie.
	 * @param response
	 * @param name
	 * @param value
     * @param domain 
	 * @throws UnsupportedEncodingException
	 */
	public static void setCookie(String domain,
			                     HttpServletResponse response,
                                 String name,
                                 String value)
                                 throws java.io.UnsupportedEncodingException {
        setCookie(domain, response, name, value, 60*24*15);
    }

    /**
	 * Method getCookie.
	 * @param request
	 * @param cookieName
	 * @return String
	 * @throws Exception
	 */
	public static String getCookie(HttpServletRequest request, String cookieName) {
    	Cookie [] cookies = request.getCookies();
    	if (cookies==null) return "";
    	String value = "";
    	for(int i=0;i<cookies.length;i++) {
    		if(cookieName.equals(cookies[i].getName())) {
    			try {
					value = java.net.URLDecoder.decode(cookies[i].getValue(),"utf-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
    			break;
    		}
    	}
    	return value;
    }
	
	public static long getCookieLong(HttpServletRequest request, String cookieName) {
		long value = 0;
		try {
			value = Long.parseLong(getCookie(request, cookieName));
		} catch (Exception e) {
		}
		return value;
	}

	/**
	 * 태그 제거 기능;
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
				// 재귀 호출
				str = removeTag(str, delimiter);
			}
		}
		return str;
	}
	
	/**
	 * 태그 제거 기능(2010.03.25 윤정부[Coma] 추가);
	 * @param str
	 * 출처 : http://ecogeo.tistory.com/tag/html%ED%83%9C%EA%B7%B8%EC%A0%9C%EA%B1%B0
	 * @return
	 */
	public static String removeTag(String str){
		String strNoHTMLString = "<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>";
		String strReturn = "";
		
		strReturn = str.replaceAll(strNoHTMLString, "");
		return strReturn;
	}

	
	/**
	 * seq number 불러오기
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