<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<%@ page import="java.util.ArrayList, java.util.Iterator,
kr.pe.okjsp.Bookmark"
pageEncoding="euc-kr"
%><html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=EUC-KR">
    <title>OKJSP Bookmark</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script src="/js/okjsp.js"></script>
    <script src="/js/banner.js"></script>
    <script src="/js/okboard.js"></script>
    <script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
</head>
<body class="body" style="margin:0">
<jsp:include page="/top.jsp" />
<table class="tablestyle, body" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign='top'>
      <jsp:include page="/menu.jsp" />
    </td>
    <td valign='top'>
    <h2>책갈피 목록</h2>
<ul>
<%
ArrayList list = (ArrayList)request.getAttribute("bookmark");
Iterator iter = list.iterator();

java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yy/MM/dd HH:mm");
while (iter.hasNext()) {
	Bookmark b = (Bookmark)iter.next();
	int seq = b.getSeq();
	String subject = CommonUtil.rplc(b.getSubject(), "<", "&lt;");
%>
<li>
<a href="/seq/<%= seq %>"><%= subject %>
[<%= sdf.format(b.getCredate()) %> checked]</a>
<a style="cursor:pointer" onclick="deleteBookmark(<%= seq %>)" title="delete">x</a>
</li>
<%
}  // end while
%>
</ul>
<form name="bform" method="post">
<input type="hidden" name="pact" value="BOOKMARKDEL">
<input type="hidden" name="seq">
</form>
<script>
function deleteBookmark(n) {
    fobj = document.bform;
    fobj.seq.value = n;
    fobj.submit();
}
</script>
        </td>
    </tr>
</table>
<%@ include file="/footer.jsp" %>
<div id="sub_panel">
	<div id="ad_banners">
<script type="text/javascript">
Banner.showAside();
</script>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>