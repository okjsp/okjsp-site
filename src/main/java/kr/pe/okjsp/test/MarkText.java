package kr.pe.okjsp.test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * �ܾ �˻��ؼ� ǥ���� �� ������ ��ҹ��ڸ� �����ϰ� ǥ���ϴ� �޼ҵ�
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
	 * ��ҹ��ڸ� ������� �ʰ� str ���ڿ��� ���Ե� keyword �� ã�Ƽ� 
	 * ������ ���ڿ� ������ ��Ʈ�±׸� ������ ���ڿ� ��ȯ Method markKeyword.
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
	 * Method replace ���ڿ����� ���� �κ��� �ٸ� �κ����� ��ġ�ϴ� �޼ҵ� 
	 * author �ɹο� mailto:minwoo1975@hanmail.net
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
