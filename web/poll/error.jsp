<%@ page isErrorPage="true" contentType="text/html; charset=euc-kr"%>
<center>
<font style="font-size:10pt; font-family:돋움;">
<%if (exception instanceof java.lang.ClassNotFoundException) {%>
JDBC 드라이버를 읽을 수 없습니다.<br><br>
: <%=System.getProperty("java.class.path")%><br><br>
<%} else if (exception instanceof java.sql.SQLException) {%>
데이터베이스 처리에 문제가 있습니다. <br><br>
다음과 같은 에러가 발생하였습니다.<br><br>
: <%= exception.toString() %><br><br>
<%} else {%>
프로그램 처리에 문제가 있습니다. <br><br>
다음과 같은 에러가 발생하였습니다. <br><br>
: <%= exception.toString() %><br><br>
<%}%>
관리자에게 문의하십시오.<br><br>
<a href="#" onClick="javascript:history.back(-1);">이전페이지</a>
</font>
</center>
