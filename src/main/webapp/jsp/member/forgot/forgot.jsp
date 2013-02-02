<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 찾기</title>
</head>
<body>
<h1>비밀번호 변경하기</h1>
<div>비밀번호가 기억이 나지 않습니까? 회원가입에 사용한 이메일로 비밀번호를 변경할 수 있는 링크를 보내드립니다. 
메일이 가지 않는 경우, 스팸함을 확인해주세요.</div>
<%
	String msg = (String)session.getAttribute("msg");
	if(msg != null) {
%><div style="color: red"><%= msg %></div><%
		session.removeAttribute("msg");
	}
%>
<form action="/member?act=reset" method="POST">
등록 email: <input type="email" id="email" name="email" value="" />
<br />
<input type="submit" value="리셋 안내 메일 보내기"/>
</form>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>