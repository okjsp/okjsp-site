<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>초기화 메일 발송</title>
</head>
<body>
<%= request.getParameter("email") %>
초기화 안내 메일을 발송했습니다.
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>