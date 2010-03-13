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
<!-- ############ IUI Header Start ########### -->
<style type="text/css">
body > ul > li {
    font-size: 14px;
}
body > ul > li > a {
    padding-left: 54px;
    padding-right: 40px;
    min-height: 34px;
}
li .digg-count {
    display: block;
    position: absolute;
    margin: 0;
    left: 6px;
    top: 7px;
    text-align: center;
    font-size: 110%;
    letter-spacing: -0.07em;
    color: #93883F;
    font-weight: bold;
    text-decoration: none;
    width: 36px;
    height: 30px;
    padding: 7px 0 0 0;
    background: url(../../m/iui/shade-compact.gif) no-repeat;
}
h2 {
    margin: 10px;
    color: slateblue;
}
p {
    margin: 10px;
}
</style>
<!-- ############ IUI Header End ########### -->
<%
while (iter.hasNext()) {
    one = (Article) iter.next();
%>
        <li><!-- ############ IUI List ########### -->
            <a class="digg-count"><%= one.getRef() %></a>
            <a href="/bbs?seq=<%= one.getSeq() %>&mobileView=Y"><%= one.getSubject() %></a>
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