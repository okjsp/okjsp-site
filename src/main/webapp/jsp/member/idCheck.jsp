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
// ���� ȣ���
if (p_id==null) {
%>
      <form name="f1" method="post" onSubmit="return check_id(this)">
      	�˻��� id �� �Է��ϼ���.
      	<br>
        <input type="text" name="id" maxlength="12">
        <input type="submit" name="Submit" value="�ߺ��˻�">
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
// ���ο� ���̵��� ���
	if (!new MemberHandler().isIdExist(p_id)) {
%>
      <p>
        <input type="text" name="id" maxlength="12"
        value="<%=p_id%>" style="border:1; text-align:center" readonly>
        <br>
        id �� ����� �� �ֽ��ϴ�.
        <br>
        <input type="button" name="Submit2" value="â�ݱ�"
        onClick="valid_id()">
      </p>
<%
	} else {
// ���̵� ������� ���
%>
      <p>�̹� ������� id �Դϴ�.</p>
        <input type="text" name="id" maxlength="12" value="<%=p_id%>" >
        <input type="submit" name="Submit" value="�ߺ��˻�">
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
