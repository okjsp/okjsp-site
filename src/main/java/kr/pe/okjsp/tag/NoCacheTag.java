package kr.pe.okjsp.tag;

/**
 * @author kenu
 *
 * ĳ�ø� �����ϴ� �±��ڵ鷯�Դϴ�.
 */

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * cache �� ����� ����
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
