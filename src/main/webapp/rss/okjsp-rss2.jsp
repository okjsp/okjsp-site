<%@ page contentType="text/xml"
import="java.util.*,
java.text.*,
kr.pe.okjsp.Article,
kr.pe.okjsp.BbsInfoBean"
pageEncoding="euc-kr"
%><%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %><%
String bbs = request.getParameter("bbs");
if (bbs == null) {
  bbs = "bbs4";
}
HashMap bbsInfoMap = (HashMap)getServletContext().getAttribute("bbsInfoMap");
SimpleDateFormat sdf = new SimpleDateFormat("E, d MMM yyyy HH:mm:ss Z", Locale.US);

%><?xml version="1.0" encoding="euc-kr"?>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler" scope="request"/>
<rss version="2.0">
	<channel>
		<title>OKJSP: <c:out value="${bbsInfoMap[param.bbs].name}" /></title>
		<link>http://www.okjsp.net</link>
		<description>OKJSP is about developing web application, developer life stories. We exchange anything helpful infomation for us.</description>
		<language>ko-kr</language>
		<copyright>Copyright 2000-2009 okjsp.net</copyright>
		<lastBuildDate><%= sdf.format(new Date()) %></lastBuildDate>
		<pubDate><%= sdf.format(new Date()) %></pubDate>
		<docs>http://www.okjsp.net/rss</docs>
		<generator>OKJSP Feed Generator 0.2</generator>
		<managingEditor>kenu@okjsp.net</managingEditor>
		<webMaster>kenu@okjsp.net</webMaster>
		<ttl>60</ttl>
    		<image>
    			<url>http://www.okjsp.net/images/okjsp_top.gif</url>
			<title>okjsp.net</title>
			<link>http://www.okjsp.net</link>
    		</image>

<%
Iterator iterList = list.getRecentList(bbs, 10).iterator();
Article one = null;

while (iterList.hasNext()) {
    one = (Article) iterList.next();
    BbsInfoBean info = (BbsInfoBean)bbsInfoMap.get(one.getBbs());
    if (info == null) info = new BbsInfoBean();
%>		<item>
			<title><![CDATA[<%= one.getSubject() %>]]></title>
			<link><![CDATA[http://www.okjsp.net/seq/<%= one.getSeq() %>]]></link>
			<description><![CDATA[<%= one.getContent() %>
			]]></description>
			<author><![CDATA[<%= one.getWriter() %>]]></author>
			<category><![CDATA[<%= info.getName() %>]]></category>
			<pubDate><%= sdf.format(one.getWhen()) %></pubDate>
			<guid><![CDATA[http://www.okjsp.net/seq/<%= one.getSeq() %>]]></guid>
		</item>
<%
} // end while
%>
    </channel>
</rss>

