<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.ad.AdLog"%>
<%@page import="kr.pe.okjsp.ad.AdLogDao"%>
<%@page pageEncoding="utf-8" %><%
	String url = request.getQueryString();
	AdLogDao dao = new AdLogDao();
	AdLog log = new AdLog();
	log.setUrl(url);
	log.setReferer(request.getHeader("referer"));
	log.setSid(CommonUtil.getCookieLong(request, "sid"));
	log.setIp(request.getRemoteAddr());
	int result = dao.log(log);
	response.sendRedirect(url);
%>