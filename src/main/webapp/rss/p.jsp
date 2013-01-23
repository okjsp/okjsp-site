<%@page import="kr.pe.okjsp.util.StringHelper"%><%@page import="kr.pe.okjsp.rss.RSSProxy"
contentType="text/plain;charset=utf-8"
%><%
	String qs = request.getQueryString();
	String feed = RSSProxy.getCachedXML(qs, "1");
%><%= feed %>