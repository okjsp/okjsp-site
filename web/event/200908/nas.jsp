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
	<li>아래 주제 중 택1하여 덧글을 남겨주세요. 추첨을 통해 체험단 기회를 제공합니다.</li>
	<li>1) 나에게 <strong>LG NAS</strong>가 필요한 이유</li>
	<li>2) 우리 회사에게 <strong>LG NAS</strong>가 필요한 이유</li>
	<li class="msgMore">이벤트 제품은 <strong>NS1 N4B1N(2TB)</strong>이며,
최종 할인 혜택으로 체험단에게 제품가를 <strong>80만원</strong>에 제공합니다.(<strong>단,설치비 제외</strong>)
출하가 <strong>1,690,000원</strong> 정도이니, 약 50% 할인 혜택이 됩니다.
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
		<input type="submit" value="삭제">
		<input type="button" value="취소"
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
	    <span style="color:#f00">바로 앞 칸에 okjsp 글자를 완성해 주세요.</span>
<%
	}
%>
	    <br /><span style="color:#f00">IP 노출됩니다. 예민한 얘기는 올리지 않으시는 게 사이트 운영에 도움이 됩니다.
	    <br />개조심할 필요는 있으니까요. 낮말은 새, 밤말은 쥐, 인터넷말은 검색엔진</span>
        <br /><input type="submit" name="send" value="Memo">
<%
    } else {
%>
        <textarea name="bcomment" style="width:100%;height:80px" readonly="readonly" 
        onclick="document.location.href='<%= Navigation.getPath("SECURE_DOMAIN") %>/jsp/member/login.jsp?returnPath='+document.location.href">로그인 후 메모글을 쓸 수 있습니다.</textarea>
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
