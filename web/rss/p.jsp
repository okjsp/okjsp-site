<%@page import="java.util.Random"%><%@page 
import="kr.pe.okjsp.util.StringHelper"%><%@page 
import="kr.pe.okjsp.rss.RSSProxy"
contentType="text/plain;charset=utf-8"
%><%
	String qs = request.getQueryString();
	String refresh = new Random(System.nanoTime()).nextInt(10) + "";
	String feed = RSSProxy.getCachedXML(qs, refresh);
%><%= feed %>