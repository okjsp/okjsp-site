<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>초기화 메일 발송</title>
</head>
<body>
<%
String email = request.getParameter("p");
%>
<form action="/member?act=resetPassword" method="POST">
email: <input type="email" id="email" name="email" value="<%= email %>" readonly="readonly">
<br />
새 비밀번호: <input type="password" id="password" name="password" required="required">
<br />
비밀번호 확인: <input type="password" id="confirmPassword" name="confirmPassword" required="required">
<br />
<input type="submit" value="비밀번호 변경하기">
</form>
</body>
</html>