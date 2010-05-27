<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>트위터 시연</title>
</head>
<body>
<h1>트위터 시연</h1><p>
<a href="twitter.jsp">트위터 글쓰기  oauth</a></p>

<form name="tw" action="twitterUpdateByid.jsp">
<input type='text' name="tweetStsText" value=""><br>
<input type="submit" value="트위터 글쓰기  by id,password">
</form>
</body>
</html>