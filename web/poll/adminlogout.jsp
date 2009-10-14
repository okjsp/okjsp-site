<%@ page import="kr.pe.okjsp.util.*" contentType="text/html;charset=euc-kr" errorPage="error.jsp"%>
<%
String bbs = CommonUtil.nchk(request.getParameter("bbs"));
String pg  = CommonUtil.nchk(request.getParameter("pg"));

session.removeAttribute("adm");

String goURI = "poll_list.jsp?pg="+pg;
session.setAttribute("goURI",goURI);
//response.sendRedirect("go.jsp");
%>
<script>
alert("관리자 로그아웃!");
document.location="go.jsp";
</script>
