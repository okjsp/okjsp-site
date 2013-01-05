<%
   int idx = response.getContentType().indexOf('=');
   String charset = response.getContentType().substring(idx+1); %>
<div id="wrap">
<style type="text/css">
@import url("/site2009/okjsp2009.css");
</style>
<ul id="top">
	<li id="logo"><a href="http://www.okjsp.pe.kr/bbs?act=FIRST_MAIN"><img src="/images/okjsp_160x50.gif" style="margin-left: -10px; "></a></li>
	<li id="find">
	<form name="searchf1" method="get" target="okjspsearch"
		action="http://www.google.com/search"
		onsubmit="searchf1.q.value='site:okjsp.pe.kr '+searchf1.qt.value;">
	<input name="q" value="site:okjsp.pe.kr " type="hidden"> 
	<input name="qt" value="" type="text"> 
	<input name="ie" value="<%= charset %>" type="hidden"> 
	<input value="google" type="submit"></form>
	</li>
</ul>
