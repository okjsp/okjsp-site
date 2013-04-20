<%--
  - 작성자: kenu
  - 일자: 2003-04-06
  - 저작권 표시: CopyLeft
  - @(#)
  - 설명: 회원정보 수정과 회원탈퇴
  --%>
<%-- 세션의 회원정보 확인 
     세션이 없을 경우 로그인페이지로 이동 --%>
<%@page import="kr.pe.okjsp.util.DomainUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@page import="kr.pe.okjsp.member.Member"%>
<%@page import="java.net.URLEncoder"%>
<%
	Member member = (Member)session.getAttribute("member");
	if (member == null || member.getEmail() == null) {
		response.sendRedirect(Navigation.getPath("LOGFORM")+"?returnPath="
				+ URLEncoder.encode(DomainUtil.getSecureDomain(request.getRequestURL()) 
						+ "/jsp/member/info.jsp","utf-8"));
		return;
	}
%>

<%@page import="kr.pe.okjsp.Navigation"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%><html>
<head>
<title>okjsp 회원 정보수정</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script src="form.js"></script>
<link rel="stylesheet" href="member.css" type="text/css">
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
<link rel="stylesheet" href="/event/200908/nas.css" type="text/css">
<script type="text/javascript" src="/js/jquery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="/js/okjsp.js"></script>

<script src="form.js"></script>

<script type="text/javascript">
$(function(){
	$('input[value="<%= member.getMailing() %>"]').click();
});
</script>
<link rel="stylesheet" href="member.css" type="text/css">
</head>

<body>
<jsp:include page="/top.jsp" />
<div style="float:left">
<jsp:include page="/menu.jsp" />
</div>

<div style="width:644px;float:left;margin-left:8px;">
<h1>okjsp.pe.kr 정보수정</h1>
<form class="register" name="f1" id="f1" method="post" action="register.jsp"
 onSubmit="return check_value(this)">
  <input type="hidden" name="pact" value="modify">
    <table class="td">
        <tr> 
            <th>Email</th>
            <td> <input type="text" name="email" maxlength="40" style="width:240"
		value="<c:out value='${member.email}'/>" > </td>
        </tr>
        <tr> 
            <th>ID</th>
            <td width="280"> <input type="text" name="id" maxlength="12"  readonly="readonly"
		 value="<c:out value='${member.id}'/>"> </td>
        </tr>
        <tr> 
            <th>비밀번호</th>
            <td> <input type="password" name="password" maxlength="12" > 
            </td>
        </tr>
        <tr> 
            <th>비밀번호 확인</th>
            <td> <input type="password" name="password2" maxlength="12" > 
            </td>
        </tr>
        <tr> 
            <th>이름</th>
            <td> <input type="text" name="name"  value="<%= CommonUtil.a2k(member.getName()) %>">
            </td>
        </tr>
        <tr> 
            <th>homepage</th>
            <td> <input type="text" name="homepage" maxlength="50" style="width:240"
         value="<c:out value='${member.homepage}'/>"> </td>
        </tr>
    <tr>
      <th>메일수신</th>
      <td>
      	okjsp에서 비정기적으로 발행하는 뉴스레터와 홍보메일 수신 설정입니다.
      	<br>
        <input type="radio" name="mailing" id="y" value="Y">
        <label for="y">허용</label> 
        <input type="radio" name="mailing" id="n" value="N">
        <label for="n">거부</label>
      </td>
    </tr>
        <tr> 
            <th>가입일</th>
            <td><c:out value='${member.joindate}'/></td>
        </tr>
    </table>
  <table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>
        <input type="submit" name="Submit" value="수정" >
      </td>
    </tr>
	<tr>
		<td>
			<a href="/jsp/member/profileForm.jsp">프로필 이미지 수정
			<img alt="<%= member.getSid() %>" src="/profile/<%= member.getSid() %>.jpg">
			</a>
		</td>
	</tr>
	<tr>
		<td>
		<p>회원탈퇴시 비밀번호는 기존의 비밀번호를 입력하세요.</p>
		<input type="button" onClick="resign()" value="회원탈퇴">
		</td>
	</tr>
</table>
</form>
</div>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>
