<%@page import="kr.pe.okjsp.util.DomainUtil"%>
<%@ page pageEncoding="euc-kr" %><%
    String domain = DomainUtil.getBaseDomain(request.getRequestURL());
    kr.pe.okjsp.util.CommonUtil.setCookie(domain, response, "okid", "", 0);
    kr.pe.okjsp.util.CommonUtil.setCookie(domain, response, "sid", "", 0);
    kr.pe.okjsp.util.CommonUtil.setCookie(domain, response, "okwriter", "", 0);
    session.invalidate();
	response.setContentType("text/html;");
%>
<HTML>
<HEAD>
    <META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=euc-kr">
    <TITLE>LogOut</TITLE>
    <link rel="stylesheet" type="text/css" href="/css/okjsp2007.css.jsp" media="all" />
    <script type="text/javascript" src="/js/okjsp.js"></script>
	<script>
	setTimeout("top.location.replace('/')", 1000);
	deleteCookie("okid");
	deleteCookie("sid");
	deleteCookie("okwriter");
	</script>
</HEAD>
<BODY class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center">이용해 주셔서 감사합니다.</td>
    </tr>
</table>
</BODY>