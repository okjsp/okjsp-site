<%@page import="kr.pe.okjsp.util.CommonUtil"
	contentType="text/css"
%><%
	String skinType = CommonUtil.getCookie(request,"skin");
	if ("".equals(skinType)) skinType = "white";
%>
@import url("/css/okjsp2007_<%= skinType %>.css");
