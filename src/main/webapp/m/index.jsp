<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<title>OKJSP Mobile</title>
<link rel="apple-touch-icon" href="/m/images/okJSP.png" />
<script type="text/javascript" src="/js/okjsp.js"></script>
<script type="text/javascript" >
	
	if ( getCookie( 'okjspwithjqm' ) == 'true' ){
		top.location.href = 'http://www.okjsp.pe.kr/jqm/index.jsp';
	} else if ( getCookie( 'okjspwithiui' ) == 'true' ) {
		top.location.href = 'http://www.okjsp.pe.kr/iui/index.jsp';		
	}
	
	function doChange(what){
		setCookie('okjspwith'+what,'true',(3600*24*2));
		top.location.href = 'http://www.okjsp.pe.kr/'+what;
	}
	
</script>
</head>
<body>
	<div style="text-align:center;">
		<img src="/m/images/okjspscreen.png" style="width:100px;"/><br/>
		<a href="/jqm/index.jsp" onclick="doChange('jqm'); return false;"><img src="/m/images/jqm.png"/></a><br/>
		<a href="/iui/index.jsp" onclick="doChange('iui'); return false;"><img src="/m/images/iui.png"/></a>
	</div>
</body>
</html>