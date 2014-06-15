<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	//request.setCharacterEncoding("euc-kr");

	long sid = CommonUtil.getCookieLong(request, "sid");
	String id = CommonUtil.getCookie(request, "okid");
	
	String writer = CommonUtil.getCookie(request, "okid");
	String bbs = request.getParameter("bbs");
	String homepage = request.getParameter("homepage");
	String password = request.getParameter("password");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String html = request.getParameter("html");
	String ccl_id = request.getParameter("ccl_id");
	
	if(sid == 0) {
		response.sendRedirect(Navigation.getPath("LOGFORM")+"?returnPath=/site2009/editorProcess.jsp?bbs="+bbs);
		return; 
	}

	ArticleDao articleDao = new ArticleDao();
	Article article = new Article();
	Connection conn = new DbCon().getConnection();
	int seq = articleDao.getSeq(conn);
	int ref = articleDao.getNewRef(conn, bbs);
	article.setSeq(seq);
	article.setRef(ref);
	article.setBbs(bbs);
	article.setPassword(password);
	article.setHomepage(homepage);
	article.setSubject(subject);
	article.setId(id);
	article.setSid(sid);
	article.setWriter(writer);
	article.setContent(content);
	article.setHtml(html);
	article.setCcl_id(ccl_id);
	article.setIp(request.getRemoteAddr());
	int result = articleDao.write(conn , article);
	conn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="kr.pe.okjsp.ArticleDao"%>
<%@page import="kr.pe.okjsp.Article"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.pe.okjsp.util.DbCon"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.Navigation"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<ul>
<li>
<%= bbs %>
<%= CommonUtil.a2k(subject) %>
</li>
<li>
<%= CommonUtil.a2k(content) %>
</li>
</ul>
</body>
</html>