<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>title here</title>
<link >
<style type="text/css">
@import url("./okjsp2009.css");
</style>
</head>
<body>
<ul id="top">
	<li id="logo"><a href="/">OKJSP.pe.kr</a></li>
	<li id="find">
	<form name="searchf1" method="get" target="okjspsearch"
		action="http://www.google.com/search"
		onsubmit="searchf1.q.value='site:okjsp.pe.kr '+searchf1.qt.value;">
	<input name="q" value="site:okjsp.pe.kr " type="hidden"> 
	<input name="qt" value="" type="text"> 
	<input value="google" type="submit"></form>
	</li>
</ul>
<div id="menu">menu</div>
<div>main</div>
<div>footer</div>
</body>
</html>