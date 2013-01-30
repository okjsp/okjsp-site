package kr.pe.okjsp.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.pe.okjsp.util.HttpLinker;

/**
 * html еб╠в
 */
public class HttpLinkerTag extends BodyTagSupport {
	public int doEndTag() throws JspException {

		if (bodyContent == null)
			return EVAL_PAGE;

		try {
			pageContext.getOut().print(
				HttpLinker.getLinkedSource(bodyContent.getString()));
		} catch (IOException e) {
			throw new JspException(e.toString());
		}

		return EVAL_PAGE;
	}
}
