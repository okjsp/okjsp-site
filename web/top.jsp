<%@ page pageEncoding="euc-kr"%>
<style type="text/css">
@import url("/site2009/okjsp2009.css");
</style>
<script type="text/javascript" src="/js/cookie.js"></script>
<div class="ln"></div>
<ul id="top">
	<li id="logo"><a href="http://www.okjsp.pe.kr/bbs?act=RECENT"><img src="/images/okjsp_160x50.gif" style="margin-left: -10px; "></a></li>
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
<input type="checkbox" onclick="doChange()" id="change"> OKJSP_HTML5����Ʈ ��ȯ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="/jsp/alliance.jsp">���ͻ���Ʈ</a>
</li>
</ul>
<div class="ln"></div>

<script type="text/javascript">
	//�ҽ� ������ ���� �ӽ÷� ��������...
	//deleteCookie( 'urlChange' );
	if(getCookie( 'urlChangeOKSJSP' ) == 'true'){
		var current = document.location.href;
		current = current.replace(/pe\.kr/i,"pe.kr/html5");
		top.location.href = current;
	}
	function doChange(){
		if(document.getElementById('change').checked == true){
			if(confirm('OKJSP_HTML5 ����Ʈ�� http://www.okjsp.pe.kr/html5�ε� �湮�� �����մϴ�.\n'+
					 '������ OKJSP_HTML5  ����Ʈ�� ���� ���Ͻø� "Ȯ��"�� �����ּ���.') == true){
				setCookie('urlChangeOKSJSP','true',(3600*24*30));
				//���ð� ���� ���� ����!!!
				top.location.href = 'http://www.okjsp.pe.kr/html5';
			} else {
				document.getElementById('change').checked = false;
			}
		}
	}
</script>