<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page pageEncoding="euc-kr" %>
<%@page import="kr.pe.okjsp.member.MemberHandler"%>
<html lang="ko">
<head>
<title>OKJSP ���� ���� �ź�</title>
</head>
<body>
<% String email = request.getParameter("email"); %>
<%= new MemberHandler().reject(email) %>
</body>
</html>