package kr.pe.okjsp.tag;

import javax.servlet.http.*;
import javax.servlet.jsp.tagext.*;

/**
 * request ���� �Ѿ���� �Ķ���Ϳ� �ϰ� ���ڵ��Ѵ�.
 */
public class RequestEncodingTag
    extends TagSupport
{

    public int doEndTag() {
        HttpServletRequest req =
                (HttpServletRequest) pageContext.getRequest();
        try {
        req.setCharacterEncoding("MS949");
        } catch (java.io.UnsupportedEncodingException e) {
            System.out.println( e.toString() );
        }
        return SKIP_BODY;
    }
}
