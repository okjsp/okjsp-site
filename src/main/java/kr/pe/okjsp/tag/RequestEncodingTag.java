package kr.pe.okjsp.tag;

import javax.servlet.http.*;
import javax.servlet.jsp.tagext.*;

/**
 * request 에서 넘어오는 파라메터에 일괄 인코딩한다.
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
