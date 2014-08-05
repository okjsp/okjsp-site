<%@ page contentType="text/html;charset=ms949"
    import="kr.pe.okjsp.util.CommonUtil" %>
<jsp:useBean id="move" class="kr.pe.okjsp.MoveBean"/>
    <jsp:setProperty name="move" property="*" />
<% move.perform(); %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/skin.css" type="text/css">
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ms949">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
</head>
<body class="body">
<table>
    <tr><td align="center">
이동했습니다.<br>

<a href="javascript:location.href='<%=CommonUtil.rplc(
            request.getHeader("referer"),
            "act=VIEW", "act=LIST")%>'">뒤로</a>
    </td></tr>
</table>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>