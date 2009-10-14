<%
    kr.pe.okjsp.util.CommonUtil.setCookie(response, "okid", "", 0);
    session.invalidate();
	response.setContentType("text/html;");
%>
<HTML>
<HEAD>
    <META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
    <TITLE>LogOut</TITLE>
    <link rel=stylesheet href=/css/okjsp2007.css.jsp type=text/css>
</HEAD>
<BODY class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center">이용해 주셔서 감사합니다.</td>
    </tr>
<script>
setTimeout("top.location.replace('/')", 1000);
</script>
</table>
</BODY>