<%@ page pageEncoding="euc-kr" %>
<html>
<head>
<title>okjsp ȸ�� ����</title>
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
<h1>okjsp.pe.kr ȸ������</h1>
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
        <input type="button" name="btn_check_id" value="�ߺ�Ȯ��"
        onClick="idpop()">
      </td>
    </tr>
    <tr>
      <th>�̸�
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
      <th>���ϼ���</th>
      <td>
      	okjsp���� ������������ �����ϴ� �������Ϳ� ȫ������ ���� �����Դϴ�.
      	<br>
        <input type="radio" name="mailing" id="y" value="Y">
        <label for="y">���</label> 
        <input type="radio" name="mailing" id="n" value="N" checked>
        <label for="n">�ź�</label> 
      </td>
    </tr>
  </table>
  <table>
    <tr>
      <td>
      ���Խ� �ӽú�й�ȣ�� ���Ϸ� �߼۵˴ϴ�. <br>
      �α��� �� ��й�ȣ�� �ٲ��ֽñ� �ٶ��ϴ�.
      </td>
    </tr>
    <tr>
      <td>
        <input type="hidden" name="password" value="fake" >
        <input type="hidden" name="password2" value="fake" >
        <input type="submit" id="join" name="join" value="����" >
        <input type="button" id="cancel" value="���" >
      </td>
    </tr>
  </table>
</form>
<pre>

-- ȸ������ �ҽ�, ���� 0.4 beta --
</pre>
</div>

<jsp:include page="/footer.jsp" />
<jsp:include page="/googleAnalytics.jsp" />

</body>
</html>

