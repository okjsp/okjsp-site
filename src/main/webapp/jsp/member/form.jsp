<%@ page pageEncoding="euc-kr" %>
<html>
<head>
<title>okjsp 회원 가입</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
<link rel="stylesheet" href="/event/200908/nas.css" type="text/css">
<script type="text/javascript" src="/js/okjsp.js"></script>

<script src="form.js"></script>
<link rel="stylesheet" href="member.css" type="text/css">
</head>

<body>
<jsp:include page="/top.jsp" />
<div style="float:left">
<jsp:include page="/menu.jsp" />
</div>

<div id="joinform">
<h1>okjsp.pe.kr 회원가입</h1>
<form name="f1" method="post" action="register.jsp"
	class="register" onsubmit="return check_value(this)">
  <table>
    <tr>
      <th>Email 
      <span class="required">*</span></th>
      <td>
        <input type="text" id="email" name="email" maxlength="40"
        onChange="return id_from_email()" >
      </td>
    </tr>
    <tr>
      <th>ID
      <span class="required">*</span></th>
      <td>
        <input type="text" name="id" maxlength="12" >
        <input type="button" name="btn_check_id" value="중복확인"
        onClick="idpop()">
      </td>
    </tr>
    <tr>
      <th>이름
      <span class="required">*</span></th>
      <td>
        <input type="text" name="name" >
      </td>
    </tr>
    <tr>
      <th>homepage</th>
      <td>
        <input type="text" name="homepage" maxlength="50" style="width:240"
        >
      </td>
    </tr>
    <tr>
      <th>메일수신</th>
      <td>
      	수신동의를 해주시면 유익한 정보가 가득 담긴 뉴스레터와 홍보메일을 받아보실 수 있습니다.
      	<br>
        <input type="radio" name="mailing" id="y" value="Y" checked="checked">
        <label for="y">허용</label> 
        <input type="radio" name="mailing" id="n" value="N">
        <label for="n">거부</label> 
      </td>
    </tr>
  </table>
  <table>
    <tr>
      <td>
      가입시 임시비밀번호가 메일로 발송됩니다. <br>
      로그인 후 비밀번호를 바꿔주시기 바랍니다.
      </td>
    </tr>
    <tr>
      <td>
        <input type="hidden" name="password" value="fake" >
        <input type="hidden" name="password2" value="fake" >
        <input type="submit" id="join" name="join" value="가입" >
        <input type="button" id="cancel" value="취소" >
      </td>
    </tr>
  </table>
</form>
<pre>

-- 회원관리 소스, 버전 0.4 beta --
</pre>
</div>

<jsp:include page="/footer.jsp" />
<jsp:include page="/googleAnalytics.jsp" />

</body>
</html>

