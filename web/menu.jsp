<%@page pageEncoding="euc-kr"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.Navigation"%><div id="menuSect">
	<div>
	<img src="/images/skin/white.gif" class="skinButton" onclick="setSkin('white')" alt="white skin"
	><img src="/images/skin/black.gif" class="skinButton" onclick="setSkin('black')" alt="black skin"
	><img src="/images/skin/blue.gif" class="skinButton" onclick="setSkin('blue')" alt="blue skin"
	></div>
	<div>
	<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
	<jsp:setProperty name="member" property="id" value='<%= CommonUtil.getCookie(request, "okid") %>' />
	<c:if test="${empty member.id}">
		<a href="/jsp/member/agreement.jsp"><b>join</b></a>
		/
		<a href="<%= Navigation.getPath("LOGFORM") %>">login</a>
	</c:if>
		<SPAN ID="member" style="display:block; margin-left:0px">
		<c:if test="${!empty member.id}">
			<a href="<%= Navigation.getPath("SECURE_DOMAIN") %>/jsp/member/info.jsp" ><b><%= member.getId() %></b> info</a> /
			<a href="/jsp/member/logout.jsp" >logout</a>
			<br>
			<a href="/bbs?act=BOOKMARK" >책갈피</a>
		</c:if>
		</SPAN>
	</div>
  <hr>
  <A href="/bbs?act=LIST&bbs=notice">공지사항</A>
  <div class="noticemenu">
  <a href="/jsp/member/agreement.jsp" target="privacy"><strong>개인정보취급방침</strong></a>
  </div>
	<hr>ad:
  <div class="noticemenu">
	<A href="/f.jsp?http://www.innorix.com/DS/"
   title="대용량 파일/폴더 업로드 컴포넌트" target="innorix">업로드는 InnoDS</A>
	<br><A href="http://www.imaso.co.kr/"
   title="프로그래머를 위한 잡지" target="imaso">마소 Magazine</A>
  </div>

<h2 id="bbslistmenu">BBS LIST</h2>
<select id="bbslist" onchange="jumpto(this)" size="18">
<jsp:include page="/jsp/option.jsp"></jsp:include>
</select>
<script type="text/javascript">
	document.getElementById('bbslist').value = '<%= request.getParameter("bbs") %>';
	function jumpto(e) {
		document.location.href='/bbs?act=LIST&bbs='+e.value;
	}
</script>
  <hr>
  <A HREF="#" onClick="return toggleMenu('menu1')"><strong>Links</strong>
  <font style="color:red" class="tiny">▽</font></A>
  <SPAN ID="menu1" style="display:none; margin-left:10px">
	<br><a href="/seq/26794">API/Spec</a>
	<br><a href="/seq/26934">Maillist/FAQ</a>
	<br><a href="http://www.eclipse.org/downloads/">Eclipse Download</a>
	<br><a href="/seq/47126">okjsp site소스</a>
  </SPAN>
   <br><A href="http://cafe.naver.com/appleswing"
   title="애플스윙댄스카페 운동부족개발자에게 적극 추천합니다. ^^; 저는 14기 졸업했습니다." target="swing">애플스윙댄스카페</A>
   <br><A href="http://it.nodong.net/zbxe/?mid=JOBQNA01"
   title="회사,일터,경력 관련 이야기 it.nodong.net" target="jobqna">일터Q&amp;A</A>
	<hr>
  <br>
  <br><a href="/rss" title="rss feed links"><img src="/images/rss-xml.png" style="border:0" alt="rss"/></a><br>
  <br>

<script type="text/javascript">
	setMenuDefault('menu1');
</script>

	<div>
		<div class="tiny">powered by:</div>
		<a href="http://www.80port.com/community" target="_blank"
		 title="www.80port.com
		 okjsp standalone 호스팅 지원, 서비스 좋습니다.">
		<img src="/images/bnr_80port.gif" width="88" height="31" border="0"></a>
	</div>
</div>