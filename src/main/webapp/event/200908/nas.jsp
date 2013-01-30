<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="kr.pe.okjsp.MemoBean"%>
<%@page import="kr.pe.okjsp.Navigation"%>
<%@page import="kr.pe.okjsp.member.Member"%>
<%@page import="kr.pe.okjsp.MemoHandler"%>
<%
	int seq = 110084;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>OKJSP Event::: LG NAS</title>
    <link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
    <link rel="stylesheet" href="/event/200908/nas.css" type="text/css">
	<script type="text/javascript" src="/js/okjsp.js"></script>
    <script type="text/javascript" src="/js/okboard_view.js"></script>

</head>
<body>
<jsp:include page="/top.jsp" />
<div style="float:left">
<jsp:include page="/menu.jsp" />
</div>
	<div style="width:644px;float:left;margin-left:8px;">

		<div><img src="images/nas_event644_1.jpg"></div>
		<div><img src="images/nas_event644_2.jpg"></div>
		<div><img src="images/nas_event644_3.jpg"></div>
		<div><img src="images/nas_event644_4.jpg"></div>

	</div>

	<div id="eventMsg">
	<ul>
	<li>�Ʒ� ���� �� ��1�Ͽ� ������ �����ּ���. ��÷�� ���� ü��� ��ȸ�� �����մϴ�.</li>
	<li>1) ������ <strong>LG NAS</strong>�� �ʿ��� ����</li>
	<li>2) �츮 ȸ�翡�� <strong>LG NAS</strong>�� �ʿ��� ����</li>
	<li class="msgMore">�̺�Ʈ ��ǰ�� <strong>NS1 N4B1N(2TB)</strong>�̸�,
���� ���� �������� ü��ܿ��� ��ǰ���� <strong>80����</strong>�� �����մϴ�.(<strong>��,��ġ�� ����</strong>)
���ϰ� <strong>1,690,000��</strong> �����̴�, �� 50% ���� ������ �˴ϴ�.
	</li>
	</ul>
	</div>
<form name="f0" id="f0" method="POST" action="/jsp/memo" onSubmit="return chk_memo(this)">
    <input type="hidden" name="pact" value="MEMO">
    <input type="hidden" name="seq" value="<%= seq %>">
    <input type="hidden" name="pg" value="0">
    <input type="hidden" name="keyfield" value="<%=  CommonUtil.nchk(request.getParameter("keyfield"),"content")  %>">
    <input type="hidden" name="keyword" value="<%=  CommonUtil.nchk(request.getParameter("keyword"))  %>">
    <input type="hidden" name="viewstamp" value="<%= System.currentTimeMillis() %>">
	<div id="layer_delpass" style="position:absolute;display:none;width:220px;height:60px;padding:10px" align="center">
		<input type="password" id="delpass" name="delpass" maxlength="15">
		<input type="hidden" name="mseq">
		<br>
		<input type="submit" value="����">
		<input type="button" value="���"
		onclick="document.f0.mseq.value='';document.f0.delpass.value='';return toggleMenu('layer_delpass')">
	</div>
<div id="m" class="tablestyle">
<%
  ArrayList memoList = new MemoHandler().getList(seq);
  Iterator memo = null;
  if (memoList != null) {
    memo = memoList.iterator();
    while (memo.hasNext()) {
      MemoBean mb = (MemoBean)memo.next();
%><ul><li class="c">
<okbbs:link>
<okbbs:html br="true"><%= mb.getBcomment() %></okbbs:html>
</okbbs:link>
</li>
<li class="w"><%
    if (mb.getId() != null) {
        %><img src="http://www.okjsp.pe.kr/profile/<%= mb.getId() %>.jpg"
        	alt="<%= mb.getId() %>"
        	style="width:36px;height:36px"><%
    }
%><%= mb.getWriter() %></li>
<li class="d"><%= mb.getWhen("yyyy-MM-dd HH:mm:ss")
%></li><li class="e"><a href="javascript:show_memodel('<%= mb.getMseq() %>')">x</a></li></ul><%
    } // end while
  }
%>
</div>
<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
    <tr>
    <td colspan="2" width="100%" class="td" align="right">
<%
	Member member = (Member)session.getAttribute("member");
	if (member.getSid() == 0) {
		member.setSid(CommonUtil.getCookieLong(request, "sid"));
	}

	if (member.getSid() > 0) {
%>
        <textarea name="bcomment" style="width:100%;height:80px"></textarea>
        id:<input type="text" class="memoid" name="writer"
            maxlength="50" value="<%= CommonUtil.a2k(CommonUtil.getCookie(request, "okwriter")) %>">
        pw:<input type="password" class="memopw" name="memopass" maxlength="15">
<%
	String mFlag = CommonUtil.getCookie(request, "memo");
	if (!"true".equals(mFlag)) {
%>
	    <input type="text" name="doublecheck" class="memodc" value="ok">
	    <span style="color:#f00">�ٷ� �� ĭ�� okjsp ���ڸ� �ϼ��� �ּ���.</span>
<%
	}
%>
	    <br /><span style="color:#f00">IP ����˴ϴ�. ������ ���� �ø��� �����ô� �� ����Ʈ ��� ������ �˴ϴ�.
	    <br />�������� �ʿ�� �����ϱ��. ������ ��, �㸻�� ��, ���ͳݸ��� �˻�����</span>
        <br /><input type="submit" name="send" value="Memo">
<%
    } else {
%>
        <textarea name="bcomment" style="width:100%;height:80px" readonly="readonly" 
        onclick="document.location.href='<%= Navigation.getPath("SECURE_DOMAIN") %>/jsp/member/login.jsp?returnPath='+document.location.href">�α��� �� �޸���� �� �� �ֽ��ϴ�.</textarea>
<%
    }

%>
    </td>
    </tr>
</table>
</form>

<jsp:include page="/footer.jsp" />
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>
