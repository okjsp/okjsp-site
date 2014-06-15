<%@ page pageEncoding="euc-kr"
    import="kr.pe.okjsp.util.CommonUtil, java.util.Iterator,
            kr.pe.okjsp.Article,kr.pe.okjsp.util.DateLabel" %>
<%@ taglib uri="/WEB-INF/tld/taglibs-string.tld" prefix="str" %>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />
<%
	list.setPageSize(15);
	Iterator iter = list.getList().iterator();
	Article one = null;

while (iter.hasNext()) {
    one = (Article) iter.next();
%>
        <li>
            <img src="/iui/iui/icon_list.png" style="	float: left; height: 35px; width: 46px;	margin: -8px 0 -7px -10px" />
            <a href="/bbs?seq=<%= one.getSeq() %>&viewMode=IUI" target="_iui"><%= CommonUtil.showHtml(one.getSubject()) %>
            	&nbsp;<str:replace replace="[0]" with=""><span style="color:#BBB">(<%= one.getMemo() %>)</span></str:replace></a>
        </li>
<%
} // end ifwhile 
int total = list.getCnt();
int pageSize = list.getPageSize();
int pageTotal = (total-1) / pageSize;
boolean hasMorePage = list.getPg() < pageTotal;

if (hasMorePage) {	// Next Page 가 없으면 Page 버튼 숨긴다.
%>
<li><a href="/bbs?act=IUILISTDETAIL&bbs=<%=request.getParameter("bbs")%>&pg=<%= list.getPg() + 1 %>" target="_replace">Get Next Page Stories...</a></li>
<% 
} // end if
%>