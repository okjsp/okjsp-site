<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.Navigation"%><div id="menuSect">
<div style="margin-top:8px" id="menu_top">
  <A href="/lecture/" target="_blank">OKJSP 강좌</A>
  <br />
	<a href="#" onclick="setSkin('white')"><img src="/images/skin/white.gif" class="skinButton" alt="white skin">웹 style</a>
  <br />
	<a href="#" onclick="setSkin('black')"><img src="/images/skin/black.gif" class="skinButton" alt="black skin">CRT style</a>
  <br />
	<a href="#" onclick="setSkin('blue')"><img src="/images/skin/blue.gif" class="skinButton" alt="blue skin">나우누리 style</a>
  <br />
</div>
	<div>
	<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
	<jsp:setProperty name="member" property="id" value='<%= CommonUtil.getCookie(request, "okid") %>' />
	<c:if test="${empty member.id}">
		<a href="<%= Navigation.getPath("LOGFORM") %>">로그인</a>
		<br />
		<a href="/jsp/member/agreement.jsp"><b>회원가입</b></a>
	</c:if>
		<SPAN ID="member" style="display:block; margin-left:0px">
		<c:if test="${!empty member.id}">
			<a href="<%= Navigation.getPath("SECURE_DOMAIN") %>/jsp/member/info.jsp" ><b><%= member.getId() %></b> 회원정보</a> 
<br>
			<a href="/jsp/member/logout.jsp" >로그아웃</a>
			<br>
			<a href="/bbs?act=BOOKMARK" >책갈피</a>
		</c:if>
		</SPAN>
	</div>
  <hr>
  <A href="/bbs?act=LIST&bbs=notice">공지사항</A>
  <br />
  <A href="/bbs?act=MEMORECENT">새 메모</A>
  <br />
  <A href="http://www.okjsp.pe.kr:7001">node.js chat</A>
  <br />
  <A href="http://www.okjsp.pe.kr:8080" title="Jenkins CI tool">OKJSP Health</A>

  <hr>ad:
  <ul id="menuad">
  <script type="text/javascript">
  if (typeof Banner=="object") { Banner.showLeftSide(); }
  </script>
  </ul>

<h2 id="bbslistmenu">BBS LIST</h2>
<select id="bbslist" onchange="jumpto(this)" size="18">
<jsp:include page="/jsp/option.jsp"></jsp:include>
</select>
<script type="text/javascript">
	document.getElementById('bbslist').value = '<%= request.getParameter("bbs") %>';
</script>
  <hr>
   <br><A href="http://webdevmobile.com/"
   title="html5, " target="_blank">WebDevMobile</A>
   <br><A href="http://it.nodong.net/zbxe/?mid=JOBQNA01"
   title="it.nodong.net" target="jobqna">일터Q&amp;A</A>
	<hr>
  <br>
  <a href="http://twitter.com/okjsp" class="twitter-follow-button" data-show-count="false" data-lang="ko">Follow @okjsp</a>
<script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script>
  <br>
  <br><a href="/rss" title="rss feed links"><img src="/images/rss-xml.png" style="border:0" alt="rss"/></a><br>
  <br>

<script type="text/javascript">
	setMenuDefault('menu1');
</script>

<div id="sponsorBanner">
	<div>sponsored by:</div>
	<a href="http://www.80port.com/community" target="_blank"
	 title="www.80port.com
	 okjsp standalone 호스팅을 지원해주시는 고마운 회사 팔공포트">
	<img src="/images/bnr_80port.gif" width="88" height="31" border="0"></a>
	<br />
	<a href="/f.jsp?http://www.cubrid.com/" target="_blank"
	 title="okjsp Database">
	<img src="/images/banner/cubrid_88x31.gif" width="88" height="31" border="0"></a>
</div>
</div>