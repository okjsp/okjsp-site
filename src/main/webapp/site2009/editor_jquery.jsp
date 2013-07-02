<%@page import="kr.pe.okjsp.BbsRoleHandler"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	long sid = CommonUtil.getCookieLong(request, "sid");
	String bbs = CommonUtil.nchk(request.getParameter("bbs"), "perf");
	
	if(sid == 0) {
		response.sendRedirect(Navigation.getPath("LOGFORM")+"?returnPath=/site2009/editor_jquery.jsp?bbs="+bbs);
		return; 
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.Navigation"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>okjsp editor</title>

<link rel="stylesheet" href="/js/jquery/jwysiwyg-0.5/jquery.wysiwyg.css" type="text/css">
<link rel="stylesheet" href="/css/style.css" type="text/css">
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">

<script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="/js/jquery/jwysiwyg-0.5/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="/js/okjsp.js"></script>
<script type="text/javascript" src='/js/ban.js'></script>
<script type="text/javascript">
$(function() {
	$('#content').wysiwyg();
	$('#content').change(sync);
	$('#f1').submit(check);
	
	$("#writer").val(getCookie("okwriter"));
	$("#homepage").val(getCookie("okhome"));
});

var sync = function() {
	var ifr = document.getElementById("contentIFrame");
	ifr.contentWindow.document.body.innerHTML=$("#content").val();
}
</script>

</head>
<body class="yui-skin-sam body">
<jsp:include page="/top.jsp" />
<div style="float:left">
<jsp:include page="/menu.jsp" />
</div>

<div id="form_div">
<form name="f1" id="f1" action="/write" method="post" class="form_write">
<input name="html" id="html" value="2" type="hidden" readonly="readonly" class="write">


<dl>
<dt>
<label for="bbs">bbs:</label>
</dt>
<dd>
<%
	// hideIt
	boolean isAdmin = BbsRoleHandler.isAdmin(sid);
	if (!isAdmin) {
		request.setAttribute("hideIt", new Boolean(true));
	}
%>	
<select id="bbs" name="bbs" size="1">
<jsp:include page="/jsp/option.jsp"></jsp:include>
</select>
<script type="text/javascript">
	document.getElementById('bbs').value = '<%= bbs %>';
</script>
</dd>
<dt>
<label for="writer">Writer:</label>
</dt>
<dd>
<input name="writer" id="writer" class="write">
</dd>
<dt>
<label for="homepage">homepage:</label>
</dt>
<dd>
<input name="homepage" id="homepage" class="write">
</dd>
<dt>
<label for="password">password:</label>
</dt>
<dd>
<input name="password" id="password" type="password" class="write">
</dd>
<dt>
<label for="ccl_id">CCL:</label>
</dt>
<dd>
<select name="ccl_id" id="ccl_id">
	<option value="0">Copyright-저작자에게 저작권</option>
	<option value="1">CCL-저작자표시</option>
	<option value="2">CCL-저작자표시-동일조건변경허락</option>
	<option value="3">CCL-저작자표시-변경금지</option>
	<option value="4">CCL-저작자표시-비영리</option>
	<option value="5">CCL-저작자표시-비영리-동일조건변경허락</option>
	<option value="6">CCL-저작자표시-비영리-변경금지</option>
</select>
</dd>
<dt>
<label for="subject">Subject:</label>
</dt>
<dd>
<input name="subject" id="subject" class="write">
</dd>
<dd>
<input type="hidden" name="msgbackup" id="msgbackup">
<textarea name="content" id="content" rows="6" class="write">
</textarea>
</dd>
<dd>
<input id="submitButton" type="submit" value="Submit"/>
</dd>
</dl>
</form>

</div>

<jsp:include page="/footer.jsp" />
<jsp:include page="/googleAnalytics.jsp" />

</body>
</html>