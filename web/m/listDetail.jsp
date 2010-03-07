<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page pageEncoding="euc-kr"
    import="kr.pe.okjsp.util.CommonUtil, java.util.Iterator,
            kr.pe.okjsp.Article,kr.pe.okjsp.util.DateLabel" %>
<%@page import="java.util.Arrays"%>
<% long stime = System.currentTimeMillis(); %>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />
<%
	Iterator iter = list.getList().iterator();
	Article one = null;
%>

<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">

<%
while (iter.hasNext()) {
    one = (Article) iter.next();
%>
        <li><!-- ############ IUI List ########### -->
            <a class="digg-count"><%= one.getRef() %></a>
            <a href="/seq/<%= one.getSeq() %>"><%= one.getSubject() %></a>
        </li>
<%
} // end ifwhile 
int total = list.getCnt();
int pageSize = list.getPageSize();
int pageTotal = (total-1) / pageSize;
boolean hasMorePage = list.getPg() < pageTotal;

if (hasMorePage) {	// Next Page 가 없으면 Page 버튼 숨긴다.
%>
<li><a href="/bbs?act=MLISTDETAIL&bbs=<%=request.getParameter("bbs")%>&pg=<%= list.getPg() + 1 %>" target="_replace">Get Next Page Stories...</a></li>
<% 
} // end if
%>