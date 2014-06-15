<%@ page contentType="text/html;charset=MS949"
    import="kr.pe.okjsp.util.CommonUtil"
%>
<jsp:useBean id="move" class="kr.pe.okjsp.MoveBean"/>
    <jsp:setProperty name="move" property="*" />
<% move.perform(); %>
<html>
<head>
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<table width="60%" height="60%">
    <tr><td align="center">
이동했습니다.<br>

<a href="javascript:location.href='<%=CommonUtil.rplc(
            request.getHeader("referer"),
            "act=VIEW", "act=LIST")%>'">뒤로</a>
    </td></tr>
</table>
</center>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>