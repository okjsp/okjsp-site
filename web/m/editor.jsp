<%@page import="kr.pe.okjsp.util.CommonUtil"%><%
	//나중에 경로 변경~!!!!!!!!!!!!!!!!!!!!!
	response.sendRedirect("http://localhost:8889/m/editor_jquery.jsp?bbs="+
			CommonUtil.nchk(request.getParameter("bbs"),"bbs6"));
%>