package kr.pe.okjsp.tag;

import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import kr.pe.okjsp.util.CommonUtil;

/**
 * 게시판 목록의 페이지 네비게이션 링크를 담당하는 커스텀 태그 핸들러입니다.
 * @author  kenu
 */
public class PagingTag
	extends TagSupport {
	int total;          // 총 게시물 수
    int cpage;          // 현재 페이지
    int pageTotal;      // 전체 페이지 수
    int pageSize;       // 페이지 게시물 수
    int pageGroupSize;  // 페이지 리스트 사이즈
    int pageGroupStart; // 페이지 리스트 그룹시작번
    int pageGroupEnd;   // 페이지 리스트 그룹 끝번
	String link;
	String beginLabel;
	String endLabel;
	String prevLabel;
	String nextLabel;

    public int doStartTag()
		throws JspException
    {
        try {
            StringBuffer sbuf = new StringBuffer();
            HttpServletRequest request =
                (HttpServletRequest)pageContext.getRequest();

            cpage = Integer.parseInt(CommonUtil.nchk(request.getParameter("pg"),"0"));
            total = Integer.parseInt((String)request.getAttribute("total"));
            pageSize = Integer.parseInt((String)request.getAttribute("pageSize"));
            pageTotal = (total-1)/pageSize;

            pageGroupStart = (cpage/pageGroupSize) * pageGroupSize;
            pageGroupEnd   = pageGroupStart + pageGroupSize;
            if (pageGroupEnd>pageTotal)
                pageGroupEnd = pageTotal + 1;

            boolean hasPreviousPage = cpage-pageGroupSize>=0;
            boolean hasNextPage     = pageGroupStart+pageGroupSize < pageTotal+1;

            sbuf.append(makeLink(0, beginLabel));

            if (hasPreviousPage) {
                sbuf.append(makeLink(pageGroupStart-1, prevLabel));
            } // end if

            for(int i=pageGroupStart; i<pageGroupEnd ;i++){
            	if (i==cpage) {
                    sbuf.append("[<b>")
                        .append(i+1)
                        .append("</b>]");
            	} else {
                    sbuf.append(makeLink(i, "["+(i+1)+"]"));
            	} // end if
            } // end for

            if (hasNextPage) {
                sbuf.append(makeLink(pageGroupEnd, nextLabel));
            } // end if

            sbuf.append(makeLink(pageTotal, endLabel));

            pageContext.getOut().print(sbuf);

        } catch(IOException ioe) {
          throw new JspTagException("Error:  IOException while writing to the user");
        } catch(Exception e) {
          throw new JspTagException("Error:  Exception while writing to the user"
                                    +e.getMessage() );
        }
        return SKIP_BODY;
    }

    public String makeLink(int page, String label) {
        StringBuffer tmp = new StringBuffer();

        tmp.append("<a href='"+link+page+"'>")
            .append(label)
            .append("</a>");

        return tmp.toString();
    }

    /**
	 * @param value
	 * @uml.property  name="link"
	 */
    public void setLink(String value) {
        link = value+"&pg=";
    }

    public void setPrevlabel(String value) {
        prevLabel = value;
    }

    public void setNextlabel(String value) {
        nextLabel = value;
    }

    public void setBeginlabel(String value) {
        beginLabel = value;
    }

    public void setEndlabel(String value) {
        endLabel = value;
    }

    public void setPagegroupsize(int value) {
        pageGroupSize = value;
    }

}
