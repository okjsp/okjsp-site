<%--
  - �ۼ���: kenu
  - ����: 2003-04-06
  - ���۱� ǥ��: CopyLeft
  - @(#)
  - ����: ȸ������ ������ ȸ��Ż��
  --%>
<%-- ������ ȸ������ Ȯ�� 
     ������ ���� ��� �α����������� �̵� --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@page import="kr.pe.okjsp.member.Member"%>
<%@page import="java.net.URLEncoder"%>
<%
	Member member = (Member)session.getAttribute("member");
	if (member == null || member.getEmail() == null) {
		response.sendRedirect(Navigation.getPath("LOGFORM")+"?returnPath="
				+URLEncoder.encode(Navigation.getPath("SECURE_DOMAIN")+"/jsp/member/info.jsp","utf-8"));
		return;
	}
%>

<%@page import="kr.pe.okjsp.Navigation"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%><html>
<head>
<title>okjsp ȸ�� ��������</title>
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
<h1>okjsp.pe.kr ��������</h1>
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
            <th>��й�ȣ</th>
            <td> <input type="password" name="password" maxlength="12" > 
            </td>
        </tr>
        <tr> 
            <th>��й�ȣ Ȯ��</th>
            <td> <input type="password" name="password2" maxlength="12" > 
            </td>
        </tr>
        <tr> 
            <th>�̸�</th>
            <td> <input type="text" name="name"  value="<%= CommonUtil.a2k(member.getName()) %>">
            </td>
        </tr>
        <tr> 
            <th>homepage</th>
            <td> <input type="text" name="homepage" maxlength="50" style="width:240"
         value="<c:out value='${member.homepage}'/>"> </td>
        </tr>
    <tr>
      <th>���ϼ���</th>
      <td>
      	okjsp���� ������������ �����ϴ� �������Ϳ� ȫ������ ���� �����Դϴ�.
      	<br>
        <input type="radio" name="mailing" id="y" value="Y">
        <label for="y">���</label> 
        <input type="radio" name="mailing" id="n" value="N">
        <label for="n">�ź�</label>
      </td>
    </tr>
        <tr> 
            <th>������</th>
            <td><c:out value='${member.joindate}'/></td>
        </tr>
    </table>
  <table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>
        <input type="submit" name="Submit" value="����" >
      </td>
    </tr>
	<tr>
		<td>
			<a href="/jsp/member/profileForm.jsp">������ �̹��� ����
			<img alt="<%= member.getSid() %>" src="/profile/<%= member.getSid() %>.jpg">
			</a>
		</td>
	</tr>
	<tr>
		<td>
		<p>ȸ��Ż��� ��й�ȣ�� ������ ��й�ȣ�� �Է��ϼ���.</p>
		<input type="button" onClick="resign()" value="ȸ��Ż��">
		</td>
	</tr>
</table>
</form>
</div>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>
