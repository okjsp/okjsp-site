<%@ page contentType="text/html;charset=euc-kr"
    import="kr.pe.okjsp.member.MemberHandler"
	errorPage = "/jsp/error.jsp"
%><jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="page" />
	<jsp:setProperty name="member" property="*" />
<body>
<% 
	String contextRoot = application.getRealPath("");
	String msg = new MemberHandler().changeInfo(member, request.getParameter("pact"), contextRoot);
	if ("�����߽��ϴ�.".equals(msg)) {
		session.setAttribute("member", member);
	}
%><%= msg %>
<% 
  if("delete".equals(request.getParameter("pact"))) { 
    kr.pe.okjsp.util.CommonUtil.setCookie(response, "okid", "", 0);
    session.invalidate();
  } else { %><br>
<a href="login.jsp" target="_self">login</a>
<% } %>
<br>
<a href="http://www.okjsp.pe.kr/" target="_top">Home</a>
<jsp:include page="/googleAnalytics.jsp" />
</body>