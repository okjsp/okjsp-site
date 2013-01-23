<%@page import="kr.pe.okjsp.util.StringHelper"%><%@page import="kr.pe.okjsp.rss.RSSProxy"
contentType="text/xml;charset=utf-8"
%><%
	String url = request.getParameter("feed");
	String charset = request.getParameter("c");
	String refresh = request.getParameter("r");
	String feedData = RSSProxy.getCachedXML(url, charset, refresh);
	if (charset == "euc-kr"){
		feedData = feedData.replaceFirst("EUC-KR","utf-8");
	}
	out.println(feedData);
%>