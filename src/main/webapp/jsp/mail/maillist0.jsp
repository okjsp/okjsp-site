<%response.setContentType("text/html;");%>
<html>
<head>
<title>메일링리스트 전체메일보내기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="javascript">
function preview(n) {
var nw = window.open('about:blank','prevw','width=600,height=400,resizable=yes,scrollbars=yes');
nw.document.writeln(form1.mailsubj.value);
nw.document.writeln('<hr noshade size=1>');
nw.document.writeln(form1.mailbody.value);
nw.document.writeln('<hr noshade size=1><div align=right><a href="#" onClick="self.close()">창닫기</a></divss>');
nw.focus();
}


function lastcheck(n) {
if (n.mailbody.value.length<1) {
alert("내용이 너무 짧습니다.");
return false;
}
return confirm("전체 메일을 보내시겠습니까?");
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<p>메일링리스트 전체메일보내기</p>
<form name="form1" method="post" action="maillist1.jsp" onSubmit="return lastcheck(this)">
<p>
제목:<input type="text" name="mailsubj" size="66" ><br>
<textarea name="mailbody" cols="70" rows="16" wrap="VIRTUAL"></textarea>
<br>
메일에 포함되는 이미지는 웹에서의 전체 경로를 적어주어야 합니다.<br>
예:) http://www.okjsp.pe.kr/images/okjsp_01.gif</p>
<p align="center">
<input type="button" name="Button" value="미리보기" onClick="preview(this)">
<input type="submit" name="Submit" value="전체메일보내기">
</p>
</form>
<p>&nbsp; </p>
</body>
</html>
