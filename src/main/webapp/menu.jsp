<%@page import="kr.pe.okjsp.util.DomainUtil"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.Navigation"%><div id="menuSect">
<div style="margin-top:8px" id="menu_top">
  <A href="/lecture/" target="_blank">OKJSP 강좌</A>
  <br />
</div>
	<div>
	<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
	<jsp:setProperty name="member" property="id" value='<%= CommonUtil.getCookie(request, "okid") %>' />
	<c:if test="${empty member.id}">
		<a href="<%= DomainUtil.getSecureDomain(request.getRequestURL()) %>/jsp/member/login.jsp">로그인</a>
		<br />
		<a href="/jsp/member/agreement.jsp"><b>회원가입</b></a>
	</c:if>
		<SPAN ID="member" style="display:block; margin-left:0px">
		<c:if test="${!empty member.id}">
			<a href="<%= DomainUtil.getSecureDomain(request.getRequestURL()) %>/jsp/member/info.jsp" ><b><%= member.getId() %></b> 회원정보</a> 
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
  <A href="/bbs?act=MEMORECENT">새 메모 <img src="/images/check.png" style="width:15px;height:15px"></A>
  <br />
  <hr />
  open: <br />
  <A href="http://www.okjsp.pe.kr:8080" title="Jenkins CI tool">OKJSP Health</A>
  <br />
  <A href="https://github.com/okjsp/okjsp-site" title="OKJSP source">OKJSP 사이트소스</A>
  <br />
  <A href="http://kenu.github.com/tomcat70/docs" title="Tocmat7kr">톰캣7 문서 한글화</A>

  <hr>ad:
  <ul id="menuad">
  <script type="text/javascript">
  if (typeof Banner=="object") { 
    Banner.showLeftSide(); 
    Banner.showLeftSideImg();
  }
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
   <br><A href="http://it.nodong.net/zbxe/?mid=JOBQNA01"
   title="it.nodong.net" target="jobqna">일터Q&amp;A</A>
   <br><A href="http://www.akose.or.kr"
   title="한국 소프트웨어 개발자 협회" target="akose">한국 소프트웨어 개발자 협회</A>
	<hr>
  <br>
<ul>
<li>
<a href="/jsp/alliance.jsp">동맹사이트</a>
</li>
</ul>
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
	<br />
	<a href="/f.jsp?http://www.skplanet.co.kr/" target="_blank"
	 title="SK Planet">
	<img src="/images/banner/skp_88x31.png" width="88" height="31" border="0"></a>
</div>
</div>