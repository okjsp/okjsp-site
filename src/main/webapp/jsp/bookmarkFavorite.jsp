<%@ page import="kr.pe.okjsp.util.CommonUtil"
	pageEncoding="euc-kr" %>
<jsp:useBean id="b" class="kr.pe.okjsp.BookmarkHandler"/>
<jsp:useBean id="one" class="kr.pe.okjsp.BookmarkExtension"/>
<LINK href="/css/bookmark.css" title="bookmark usage" rel="stylesheet" type="text/css" charset="UTF-8" media="screen">
<br/>
<h5 class="bmtitle">����Ʈ å����</h5>
<table class="bmfav">
<%
java.util.Iterator iter = b.getFavoriteList(8).iterator();
while (iter.hasNext()) {
	one = (kr.pe.okjsp.BookmarkExtension)iter.next();
%><tr><td><div class="bmfav_subj"><a href="/seq/<%= one.getSeq() %>"><%= one.getSubject() %></a></div></td>
  <td><div class="bmfav_cnt"><%= one.getCount() %></div></td>
  <td><div class="bmfav_id"><%= one.getWriter() %></div></td>
</tr><%
}
%>
</table>
<h5 class="bmtitle">���������� å����</h5>
<table class="bmrct">
<%
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yy/MM/dd HH:mm");
iter = b.getRecentList(8).iterator();
while (iter.hasNext()) {
	one = (kr.pe.okjsp.BookmarkExtension)iter.next();
%><tr><td><div class="bmrct_subj"><a href="/seq/<%= one.getSeq() %>"
		title="<%= sdf.format(one.getCredate()) %> å���� ��"><%= one.getSubject() %></a></div></td>
	<td><div class="bmrct_id"><%= one.getWriter() %></div></td>
</tr><%
}
%></table>