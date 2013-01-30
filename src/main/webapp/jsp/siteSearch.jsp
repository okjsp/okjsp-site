<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page errorPage="error.jsp" import="java.util.HashMap" pageEncoding="euc-kr"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="site" class="kr.pe.okjsp.SiteSearch" />
<jsp:setProperty name="site" property="*" />
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=EUC-KR">
    <title>OKJSP Site Search</title>
    <script src="/js/okjsp.js"></script>
    <script src='/js/okboard.js'></script>
    <script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="/top.jsp" />
<table width="882" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width='120' valign='top'>
      <jsp:include page="/menu.jsp" />
    </td>
    <td valign='top' align="center">
<%
	String keyword = CommonUtil.a2k(request.getParameter("keyword"));
%>
<table class="tablestyle" border="0" cellpadding="3" cellspacing="1">
    <tr>
        <td colspan="2" class="td">
            <b><%= keyword %></b> 검색 결과입니다.
        </td>
    </tr>
    <tr>
        <th class="th">게시판</th>
        <th class="th">검색결과</th>
    </tr>
<%
	java.util.LinkedList list = (java.util.LinkedList)site.getResult();
	java.util.Iterator iter = list.iterator();
	HashMap bbsInfoMap = (HashMap)getServletContext().getAttribute("bbsInfoMap");

	while (iter.hasNext()) {
		kr.pe.okjsp.BbsInfoBean one = (kr.pe.okjsp.BbsInfoBean)iter.next();
%><tr align="center">
<td><a href="/bbs?act=LIST&bbs=<%= one.getBbs() %>&keyfield=<%= site.getKeyfield() %>&keyword=<%= keyword %>">
<%= ((kr.pe.okjsp.BbsInfoBean)(bbsInfoMap.get(one.getBbs()))).getName() %></a></td>
<td><%= one.getSearchCount() %></td></tr>
<%
	}

	if (list.size() == 0) {
%><tr><td colspan="2" class="td" align="center">
            검색 결과가 없습니다.
</td></tr>
<%
	}
%></table>
<div class="tablestyle searchDaum" style="text-align:left">
<jsp:include page="/mashup/daumSearch.jsp"></jsp:include>
</div>
</td>
    </tr>
</table>

<jsp:include page="/footer.jsp" />
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>