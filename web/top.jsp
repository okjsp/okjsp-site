<%@ page pageEncoding="euc-kr"%>
<style type="text/css">
@import url("/site2009/okjsp2009.css");
</style>
<script type="text/javascript" src="/js/cookie.js"></script>
<div class="ln"></div>
<ul id="top">
	<li id="logo"><a href="/bbs?act=RECENT"><img src="/images/okjsp.gif" onfocus="this.blur()"/></a></li>
	<li id="find">
	<form name="searchf1" method="get" target="okjspsearch"
		action="http://www.google.com/search"
		onsubmit="searchf1.q.value='site:okjsp.pe.kr '+searchf1.qt.value;">
	<input name="q" value="site:okjsp.pe.kr " type="hidden"> 
	<input name="qt" value="" type="text"> 
	<input value="google" type="submit"></form>
	</li>
</ul>
<ul id="navi">
<li>
<input type="checkbox" onclick="doChange()" id="change"> OKJSP_HTML5사이트 변환&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="/jsp/alliance.jsp">동맹사이트</a>
</li>
</ul>
<div class="ln"></div>

<script type="text/javascript">
deleteCookie( 'urlChange' );
	if(getCookie( 'urlChange' ) == 'true'){
		top.location.href = 'http://www.okjsp.pe.kr/html5';
	}
	function doChange(){
		if(document.getElementById('change').checked == true){
			if(confirm('OKJSP_HTML5 사이트는 http://www.okjsp.pe.kr/html5로도 방문이 가능합니다.\n'+
					 '앞으로 OKJSP_HTML5  사이트로 보기 원하시면 "확인"을 눌러주세요.') == true){
				setCookie('urlChange','true',(3600*24*30));
				//로컬과 서버 설정 주의!!!
				top.location.href = 'http://www.okjsp.pe.kr/html5';
			}
		}
	}
</script>