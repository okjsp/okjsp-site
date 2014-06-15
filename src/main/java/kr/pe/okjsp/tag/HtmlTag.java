package kr.pe.okjsp.tag;

import java.io.*;

import kr.pe.okjsp.util.CommonUtil;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 * html еб╠в
 */
public class HtmlTag extends BodyTagSupport
{
    private String br = "false";
    public int doEndTag() throws JspException {

        if( bodyContent == null )
            return EVAL_PAGE;

        try {
            String text = bodyContent.getString();
			text = CommonUtil.rplc(text,"<", "&lt;");
            if( "true".equals(br) ) {
				text = CommonUtil.rplc(text,"\n", "<br>");
            }
            pageContext.getOut().print(text);
        } catch (IOException e) {
            throw new JspException(e.toString());
        }

        return EVAL_PAGE;
    }

	/**
	 * Sets the br.
	 * @param br  The br to set
	 * @uml.property  name="br"
	 */
	public void setBr(String br) {
		this.br = br;
	}

}
