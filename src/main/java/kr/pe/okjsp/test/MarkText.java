package kr.pe.okjsp.test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 단어를 검색해서 표시할 때 원문의 대소문자를 보존하고 표시하는 메소드
 * @author kenu
 * <p>contact http://okjsp.pe.kr</p>
 */
public class MarkText {

	public static void main(String[] args) 
	{
		String word = "property";
		String str = " use property attribute in the jsp:setProperty tag ";
		System.out.print(markKeyword(str, word));
	}

	/**
	 * 대소문자를 상관하지 않고 str 문자열에 포함된 keyword 를 찾아서 
	 * 원래의 문자에 붉은색 폰트태그를 삽입한 문자열 반환 Method markKeyword.
	 * <p>by kenu at http://okjsp.pe.kr</p>
	 * @param str
	 * @param keyword
	 * @return String
	 */
	public static String markKeyword(String str, String keyword) {
		keyword =
			replace(
				replace(replace(keyword, "[", "\\["), ")", "\\)"),
				"(", "\\(");

		Pattern p = Pattern.compile( keyword , Pattern.CASE_INSENSITIVE );
		Matcher m = p.matcher( str );
		int start = 0;
		int lastEnd = 0;
		StringBuffer sbuf = new StringBuffer();
		while( m.find() ) {
			start = m.start();
			sbuf.append( str.substring(lastEnd, start) )
				.append("<font color='red'>"+m.group()+"</font>" );
			lastEnd = m.end();
		} 
		return sbuf.append(str.substring(lastEnd)).toString() ;
	}

	/**
	 * Method replace 문자열에서 일정 부분을 다른 부분으로 대치하는 메소드 
	 * author 심민우 mailto:minwoo1975@hanmail.net
	 * from; http://javaservice.net
	 * @param str
	 * @param oldStr
	 * @param newStr
	 * @return String
	 */
	public static String replace(String str, String oldStr, String newStr) {

		if (str == null) {
			return null;
		}
		if (oldStr == null || newStr == null || oldStr.length() == 0) {
			return str;
		}

		int i = str.lastIndexOf(oldStr);
		if (i < 0)
			return str;

		StringBuffer sbuf = new StringBuffer(str);

		while (i >= 0) {
			sbuf.replace(i, (i + oldStr.length()), newStr);
			i = str.lastIndexOf(oldStr, i - 1);
		}
		return sbuf.toString();
	}

}
