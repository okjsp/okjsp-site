<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ page pageEncoding="euc-kr"
	errorPage="error.jsp"
	import="java.util.*,kr.pe.okjsp.*,
	kr.pe.okjsp.util.CommonUtil,
	kr.pe.okjsp.util.DateLabel" %>
<jsp:useBean id="m" class="kr.pe.okjsp.MemoHandler"/>
    <jsp:setProperty name="m" property="field" />
    <jsp:setProperty name="m" property="keyword" />
    <jsp:setProperty name="m" property="keyfield" />
<html>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=euc-kr">
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a href="/">OKJSP</a>
<hr>
<h3>최근 메모</h3>
<form name="f1" style="margin:0">
<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
<%
	String keyword = CommonUtil.a2k(m.getKeyword());
    int cpage = 0;
    try{
        cpage = Integer.parseInt(request.getParameter("pg"));
    } catch(Exception e) {}
    int total = m.getCount();
    MemoBean mb = null;
    Iterator iter = m.getRecent(cpage).iterator();
%>
    <tr>
        <td class="td" colspan="2" align="right">
            <%=total %></td>
    </tr>
<%
    while (iter.hasNext()) {
        mb = (MemoBean)iter.next();
    %>
    <tr align="center">
        <td class="td">
<hr>
<%
    if (mb.getId() != null) {
        %><img src="/profile/<%= mb.getId() %>.jpg"
        	alt="<%= mb.getId() %>"
        	style="width:77px;height:77px"
        	onerror="this.src='/images/spacer.gif'"><%
    }
%>
<div class="wrap">
            <a href="/seq/<%= mb.getSeq() %>">
            <okbbs:mark word='<%= keyword %>'>
        <okbbs:html br="true"><%= CommonUtil.cropByte( mb.getBcomment(), 200, ".." ) %></okbbs:html>&nbsp;
            </okbbs:mark>
            </a></div>
            <b><%= mb.getWriter() %></b>
            <sup><%= CommonUtil.nchk(mb.getIp()) %></sup>
            <%= DateLabel.getTimeDiffLabel(mb.getWtime()) %>
        </td>
    </tr>
<% } %>
    <tr>
    <td class="td" align="center">
<%
    request.setAttribute("total", ""+total );
    request.setAttribute("pageSize", ""+m.pageSize);
%>
<okbbs:page link='<%= "/bbs?act=MEMORECENT"+"&field="+m.getField()
			+"&keyword="+keyword %>'
            beginlabel="처음 "
            endlabel=" 끝"
            prevlabel="◀이전 "
            nextlabel=" 다음▶"
            pagegroupsize="10" />
    </td>
    </tr>
    <tr>
    <td class="td" align="center">
        메모 검색
        <input type="hidden" name="act" value="MEMORECENT">
        <select name="field"><option value="c">내용</option><option value="w">작성자</option></select>
        <input type="text" name="keyword" value="<%= keyword %>">
        <input type="submit" value="찾기">
        <% if (!"".equals(keyword)) { %>
            <a href="javascript:f1.keyword.value='';f1.submit();">검색해제</a>
        <% } %>
    </td>
    </tr>
</table>
</form>
<script>document.f1.field.value="<%= m.getField() %>"</script>

</body>
</html>
