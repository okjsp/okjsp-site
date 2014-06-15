package kr.pe.okjsp.tag;

/**
 * @author kenu
 *
 * 캐시를 제거하는 태그핸들러입니다.
 */

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * cache 를 지우는 역할
 */
public class NoCacheTag extends TagSupport
{

	public int doStartTag() {
		HttpServletResponse res =
				(HttpServletResponse) pageContext.getResponse();
		res.setHeader ("Cache-Control", "no-cache");
		res.setDateHeader("Expires", 0);
		res.setHeader ("Pragma", "No-cache");
		return SKIP_BODY;
	}
}
