<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ page import="java.util.*,kr.pe.okjsp.util.CommonUtil,kr.pe.okjsp.*"
	pageEncoding="euc-kr" %>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:useBean id="one"  class="kr.pe.okjsp.Article" scope="request"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler" />
    
<div data-role="page">

	<div data-role="header" data-theme="b">
		<h1>OKJSP</h1>
	</div>

	<div data-role="content" role="main">
		<div class="ui-body ui-body-d">
	<%
	    if (!"".equals(one.getId())) {
	%>			
			<p class="bBorder1px">
				<img src="http://www.okjsp.pe.kr/profile/<%= one.getId() %>.jpg" alt="<%= one.getId() %>" style="float:left; width:35px; margin-right:10px;" onerror="this.src='/images/spacer.gif'">
	<%
	 	}
	%>
				<strong><%= CommonUtil.showHtml(one.getSubject()) %></strong><br/>
				<span class="b"><c:out value="${one.when}" /> by <c:out value="${one.writer}"/></span>				
			</p>
			<p>
		<%=one.getContentView()%>
			</p>
			<p>
		<%--	if(one.getId().equals(member.getId())) { --%>	
		    <!-- <a class="redButton" href="#deleteForm" onclick="document.getElementById('password').focus()">±€ ªË¡¶</a> -->			
		<%--	} --%>	
			</p>
		</div>										
	<%
	ArrayList<MemoBean> memoList = new MemoHandler().getList(one.getSeq());
	Iterator memo = null;
		if (memoList != null) {
			memo = memoList.iterator();
			while (memo.hasNext()) {
				MemoBean mb = (MemoBean)memo.next();
	%>
		<div class="ui-body ui-body-d tmargin10">	
			<p>
				<img src="http://www.okjsp.pe.kr/profile/<%= mb.getId() %>.jpg" alt="<%= mb.getId() %>" style="float:left; width:35px; margin-right:10px;" onerror="this.src='/images/spacer.gif'"/>
				<%= mb.getWriter() %><br/>
				<span class="grayAnd8pt"><%= mb.getWhen("yyyy-MM-dd HH:mm:ss")%></span>
			</p>				
			<p class="tBorder1px">
				<okbbs:link>
				<okbbs:html br="true"><%= mb.getBcomment() %></okbbs:html>
				</okbbs:link>
			</p>
		</div>				
	<%
			} // end while
		}
	%>				
	</div>
</div>