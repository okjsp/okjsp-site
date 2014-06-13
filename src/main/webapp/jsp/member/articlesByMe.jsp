<%@page import="kr.pe.okjsp.util.DomainUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="kr.pe.okjsp.Navigation"%>
<%@page import="kr.pe.okjsp.member.ArticleDao"%>
<%@page import="kr.pe.okjsp.Article"%>
<%@page import="kr.pe.okjsp.member.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>OKJSP member articles</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>
<h1>member article</h1>
<table id="articlesByMe">
<tr><th>#</th>
<th>게시판</th>
<th>제목</th>
<th>일시</th>
<th>연번</th>
<th>닉네임</th>
<th>view</th>
<th>memo</th>
</tr>
<%
ArticleDao dao = new kr.pe.okjsp.member.ArticleDao();
	String sidr  = request.getParameter("sid");
	if (sidr == null) {
		Member member = (Member)session.getAttribute("member");
		if (member == null || member.getEmail() == null) {
			response.sendRedirect(Navigation.getPath("LOGFORM")+"?returnPath="
					+ URLEncoder.encode(DomainUtil.getSecureDomain(request.getRequestURL()) 
							+ "/jsp/member/articlesByMe.jsp","utf-8"));
			return;
		}
		sidr = member.getSid() + "";
	}
	List<Article> list = dao.getArticleListBy(sidr);
	int count = 0;
	for (Article row : list) {
%><tr>
<td><%= ++count %></td>
<td><%= row.getBbs() %></td>
<td class="title"><%= row.getSubject() %></td>
<td><%= row.getWhen("yyyy-MM-dd HH:mm:ss") %></td>
<td class="number"><a href="/seq/<%= row.getSeq() %>" target="_blank"><%= row.getSeq() %></a></td>
<td><%= row.getWriter() %></td>
<td class="number"><%= row.getRead() %></td>
<td class="number"><%= row.getMemo() %></td>
<td class="number"><%= row.getId() %></td>
</tr>
<%
	}
%>
</table>
<%= list.size() %>
<%= sidr %>
</body>
</html>

