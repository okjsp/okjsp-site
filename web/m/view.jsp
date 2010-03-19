<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ page import="java.util.*,kr.pe.okjsp.util.CommonUtil,kr.pe.okjsp.*"
	pageEncoding="euc-kr" %>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:useBean id="one"  class="kr.pe.okjsp.Article" scope="request"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler" />
<html>
<head>
    <META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
	<!-- ################## IUI Header Start ##################  -->
	<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
	<link rel="apple-touch-icon" href="../../m/iui/iui-logo-touch-icon.png" />
	<meta name="apple-touch-fullscreen" content="YES" />
	<style type="text/css" media="screen">@import "../../m/iui/iui.css";</style>
	<script type="application/x-javascript" src="../../m/iui/iui.js"></script>
	<script src="/js/okboard_view.js"></script>
	<style type="text/css">
	body > ul > li {
	    font-size: 14px;
	}
	body > ul > li > a {
	    padding-left: 54px;
	    padding-right: 40px;
	    min-height: 34px;
	}
	li .digg-count {
	    display: block;
	    position: absolute;
	    margin: 0;
	    left: 6px;
	    top: 7px;
	    text-align: center;
	    font-size: 110%;
	    letter-spacing: -0.07em;
	    color: #93883F;
	    font-weight: bold;
	    text-decoration: none;
	    width: 36px;
	    height: 30px;
	    padding: 7px 0 0 0;
	    background: url(../../m/iui/shade-compact.gif) no-repeat;
	}
	h2 {
	    margin: 10px;
	    color: slateblue;
	}
	p {
	    margin: 10px;
	}
	</style>
	<!-- ################## IUI Header End ################## -->
    <title>OKJSP: <%= one.getSubject() %></title>
</head>
<body>
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
</body>
</html>