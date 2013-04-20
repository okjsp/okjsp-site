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
    	
		int daysOfCookieRemain = 60*24*90; // 90days
	    CommonUtil.setCookie(DomainUtil.getBaseDomain(request.getRequestURL()), response, "sid", Long.toString(member.getSid()), daysOfCookieRemain);
	    CommonUtil.setCookie(DomainUtil.getBaseDomain(request.getRequestURL()), response, "okid", member.getId(), daysOfCookieRemain);
}
%></c:catch>



<!-- IUI Header Start --> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Login</title>
  <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
  <meta name="apple-touch-fullscreen" content="YES" />
  <style type="text/css" media="screen">@import "/iui/iui/iui.css";</style>
  <script type="application/x-javascript" src="/iui/iui/iui.js"></script>
</head>
<!-- IUI Header End -->


<body>
    <div class="toolbar">
        <h1 id="pageTitle"></h1>
        <a id="backButton" class="button" href="#"></a>
    </div>
    
    <form id="settings" title="Settings" class="panel" selected="true">
<% if (member.getSid() != 0) { %>
        <h2>Welcome to OKJSP</h2>
        <fieldset style="text-align: center;">
            <div class="row">
                <label><c:out value="${member.id}"/> 님 반갑습니다.</label>
            </div>
        </fieldset>
<% } else { %>
        <h2>로그인에 실패하였습니다.</h2>
        <fieldset>
            <div class="row">
                <label><c:out value="${except.message}"/></label>
            </div>
        </fieldset>
<% } %>
        <a class="whiteButton" href="/iui/index.jsp" target="_self" style="width:160px;">Go to Top Page</a>
    </form>
</body>
</html>