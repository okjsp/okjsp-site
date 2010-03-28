<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>

<%
	String bbs = CommonUtil.nchk(request.getParameter("bbs"), "perf");

	if(member.getSid() == 0) {
		response.sendRedirect("https://www.okjsp.pe.kr/jsp/member/loginMobile.jsp?returnPath=/m/editor.jsp?bbs=" + bbs);
		return; 
	}
%>
<html>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">

<!-- ############ IUI Header Start ########### -->
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<link rel="apple-touch-icon" href="/m/iui/iui-logo-touch-icon.png" />
<meta name="apple-touch-fullscreen" content="YES" />
<style type="text/css" media="screen">@import "/m/iui/iui.css";</style>
<script type="application/x-javascript" src="/m/iui/iui.js"></script>
<!-- ############ IUI Header End ########### -->

</head>
<!-- ############ 글쓰기_start ########### -->
<body>

    <form id="settings" class="panel" selected="true" action="/writemobile"  method="post">
        <h2>글 정보</h2>
        <fieldset style="text-align: center;">
	        <div class="row">
	            <label>BBS</label>
	            <select name="bbs" id="bbs" style="font-size:20px;font-family:Arial;width:70%">
					<jsp:include page="/jsp/option.jsp">
						<jsp:param name="bbs" value="<%= bbs %>"/>
					</jsp:include>
				</select>
	        </div>
	        <div class="row">
	            <label>Writer</label>
	            <input type="text" name="writer" id="writer" style="font-size:20px;font-family:Arial"/>
	        </div>
	        <div class="row">
	            <label>Homepage</label>
	            <input type="text" name="homepage" id="homepage" style="font-size:20px;font-family:Arial"/>
	        </div>
	        <div class="row">
	            <label>Password</label>
	            <input type="password" name="password"  id="password" style="font-size:20px;font-family:Arial"/>
	        </div>
	        <div class="row">
	            <label>CCL</label>
	            <select name="ccl_id" id="ccl_id" style="font-size:20px;font-family:Arial;width:70%;">
					<option value="0">Copyright-저작자에게 저작권</option>
					<option value="1">CCL-저작자표시</option>
					<option value="2">CCL-저작자표시-동일조건변경허락</option>
					<option value="3">CCL-저작자표시-변경금지</option>
					<option value="4">CCL-저작자표시-비영리</option>
					<option value="5">CCL-저작자표시-비영리-동일조건변경허락</option>
					<option value="6">CCL-저작자표시-비영리-변경금지</option>
				</select>
	        </div>
	    </fieldset>
        <h2>글 쓰기</h2>
        <fieldset style="text-align: center;">
	        <div class="row">
	            <label>Subject</label>
	            <input type="text" name="subject" id="subject" style="font-size:20px;font-family:Arial"/>
	        </div>
	        <div class="row">
	            <label>Content</label>
	            <!-- msgbackup:얘는 뭘까 흠... -->
	            <input type="hidden" name="msgbackup" id="msgbackup">
	            <p>
	            <textarea name="content" id="content" style="font-size:20px;font-family:Arial;width:95%;"></textarea>
	            </p>
	        </div>
        </fieldset>
        
        <a class="whiteButton" type="submit" href="#" target="_self">저장</a>
    </form>


</body>
<!-- ############ 글쓰기_end ########### -->
</html>
