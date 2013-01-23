<html><head><title>check</title></head>
<body>
<xmp><%
	String browser = request.getHeader("user-agent");
	boolean isMobile = browser != null && (
	browser.indexOf("0106CLGC9501") > -1 ||
	browser.indexOf("NATE") > -1 );
	out.println("a:"+browser + "\n" + isMobile);
%>your ip # : <%= request.getRemoteAddr() %>
your agent : <%= browser %>
requested domain : <%= request.getRequestURL() %>
requested protocol : <%= request.getProtocol() %>
</xmp>
</body>
</html>
