<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 찾기</title>
</head>
<body>
<form action="/member?act=reset" method="POST">
등록 email: <input type="email" id="email" name="email" value="kenu@okjsp.pe.kr" />
<br />
<input type="submit" value="리셋 안내 메일 보내기"/>
</form>
<%= application.getRealPath("/") %>
</body>
</html>