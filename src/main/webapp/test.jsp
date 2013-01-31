<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@ page pageEncoding="euc-kr" %>
<%= new java.util.Date().toLocaleString() %>
<br>
Hello
<br>
path: <%= application.getRealPath("/") %>
<br>
<%= 2*3*4*78 %>
<br>
<%= System.getProperty("file.encoding") %>
<br>
<%= request.getHeader("user-agent") %>
<br>
<%= response.getContentType() %>
<br>
<%
int idx = response.getContentType().indexOf('=');
%><%= response.getContentType().substring(idx+1) %>
