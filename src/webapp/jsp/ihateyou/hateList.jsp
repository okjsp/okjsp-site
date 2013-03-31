<%--
**************************************************
* 화면 코드 : 
*
* 기능 설명 : 
*
* Revision History
* Author            Date              Description
* ---------------   --------------    ------------------
* jangmj			2013. 3. 28.			First Draft.
*
*************************************************
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="kr.pe.okjsp.member.Member"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.pe.okjsp.util.DbCon"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(((Member)request.getSession().getAttribute("member")) == null){
		out.println("로그인된 사용자만 사용하실 수 있습니다.");
		
		return;
	}

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
게시물에서 보고싶지않은 사람의 id(프로필이미지명 앞쪽숫자) 혹은 닉네임을 ";" 으로 연결하여 입력하세요 <br>
예) 1234;바보;멍청이;10284
<form name='mainform' method='post'> 
<textarea name='hateString' cols='80' rows='20' >${result }</textarea><br>
<input type='submit'>
</form>
</body>
</html>