<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=euc-kr"
    import="kr.pe.okjsp.member.MemberHandler,
            kr.pe.okjsp.util.CommonUtil"
%>
<%@page import="kr.pe.okjsp.util.DomainUtil"%><jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:setProperty name="member" property="*"/>
<c:catch var="except"><%
    MemberHandler mh = new MemberHandler();
    if (mh.doLogin(member) == 1) {
    	String returnPath = DomainUtil.getFixedURL(request.getParameter("returnPath"));
    	if ("/".equals(returnPath)) {
    		returnPath = "http://www.okjsp.pe.kr/";
    	}
%>
<c:out value="${member.id}"/> �� �ݰ����ϴ�.<br>
<a href="<%= returnPath %>" target="_top"><%= returnPath %></a>
<%
	int daysOfCookieRemain = 60*24*90; // 90days
    CommonUtil.setCookie(response, "sid", Long.toString(member.getSid()), daysOfCookieRemain);
    CommonUtil.setCookie(response, "okid", member.getId(), daysOfCookieRemain);
}
%></c:catch>
<c:out value="${except.message}"/>
<a onclick="history.go(-2)" style="cursor:hand">�ڷ�</a>
