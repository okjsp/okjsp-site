<%
	String url = request.getRequestURL().toString();
    String path = "/bbs?act=FIRST_MAIN";
	if (url.contains("okjsp.pe.kr")) {
		path = url.replaceAll("okjsp.pe.kr", "okjsp.net") + path;
	}
	response.sendRedirect(path);
%>