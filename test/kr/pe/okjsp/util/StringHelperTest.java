/*
 * Created on 2004. 11. 22.
 */
package kr.pe.okjsp.util;

import java.io.UnsupportedEncodingException;

import junit.framework.TestCase;

/**
 * @author kenu_at_okjsp.pe.kr
 * 
 */
public class StringHelperTest extends TestCase {
	public void testReadUnicode() {
		String string = "&#44608;&#44049;&#46028;";
		String c2 = StringHelper.readUnicode(string);
		assertEquals("김갑돌", c2);
	}

	public void testReadUnicode2() {
		String string = "&#44608;&#44049; &#46028;";
		String c2 = StringHelper.readUnicode(string);
		assertEquals("김갑 돌", c2);
	}

	public void testReadUnicode3() {
		String string = "abc";
		String c2 = StringHelper.readUnicode(string);
		assertEquals("abc", c2);
	}

	public void testReadNull() {
		String string = null;
		String c2 = StringHelper.readUnicode(string);
		assertEquals(null, c2);
	}

	public void testSplit() {
		String[] strings = "&#44608;&#44049;&#46028;".split("&#");
		assertEquals(4, strings.length);
		assertEquals("", strings[0]);
		assertEquals("44608;", strings[1]);
	}

	public void testCode() {
		String unicode = "&#xAC00;&#xB098;&#xB2E4;&#xB77C;&#xB9C8;";
		assertEquals("가나다라마", StringHelper.readUnicode(unicode));
	}

	public void testCodeMixed() {
		String unicode = "&#xAC00;&#xB098;가나&#xB2E4;&#xB77C;&#xB9C8;";
		assertEquals("가나가나다라마", StringHelper.readUnicode(unicode));
	}

	String string = "자바와 한글";

	String[] charsets = { "ms949", "8859_1", "utf-8" };

	public void _testChangeCharSet() throws UnsupportedEncodingException {
		for (int i = 0; i < charsets.length; i++) {
			for (int j = 0; j < charsets.length; j++) {
				if (i == j)
					continue;
				System.out.print(i + ":" + j + " ");
			}
		}
	}

	public void testChangeCharSet2() throws UnsupportedEncodingException {
		String test_str = new String((string).getBytes("utf-8"), "8859_1");
		String test_result = new String(test_str.getBytes("8859_1"), "utf-8");
		byte[] bytes = test_result.getBytes();
		assertEquals(-64, (int) bytes[0]);
		assertEquals(-37, (int) bytes[10]);
		assertEquals(string, new String(bytes));
		assertEquals(string, test_result);
	}
	
	public void testGetURLString() {
		String input = "서울시 강우량 정보";
		String output = "%EC%84%9C%EC%9A%B8%EC%8B%9C+%EA%B0%95%EC%9A%B0%EB%9F%89+%EC%A0%95%EB%B3%B4";
		assertEquals(output, StringHelper.getURLString(input));
	}
	public void testGetURLStringExtend() {
		String input = "http://openapi.seoul.go.kr:8088/xml/4150495f323038396b656e7568656f/서울시 강우량 정보/1/50";
		String output = "http://openapi.seoul.go.kr:8088/xml/4150495f323038396b656e7568656f/%EC%84%9C%EC%9A%B8%EC%8B%9C+%EA%B0%95%EC%9A%B0%EB%9F%89+%EC%A0%95%EB%B3%B4/1/50";
		assertEquals(output, StringHelper.getURLString(input));
	}
	
	public void testChangeString() {
		String input = "&#49436;&#50872;&#49884; &#44053;&#50864;&#47049; &#51221;&#48372;";
		String output = "서울시 강우량 정보";
		assertEquals(output, StringHelper.readUnicode(input));
	}



}
