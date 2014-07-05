<%@page pageEncoding="utf-8"%>
<%@page import="kr.pe.okjsp.util.DomainUtil"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.Navigation"%>
<!DOCTYPE html>
<html><head>
<script src="form.js"></script>
<link rel="stylesheet" href="/css/skin.css" type="text/css">
<link rel="stylesheet" href="/css/login.css" type="text/css">
<script type="text/javascript" src="/js/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/okjsp.js"></script>
<script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	$("input[name='id']").focus();
});
</script>
</head>
<body>
<jsp:include page="/top.jsp" />
<div style="float:left">
<jsp:include page="/menu.jsp" />
</div>

<div style="width:644px;float:left;margin-left:8px;">
      <form name="f1" method="post" action="<%= DomainUtil.getSecureDomain(request.getRequestURL()) %>/jsp/member/login2.jsp" 
      	class="form_write" onSubmit="return check_login(this)">
      <input type="hidden" name="returnPath" value="<%= CommonUtil.nchk(request.getParameter("returnPath"), "/") %>">
<table>
<tbody>
<tr>
	<td>id</td>
	<td><input type="text" maxlength="15" name="id"/></td>
</tr>
<tr>
	<td>password</td>
	<td><input type="password" maxlength="31" name="password"/></td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="로그인" id="login" name="login"/>
		<br>
		<a href='/jsp/member/agreement.jsp' title="Join in">회원가입</a>
		<br>
		<a href='/member?act=forgot' title="Join in">비밀번호를 잊었어요</a>
	</td>
</tr>
</tbody>
</table>
      </form>

</div>

<jsp:include page="/footer.jsp" />
<jsp:include page="/googleAnalytics.jsp" />

</body>
</html>