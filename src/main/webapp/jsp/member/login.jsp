<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="kr.pe.okjsp.util.DomainUtil"%>
<%@page pageEncoding="euc-kr"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.Navigation"%><html><head>
<script src="form.js"></script>
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
<style type="text/css">
.form_write {
	margin:100px auto;
	width:210px;
	padding: 8px;	
}
.form_write table {
	height: 100px;
	width: 210px;
	text-align:center;
}
.form_write td,
.form_write input {
	font-family: Verdana;
	font-size: medium;
	border: 0;
}
.form_write input {
	border-bottom: 1px dotted #00A;
	width: 130px;
}

.form_write #login {
	margin: 10px;
	width: 80px;
}
.form_write, #login {
	border: 1px solid #AAA;
	border-right: 2px solid #88A;
	border-bottom: 2px solid #88A;
}
</style>
<script type="text/javascript" src="/js/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/okjsp.js"></script>
<script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
</head>
<body onLoad="document.f1.id.focus()">
<jsp:include page="/top.jsp" />
<div style="float:left">
<jsp:include page="/menu.jsp" />
</div>

<div style="width:644px;float:left;margin-left:8px;">
      <form name="f1" method="post" action="<%= DomainUtil.getSecureDomain(request.getRequestURL()) %>/jsp/member/login2.jsp" 
      	class="form_write" onSubmit="return check_login(this)">
      <input type="hidden" name="returnPath" value="<%= CommonUtil.nchk(request.getParameter("returnPath"), "/") %>">
<table>
<tbody><tr>
<td>id</td>
<td><input type="text" maxlength="15" name="id"/></td>
</tr>
<tr>
<td>password</td>
<td><input type="password" maxlength="12" name="password"/></td>
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
</tbody></table>
      </form>

</div>

<jsp:include page="/footer.jsp" />
<jsp:include page="/googleAnalytics.jsp" />

</body>
</html>