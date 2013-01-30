<%@ page language="java" contentType="text/html; charset=EUC-KR"
	import="kr.pe.okjsp.util.CommonUtil"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>

<%
	String bbs = CommonUtil.nchk(request.getParameter("bbs"), "perf");
	long sid = CommonUtil.getCookieLong(request, "sid");
	String id = CommonUtil.getCookie(request, "okid");

	if(sid == 0) {
		response.sendRedirect("/jsp/member/loginMobile.jsp?returnPath=/iui/editor.jsp?bbs=" + bbs);
		return; 
	}
%>
<form id="settings" class="panel" selected="true" action="/writemobile"  method="post">
       <h2>�� ����</h2>
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
            <input type="text" name="writer" id="writer" style="font-size:20px;font-family:Arial" value="<%=id%>" />
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
				<option value="0">Copyright-�����ڿ��� ���۱�</option>
				<option value="1">CCL-������ǥ��</option>
				<option value="2">CCL-������ǥ��-�������Ǻ������</option>
				<option value="3">CCL-������ǥ��-�������</option>
				<option value="4">CCL-������ǥ��-�񿵸�</option>
				<option value="5">CCL-������ǥ��-�񿵸�-�������Ǻ������</option>
				<option value="6">CCL-������ǥ��-�񿵸�-�������</option>
			</select>
        </div>
    	</fieldset>
		<h2>�� ����</h2>
		<fieldset>
		 <div class="row">
		     <label>Subject</label>
		     <input type="text" name="subject" id="subject" style="font-size:20px;font-family:Arial"/>
		 </div>
		 <div class="row" style="text-align:center;">
		     <textarea name="content" id="content" style="font-size:20px;font-family:Arial;width:95%;padding:0;"></textarea>
		 </div>
		</fieldset>
       	<a class="whiteButton" type="submit" href="#" target="_self">����</a>
   </form>