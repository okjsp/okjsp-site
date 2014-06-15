<%@page import="java.util.*,kr.pe.okjsp.*,kr.pe.okjsp.util.*" %>
<style>
#cloud {width: 600px;margin-left:14px; padding:5px; text-align:center}
#cloud a div {display:inline; font-family:Verdana; margin:2 4}
</style>
<div id="cloud" style="background-color:#eed; border-bottom: 1 solid #ccc;">
<div style="text-align:left;font-weight:bold;">Tag Cloud</div>
<%
  TagHandler tagHandler = new TagHandler();
  ArrayList tags = tagHandler.getRecentTags(200);
  if (tags.size() > 0) {
	  for(int i = 0; i < tags.size(); i++) {
		  Tag tag = (Tag)tags.get(i);
		  int size = (tag.getCnt() * 10 + 80) ;
%><a href="/jsp/taglist.jsp?tagseq=<%= tag.getTagseq() %>"><font style="font-size:<%= size %>%"><%= CommonUtil.k2a(tag.getTag()).replaceAll("<","&lt;") %></font></a><%
	  }
  }
%>
</div>
