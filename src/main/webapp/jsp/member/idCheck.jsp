<%@ page contentType="text/html;charset=euc-kr"
%><%
String p_id=request.getParameter("id");
%>
<%@page import="kr.pe.okjsp.member.MemberHandler"%><html>
<head>
<title>id check</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script src="form.js"></script>
<link rel="stylesheet" href="member.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000"
leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="300" border="0" cellspacing="0" cellpadding="0" height="200">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">
<%
// 최초 호출시
if (p_id==null) {
%>
      <form name="f1" method="post" onSubmit="return check_id(this)">
      	검색할 id 를 입력하세요.
      	<br>
        <input type="text" name="id" maxlength="12">
        <input type="submit" name="Submit" value="중복검사">
      </form>
      <script>
      f1.id.value=opener.f1.id.value;
      if(f1.id.value.length>3 && check_id(f1)) {
        f1.submit();
      }
      </script>
<%
} else {
%>
      <form name="f1" method="post">
<%
// 새로운 아이디인 경우
	if (!new MemberHandler().isIdExist(p_id)) {
%>
      <p>
        <input type="text" name="id" maxlength="12"
        value="<%=p_id%>" style="border:1; text-align:center" readonly>
        <br>
        id 를 사용할 수 있습니다.
        <br>
        <input type="button" name="Submit2" value="창닫기"
        onClick="valid_id()">
      </p>
<%
	} else {
// 아이디를 사용중인 경우
%>
      <p>이미 사용중인 id 입니다.</p>
        <input type="text" name="id" maxlength="12" value="<%=p_id%>" >
        <input type="submit" name="Submit" value="중복검사">
<%
	} // end if (isIdExist())
%>
      </form>
<%
} // end if (id=null)
%>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
