<%@ page contentType="text/html;charset=MS949" import="kr.pe.okjsp.util.CommonUtil" %>
<html>
<body>
<center>
<table width="60%" height="60%">
    <tr><td align="center">
삭제되었습니다.<br>
<a href="javascript:location.href='/bbs?act=LIST&bbs=<%= request.getParameter("bbs") %>'">목록으로</a>
    </td></tr>
</table>
</center>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>