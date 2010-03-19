<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page pageEncoding="euc-kr"
    import="kr.pe.okjsp.util.CommonUtil, java.util.Iterator,
            kr.pe.okjsp.Article,kr.pe.okjsp.util.DateLabel" %>
<%@page import="java.util.Arrays"%>
<% long stime = System.currentTimeMillis(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:setProperty name="list" property="*" />
<%
    response.setContentType("text/html");

	Iterator iter = list.getList().iterator();
	Article one = null;
%>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
<!-- ############ IUI Header Start ########### -->
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<link rel="apple-touch-icon" href="/m/iui/iui-logo-touch-icon.png" />
<meta name="apple-touch-fullscreen" content="YES" />
<style type="text/css" media="screen">@import "/m/iui/iui.css";</style>
<script type="application/x-javascript" src="/m/iui/iui.js"></script>
<!-- ############ IUI Header End ########### -->

</head>
<body>
	<!-- ############ Header Title ########### -->
    <ul title="<c:out value="${bbsInfoMap[list.bbs].header}" escapeXml="false" />" selected="true">
    	<!-- ############ 글쓰기_로그인 상태일때만 나타남 ########### -->
    	<% if (member.getSid() != 0) { %>
			<a href="editor_jquery.jsp?bbs=<%= request.getParameter("bbs") %>">글쓰기</a>
		<% } %>
    	<!-- ############ List & Next Page ########### -->
		<jsp:include page="/m/listDetail.jsp"></jsp:include>
    </ul>
</body>
</html>
