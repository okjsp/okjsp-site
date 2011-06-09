<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="kr.pe.okjsp.member.Member"%>
<%
	Member member = (Member) session.getAttribute("member");
	boolean isNotLogged = ((member == null) || ("".equals(member.getId())));
	if (isNotLogged) {
		response.sendRedirect("/jsp/member/login.jsp");
		return;
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>프로필 사진</title>
</head>
<body>
<% 
	if ("Y".equals(member.getProfile())) {
%><img src="/profile/<%= member.getSid() %>.jpg" alt="<%= member.getSid() %>"><%
	}
%>
<form enctype="multipart/form-data" method="post" action="/profile/write">
<input type="file" name="profile" />
<input type="submit" value="올리기" />
</form>
<a href="/jsp/member/info.jsp">회원정보 수정 페이지로</a>
</body>
</html>