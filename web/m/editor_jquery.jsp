<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	//long sid = CommonUtil.getCookieLong(request, "sid");
	//String id = CommonUtil.getCookie(request, "okid");
	String id = "pikisvill";
	long sid = 9380;
	String bbs = CommonUtil.nchk(request.getParameter("bbs"), "perf");
	
	//요거 좀 고민...
	if(sid == 0) {
		response.sendRedirect(Navigation.getPath("LOGFORM")+"?returnPath=/site2009/editor.jsp?bbs="+bbs);
		return; 
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@page import="kr.pe.okjsp.Navigation"%>

<html>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">

<!-- ############ IUI Header Start ########### -->
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<link rel="apple-touch-icon" href="../../m/iui/iui-logo-touch-icon.png" />
<meta name="apple-touch-fullscreen" content="YES" />
<style type="text/css" media="screen">@import "../../m/iui/iui.css";</style>
<script type="application/x-javascript" src="../../m/iui/iui.js"></script>
<!-- ############ IUI Header End ########### -->
</head>
<!-- ############ 글쓰기_start ########### -->
<body>
    <div class="toolbar">
        <h1 id="pageTitle"></h1>
        <a id="backButton" class="button" href="#"></a>
    </div>
    <form action="/write" method="post" class="panel"  selected="true">
    <input name="html" id="html" value="2" type="hidden" readonly="readonly" class="write">
    <input name="mobileView" id="mobileView" value="Y" type="hidden" readonly="readonly" class="write">
    <fieldset>
        <div class="row">
            <label>bbs</label>
            <select name="bbs" style="font-size:20px;font-family:Arial;width:200px">
				<jsp:include page="/jsp/option.jsp"></jsp:include>
			</select>
			<script type="text/javascript">
				document.getElementById('bbs').value = '<%= bbs %>';
			</script>
        </div>
        <div class="row">
            <label>Writer</label>
            <input type="text" name="writer" />
        </div>
        <div class="row">
            <label>homepage</label>
            <input type="text" name="homepage" />
        </div>
        <div class="row">
            <label>password</label>
            <input type="password" name="password"/>
        </div>
        <div class="row">
            <label>CCL</label>
            <select name="ccl_id" style="font-size:20px;font-family:Arial;width:200px">
				<option value="0">Copyright-저작자에게 저작권</option>
				<option value="1">CCL-저작자표시</option>
				<option value="2">CCL-저작자표시-동일조건변경허락</option>
				<option value="3">CCL-저작자표시-변경금지</option>
				<option value="4">CCL-저작자표시-비영리</option>
				<option value="5">CCL-저작자표시-비영리-동일조건변경허락</option>
				<option value="6">CCL-저작자표시-비영리-변경금지</option>
			</select>
        </div>
        <div class="row">
            <label>Subject</label>
            <input type="text" name="subject" />
        </div>
        <div class="row">
            <label>Content</label>
            <!-- msgbackup:얘는 뭘까 흠... -->
            <input type="hidden" name="msgbackup" id="msgbackup">
            <textarea name="content" id="content" style="font-size:20px;font-family:Arial;width:320px"></textarea>
        </div>
    </fieldset>
    <a class="whiteButton" type="submit" href="#">저장</a>
    </form>
</body>
<!-- ############ 글쓰기_end ########### -->
</html>
