<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>

<%
	String bbs = CommonUtil.nchk(request.getParameter("bbs"), "perf");

	//if(member.getSid() == 0) {
	//	response.sendRedirect("https://www.okjsp.pe.kr/jsp/member/loginMobile.jsp?returnPath=/m/editor.jsp?bbs=" + bbs);
	//	return; 
	//}
	
	member.setId("bluepoet");
	member.setSid(3146);
%>
<html>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">

<!-- ############ 쓰기처리(prototype 사용)  ########### -->
<script type="text/javascript" src="/m/js/prototype-1.6.0.2.js"></script>
<script language="javascript">

//1. AJAX 호출(광고 중복아이디 체크)
function writeProc()
{
	alert('1111');
	var form = document.form;
	var url = "writeProc.jsp";
	var pars = "writer="+form.writer.value+"&bbs="+form.bbs.value+"&content="+form.content.value+"&subject="+form.subject.value+"&homepage="+form.homepage.value+"&password="+form.password.value+"&ccl_id="+form.ccl_id.value;
	var ajaxObj = new Ajax.Request(
			url,
			{
			method: 'GET', 			
			parameters: pars,					 				    
			onComplete: goList
		});

	return false;
}		

//2. AJAX 결과값 받기(광고타입 변경결과값 받기)
function goList(responseHttpObj)
{					
	var returnData = eval("(" + responseHttpObj.responseText+ ")");					
	var result = returnData.data.result;
	
	if(result != 0)
	{
		alert('결과가 입력되었습니다.');		
	}	
}
</script>
</head>
<!-- ############ 글쓰기_start ########### -->
<body>
    <div title="글쓰기">
    	<!-- target="_self"지정해서 화면 깨지는 현상 해결 -->
    	<!-- iui.js에서 참조 -->
    	<fieldset>
	    <form name="form" action="javascript:history.back();" onsubmit="return writeProc()" method="post" class="panel"  selected="true" target="_self">
	    
	        <div class="row">
	            <label>bbs</label>
	            <select name="bbs" id="bbs" style="font-size:20px;font-family:Arial;width:200px">
					<jsp:include page="/jsp/option.jsp"></jsp:include>
				</select>
				<script type="text/javascript">
					document.getElementById('bbs').value = '<%= bbs %>';
				</script>
	        </div>
	        <div class="row">
	            <label>Writer</label>
	            <input type="text" name="writer" id="writer" style="font-size:20px;font-family:Arial"/>
	        </div>
	        <div class="row">
	            <label>homepage</label>
	            <input type="text" name="homepage" id="homepage" style="font-size:20px;font-family:Arial"/>
	        </div>
	        <div class="row">
	            <label>password</label>
	            <input type="password" name="password"  id="password" style="font-size:20px;font-family:Arial"/>
	        </div>
	        <div class="row">
	            <label>CCL</label>
	            <select name="ccl_id" id="ccl_id" style="font-size:20px;font-family:Arial;width:200px">
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
	            <input type="text" name="subject" id="subject" style="font-size:20px;font-family:Arial"/>
	        </div>
	        <div class="row">
	            <label>Content</label>
	            <!-- msgbackup:얘는 뭘까 흠... -->
	            <input type="hidden" name="msgbackup" id="msgbackup">
	            <textarea name="content" id="content" style="font-size:20px;font-family:Arial;width:320px"></textarea>
	        </div>
	    	<div class="row"><br/>
	    		<input type="submit" value="저장"><br/-->							
	    	</div>
	    </form>
	    </fieldset>
    </div>
</body>
<!-- ############ 글쓰기_end ########### -->
</html>
