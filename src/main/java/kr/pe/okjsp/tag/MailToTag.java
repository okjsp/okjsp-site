package kr.pe.okjsp.tag;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 * 메일 송신자
 */
public class MailToTag extends BodyTagSupport
{

    public int doStartTag() throws JspException {

        // 부모태그를 얻어온다. 없을 경우 예외 발생
        MailTag parent =
        	(MailTag)findAncestorWithClass(this, MailTag.class);
        if(parent == null)
        	throw new JspTagException("message tag 내부에 있어야 됩니다.");

        return EVAL_BODY_BUFFERED;
    }

    public int doAfterBody() {
        // 부모태그의 yo 필드에 값을 입력한다.
    	MailTag parent =
        	(MailTag)findAncestorWithClass(this, MailTag.class);
		parent.setTo(getBodyContent().getString());

    	return SKIP_BODY;
    }

}
