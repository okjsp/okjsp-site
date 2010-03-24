<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ page import="java.util.*,kr.pe.okjsp.util.CommonUtil,kr.pe.okjsp.*"
	pageEncoding="euc-kr" %>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:useBean id="one"  class="kr.pe.okjsp.Article" scope="request"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler" />

	<ul id="detailView" >
		<li>
			<!-- ###########제목################################# -->
			<h2><%= CommonUtil.showHtml(one.getSubject()) %></h2>
			<!-- ###########이미지및사용자id_시작################################# -->
			<%
			    if (!"".equals(one.getId())) {
			%><img src="http://www.okjsp.pe.kr/profile/<%= one.getId() %>.jpg"
			        	alt="<%= one.getId() %>"
			        	style="width:77px"
			        	onerror="this.src='/images/spacer.gif'"><%
			    }
			%>
			<c:out value="${one.writer}"/> / <c:out value="${one.when}" />
			<!-- ###########이미지및사용자id_끝################################# -->
			<!-- ###########삭제버튼_작성자와로그인아이디가동일할때만 생성################################# -->
			<%
			if(one.getId().equals(member.getId())){
			%>	
				<a class="button" href="#deleteForm">delete</a>
			<%	
			}
			%>
		</li>
		<br/>
		<li>
			<!-- ###########내용################################# -->
			<%=  one.getContentView()  %>
		</li>
		<br/>
		<!-- ################  뎃글 ##################### -->
		<%
		  ArrayList<MemoBean> memoList = new MemoHandler().getList(one.getSeq());
		  Iterator memo = null;
		  if (memoList != null) {
		    memo = memoList.iterator();
		    while (memo.hasNext()) {
		      MemoBean mb = (MemoBean)memo.next();
		%><li class="group">
			<%= mb.getWriter() %> | <%= mb.getWhen("yyyy-MM-dd HH:mm:ss")%>
		</li>
		<li>
		<okbbs:link>
		<okbbs:html br="true"><%= mb.getBcomment() %></okbbs:html>
		</okbbs:link>
		
		</li>
		<%
		    } // end while
		  }
		%>
		<li class="panel" align="center">
<% if (member.getSid() != 0) { %>
			<!-- target="_self" 지정해서 한글깨짐 수정_piki -->
			<form name="f0" method="POST" onSubmit="return chk_memo(this)" action="/jsp/memo">
			    <input type="hidden" name="pact" value="MEMO">
			    <input type="hidden" name="seq" value="<%= one.getSeq() %>">
			    <input type="hidden" name="pg" value="<%= list.getPg() %>">
			    <input type="hidden" name="keyfield" value="<%=  CommonUtil.nchk(request.getParameter("keyfield"),"content")  %>">
			    <input type="hidden" name="keyword" value="<%=  CommonUtil.nchk(request.getParameter("keyword"))  %>">
			    <input type="hidden" name="bbs" value="<%= one.getBbs() %>">
			    <input type="hidden" name="viewstamp" value="<%= System.currentTimeMillis() %>">
			    <input type="hidden" name="doublecheck" class="memodc" value="okjsp">
			    <input type="hidden" name="sid" value="<%= member.getSid() %>">
			    <input type="hidden" name="okid" value="<%= member.getId() %>">
			    <input type="hidden" name="writer" value="<%= member.getId() %>">
		    	<textarea name="bcomment" id="bcomment" style="font-size:20px;font-family:Arial;width:97%"></textarea>
		    	- ID : <input type="text" 		class="memoid" name="memoid" value="<%= member.getId() %>" style="width:100px">
		    	&nbsp;&nbsp;
		    	- PW : <input type="password" 	class="memopass" name="memopass" maxlength="50" value="" style="width:100px">
		        <a class="whiteButton" type="submit" href="#" target="_self">댓글전송</a><br/>
		    </form>
<% } else { %>
			<font color="blue">※ 댓글을 남기시려면 Login 하세요</font>
<% } %>
		</li>
	</ul>
	
	<!-- ################ 삭제 폼_시작 ##################### -->
	<form id="deleteForm" class="dialog" action="/deletemobile" method="post" target="_self">
		<input type="hidden" name="seq" value="<%= one.getSeq() %>">
		<input type="hidden" name="bbs" value="<%= one.getBbs() %>">
	    <fieldset>
	        <h1>삭제암호입력</h1>
	        <!-- 버튼에  href="#"를 넣어주지 않으면 동작하지 않는다 -->
	        <a class="button leftButton" type="cancel" href="#">Cancel</a>
	        <a class="button blueButton" type="submit" href="#">Delete</a>
	        <label>암호:</label>
	        <input id="password" type="password" name="password" maxlength="15"/>
	    </fieldset>
	</form>
	<!-- ################ 삭제 폼_끝 ##################### -->
