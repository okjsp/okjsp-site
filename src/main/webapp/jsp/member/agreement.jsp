<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=euc-kr" %>
<%@page import="kr.pe.okjsp.Navigation"%><html>
<head>
<title>����������޹�ħ �� ȸ�����Ծ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
<link rel="stylesheet" href="/event/200908/nas.css" type="text/css">
<script type="text/javascript" src="/js/okjsp.js"></script>
<style type="text/css">
h1 {
	font-size:x-large;
	height:1em;
	margin-top:20px;
	text-align:center;
	width:610px;
}
#agreement_privacypolicy {
	width: 610px;
	border: 1px dotted #888;
	padding: 5px;
	margin: 10px auto;
}
#agreement_privacypolicy textarea {
	width: 600px;
	height: 160px;
	margin-bottom: 20px;
}
</style>
</head>
<body>
<jsp:include page="/top.jsp" />
<div style="float:left">
<jsp:include page="/menu.jsp" />
</div>

<div style="width:644px;float:left;margin-left:8px;">
<h1>����������޹�ħ �� ȸ�����Ծ��</h1>
<div id="agreement_privacypolicy">
<strong>����������޹�ħ</strong>
<jsp:include page="privacyPolicy.jsp" />
<strong>ȸ�����Ծ��</strong>
<jsp:include page="agree.html" />
<table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td align="center">�� ����������޹�ħ�� ȸ�����Ծ���� �����Ͻʴϱ�?</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td align="center"><form name="form1" method="post" 
        		action="<%= Navigation.getPath("SECURE_DOMAIN") %>/jsp/member/form.jsp">
                <input type="submit" name="Submit" value="�����մϴ�.">
                <input type="button" name="Submit2" value="�������� �ʽ��ϴ�."
                 onClick="window.close()">
            </form>
        </td>
    </tr>
    <tr>
	    <td height="40">&nbsp;
        </td>
    </tr>
</table>

</div>
</div>

<jsp:include page="/footer.jsp" />
<jsp:include page="/googleAnalytics.jsp" />

</body>
</html>
