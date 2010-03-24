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


<!-- ############ Header Title ########### -->
<!-- 화면 겹침 방지 위해 id="stats2" 추가  -->
<ul id="stats2"  title="<c:out value="${bbsInfoMap[list.bbs].header}" escapeXml="false" />">
	<!-- ############ 글쓰기_로그인 상태일때만 나타남 ########### -->
	<% if (member.getSid() != 0) { %>
	<a href="editor_jquery.jsp?bbs=<%= request.getParameter("bbs") %>">글쓰기</a>
	<% } %>
	<!-- ############ List & Next Page ########### -->
	<jsp:include page="listDetail.jsp"></jsp:include>
</ul>

