<%@page import="kr.pe.okjsp.Navigation"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 변경하기</title>
</head>
<body>
<%
	String msg = (String)session.getAttribute("msg");
	session.removeAttribute("msg");
%>
<%= msg %>
<div><a href="/">메인으로 돌아가기</a></div>
<div><a href="<%= Navigation.getPath("LOGFORM") %>">로그인 하기</a></div>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>