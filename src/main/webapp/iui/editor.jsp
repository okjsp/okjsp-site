<%@page import="kr.pe.okjsp.util.CommonUtil"%><%
	response.sendRedirect("http://www.okjsp.pe.kr/iui/editor_jquery.jsp?bbs="+
			CommonUtil.nchk(request.getParameter("bbs"),"bbs6"));
%>