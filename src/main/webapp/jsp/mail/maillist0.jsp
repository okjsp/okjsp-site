<%response.setContentType("text/html;");%>
<html>
<head>
<title>���ϸ�����Ʈ ��ü���Ϻ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="javascript">
function preview(n) {
var nw = window.open('about:blank','prevw','width=600,height=400,resizable=yes,scrollbars=yes');
nw.document.writeln(form1.mailsubj.value);
nw.document.writeln('<hr noshade size=1>');
nw.document.writeln(form1.mailbody.value);
nw.document.writeln('<hr noshade size=1><div align=right><a href="#" onClick="self.close()">â�ݱ�</a></divss>');
nw.focus();
}


function lastcheck(n) {
if (n.mailbody.value.length<1) {
alert("������ �ʹ� ª���ϴ�.");
return false;
}
return confirm("��ü ������ �����ðڽ��ϱ�?");
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<p>���ϸ�����Ʈ ��ü���Ϻ�����</p>
<form name="form1" method="post" action="maillist1.jsp" onSubmit="return lastcheck(this)">
<p>
����:<input type="text" name="mailsubj" size="66" ><br>
<textarea name="mailbody" cols="70" rows="16" wrap="VIRTUAL"></textarea>
<br>
���Ͽ� ���ԵǴ� �̹����� �������� ��ü ��θ� �����־�� �մϴ�.<br>
��:) http://www.okjsp.pe.kr/images/okjsp_01.gif</p>
<p align="center">
<input type="button" name="Button" value="�̸�����" onClick="preview(this)">
<input type="submit" name="Submit" value="��ü���Ϻ�����">
</p>
</form>
<p>&nbsp; </p>
</body>
</html>
