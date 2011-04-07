<%@ page pageEncoding="euc-kr"
    import="kr.pe.okjsp.util.CommonUtil, java.util.Iterator,
            kr.pe.okjsp.Article,kr.pe.okjsp.util.DateLabel" %>
<%@ taglib uri="/WEB-INF/tld/taglibs-string.tld" prefix="str" %>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />
			
<%
			list.setPageSize(15);
			Iterator iter = list.getList().iterator();
			Article one = null;
			
			while (iter.hasNext()) {
			    one = (Article) iter.next();
%>		 
			
			<li data-theme="c">
				<a href="/bbs?seq=<%= one.getSeq() %>&viewMode=JQM" target="JQM"><%= CommonUtil.showHtml(one.getSubject()) %> <str:replace replace="[0]" with=""><span class="ui-li-count"><%= one.getMemo() %></span></str:replace></a>
			</li>
<%
			} // end ifwhile
			
			int total = list.getCnt();
			int pageSize = list.getPageSize();
			int pageTotal = (total-1) / pageSize;
			boolean hasMorePage = list.getPg() < pageTotal;

			if (hasMorePage) {	// Next Page 가 없으면 Page 버튼 숨긴다.
%>
			<li class="li_btn_hasmore" data-theme="c">
				<a href="#" target="JQM" bbs="<%=request.getParameter("bbs")%>" rel="/bbs?act=JQMLISTDETAIL&bbs=<%=request.getParameter("bbs")%>&pg=<%= list.getPg() + 1 %>" id="btn_hasmore">Load More.</a>
			</li>
<% 
			} // end if
%>
