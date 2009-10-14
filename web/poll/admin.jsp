<%@ page import="kr.pe.okjsp.util.*" contentType="text/html;charset=euc-kr"%>
<%@ include file="pollcfg.jsp" %>
<%
String pwd = CommonUtil.nchk(request.getParameter("pwd"));
String pg  = CommonUtil.nchk(request.getParameter("pg"));
String polladm = CommonUtil.nchk((String)session.getAttribute("polladm"));

if(polladm.equals("ok")) {
	session.removeAttribute("polladm");
	String goURI = "poll_list.jsp?pg="+pg;
%>
<script>
alert("로그아웃!");
document.location="go.jsp";
</script>
<%
	return;
}
if(pwd.equals("")) {
%>
<jsp:include page="./header.jsp" />
<script language="javascript">
function chk_val(n) {
var lpwd = n.pwd.value.length;
if (lpwd==0) {
	alert("비밀번호를 입력해 주십시오.");
	n.pwd.focus();
	return false;
}
return true;
}
</script>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tb_w">
<tr><td>
<br>
<form name="f1" method="post" onSubmit="return chk_val(this)">
<table width="40%" border="0" align="center" cellpadding="0" cellspacing="0" class="tb_b">
<tr><td>
<table width="100%" border="0" cellpadding="4" cellspacing="1" class="tb_b">
<tr><td  width="40%" align="center" class="td_c">관리자 인증</td>
<td class="td_w">
<input type="password" name="pwd" size="20" class="ipt1">
</td></tr>
</table>
<table width="100%" border="0" cellpadding="4" cellspacing="0" class="tb_w">
<tr><td align="center" class="tb_w">
<br><input type="submit" value="확인" class="ipt2">
<input type="button" value="취소" onClick="history.back()" class="ipt2">
</td></tr>
</table>

</td></tr></table>
</form>
</td></tr></table>
<%
} else if (pwd.equals(admPwd)) {
	session.setAttribute("polladm","ok");
	String goURI = "poll_list.jsp?pg="+pg;
	session.setAttribute("goURI",goURI);
%>
<script>
alert("로그인!");
document.location="go.jsp";
</script>
<% 
} else { 
%>
<script>
alert("함부로 접근하지 마십시오!");
history.back();
</script>
<%}%>
<jsp:include page="./bottom.jsp" flush="true"/>
<jsp:include page="./tail.jsp" flush="true"/>
