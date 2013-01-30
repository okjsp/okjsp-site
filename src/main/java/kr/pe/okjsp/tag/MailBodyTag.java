package kr.pe.okjsp.tag;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 * ���� ����
 */
public class MailBodyTag extends BodyTagSupport
{

    public int doStartTag() throws JspException {

        // �θ��±׸� ���´�. ���� ��� ���� �߻�
        MailTag parent =
        	(MailTag)findAncestorWithClass(this, MailTag.class);
        if(parent == null)
        	throw new JspTagException("message tag ���ο� �־�� �˴ϴ�.");

        return EVAL_BODY_BUFFERED;
    }

    public int doAfterBody() {
        // �θ��±��� body �ʵ忡 ���� �Է��Ѵ�.
    	MailTag parent =
        	(MailTag)findAncestorWithClass(this, MailTag.class);
		parent.setBody(getBodyContent().getString());

    	return SKIP_BODY;
    }

}
