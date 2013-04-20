<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.util.DomainUtil"%>
<%@ page contentType="text/html;charset=euc-kr"
    import="kr.pe.okjsp.member.MemberHandler"
	errorPage = "/jsp/error.jsp"
%><jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="page" />
	<jsp:setProperty name="member" property="*" />
<body>
<% 
	String contextRoot = application.getRealPath("");
	String msg = new MemberHandler().changeInfo(member, request.getParameter("pact"), contextRoot);
	if ("수정했습니다.".equals(msg)) {
		session.setAttribute("member", member);
	}
%><%= msg %>
<% 
  if("delete".equals(request.getParameter("pact"))) { 
    CommonUtil.setCookie(DomainUtil.getBaseDomain(request.getRequestURL()), response, "okid", "", 0);
    session.invalidate();
  } else { %><br>
<a href="login.jsp" target="_self">login</a>
<% } %>
<br>
<a href="http://www.okjsp.pe.kr/" target="_top">Home</a>
<jsp:include page="/googleAnalytics.jsp" />
</body>