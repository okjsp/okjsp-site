<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ page import="java.util.*,kr.pe.okjsp.util.CommonUtil,kr.pe.okjsp.*"
	pageEncoding="euc-kr" %>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:useBean id="one"  class="kr.pe.okjsp.Article" scope="request"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler" />

	<ul id="detailView" >
		<li>
			<!-- ###########����################################# -->
			<h2><%= CommonUtil.showHtml(one.getSubject()) %></h2>
			<!-- ###########�̹����׻����id_����################################# -->
			<%
			    if (!"".equals(one.getId())) {
			%><img src="http://www.okjsp.pe.kr/profile/<%= one.getId() %>.jpg"
			        	alt="<%= one.getId() %>"
			        	style="width:77px"
			        	onerror="this.src='/images/spacer.gif'"><%
			    }
			%>
			<c:out value="${one.writer}"/> / <c:out value="${one.when}" />
			<!-- ###########�̹����׻����id_��################################# -->
			<!-- ###########������ư_�ۼ��ڿͷα��ξ��̵𰡵����Ҷ��� ����################################# -->
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
			<!-- ###########����################################# -->
			<%=  one.getContentView()  %>
		</li>
		<br/>
		<!-- ################  ��� ##################### -->
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
		<li align="center">
<% if (member.getSid() != 0) { %>
			<!-- css ���� ���� ����, �ϵ��ڵ� �Ͽ����ϴ�.. Sorry.. by jongkwang -->
			<form 
				name="f0" 
				method="POST" 
				onSubmit="return chk_memo(this)" 
				action="/memowritemobile"
				style=" box-sizing: border-box;-moz-box-sizing: border-box;-webkit-box-sizing: border-box;padding: 10px;background: #c8c8c8 url(/m/iui/pinstripes.png);">
		        <fieldset style="position: relative;margin: 0 0 20px 0;padding: 0;background: #FFFFFF;-webkit-border-radius: 10px;-moz-border-radius: 10px;border: 1px solid #999999;text-align: right;font-size: 16px;">
		            <div style="position: relative;min-height: 42px;border-bottom: 1px solid #999999;-webkit-border-radius: 0;text-align: center">
                		<textarea name="bcomment" id="bcomment" style="border: none;font-size:20px;font-family:Arial;width:95%"></textarea>
            		</div>
		            <div style="position: relative;min-height: 42px;border-bottom: 1px solid #999999;-webkit-border-radius: 0;text-align: center;vertical-align: middle;">
                		<label>ID : </label>
                		<input type="text" 		class="memoid" name="memoid" value="<%= member.getId() %>" style="width:100px">
                		<label>PW : </label>
                		<input type="password" 	class="memopass" name="memopass" maxlength="50" value="" style="width:100px">
            		</div>
        		</fieldset>
		        <a class="whiteButton" type="submit" href="#" target="_self">�������</a><br/>
		        
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
		    </form>
<% } else { %>
			<font color="blue">�� ����� ����÷��� Login �ϼ���</font>
<% } %>
		</li>
	</ul>
	
	<!-- ################ ���� ��_���� ##################### -->
	<form id="deleteForm" class="dialog" action="/deletemobile" method="post" target="_self">
		<input type="hidden" name="seq" value="<%= one.getSeq() %>">
		<input type="hidden" name="bbs" value="<%= one.getBbs() %>">
	    <fieldset>
	        <h1>������ȣ�Է�</h1>
	        <!-- ��ư��  href="#"�� �־����� ������ �������� �ʴ´� -->
	        <a class="button leftButton" type="cancel" href="#">Cancel</a>
	        <a class="button blueButton" type="submit" href="#">Delete</a>
	        <label>��ȣ:</label>
	        <input id="password" type="password" name="password" maxlength="15"/>
	    </fieldset>
	</form>
	<!-- ################ ���� ��_�� ##################### -->