<%
	String url = request.getRequestURL().toString();
    String path = "/bbs?act=FIRST_MAIN";

	response.sendRedirect(path);
%>
