<%@page import="java.util.ArrayList"%>
<%@ page errorPage="/jsp/error.jsp"
    import="kr.pe.okjsp.*,
    	    kr.pe.okjsp.util.CommonUtil,
            java.util.Iterator"
    pageEncoding="euc-kr"
%><%@ taglib uri="/WEB-INF/tld/taglibs-string.tld" prefix="str"
%>
<style type="text/css">
@import url("/techtrend/techtrend.css");
</style>
<!-- techtrend -->
<div id="techtrend">
<h1><a id="techtrendtitle" href="/bbs?act=LIST&bbs=techtrend">TECH TREND</a></h1>
<a id="techtrendrss" href="/rss/okjsp-rss2.jsp?bbs=techtrend">
<img src="/techtrend/rss.gif"/></a>
<%

	Article one = null;
	String icon = null;
	String content = null;
	
	Iterator<Article> iterList = getCachedList("techtrend");
	while (iterList.hasNext()) {
		one = iterList.next();
		content = one.getContent();
		int idx = content.indexOf("---");
		if (idx == -1 ) {
			icon = "<img src=\"/images/techtrend/techtrend.png\">";
		} else {
			icon = content.substring(0, idx);
			content = content.substring(idx + 3);
		}
%><dl>
<dt class="th"><a href="/seq/<%= one.getSeq() %>"><%= one.getSubject() %></a></dt>
<dd class="icon"><%= icon %></dd>
<dd class="content"><%= CommonUtil.cropByte(
			CommonUtil.removeTag(content, "<"), 380, "...") %>
	<a href="/seq/<%= one.getSeq() %>" class="more">more...</a>
</dd>
<dd class="when"><%= one.getWhen("yyyy-MM-dd HH:mm:ss") %></dd>
</dl>
<%
	} // end of while iterList();
%>
<dl>
<dt>
</dt>
</dl>
</div>
<%!
	ListHandler list = new ListHandler();
	Iterator<Article> getCachedList(String bbsid) {
		Iterator<Article> iter = null;
		try {
			iter = list.getRecentList(bbsid, 10).iterator();
		} catch(Exception e) {
			iter = new ArrayList<Article>().iterator();
		}
		return iter;
	}

%>