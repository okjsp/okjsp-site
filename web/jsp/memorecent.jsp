<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page pageEncoding="utf-8"
	errorPage="error.jsp"
	import="java.util.*,kr.pe.okjsp.*,
	kr.pe.okjsp.util.CommonUtil,
	kr.pe.okjsp.util.DateLabel" %>
<jsp:useBean id="handler" class="kr.pe.okjsp.MemoHandler"></jsp:useBean>
<%
	int mp = Integer.parseInt(CommonUtil.nchk(request.getParameter("mp"), "0"));
	ArrayList<MemoBean> recent = handler.getRecent(mp);	
%>
<html>
<title>okjsp</title>
    <script src="/js/okjsp.js"></script>
    <script src="/js/banner.js"></script>
    <script src="/js/bannerData.js"></script>
    <script src='/js/okboard.js'></script>
	<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
	<link rel="stylesheet" href="/site2009/okjsp2009.css" type="text/css">
</head>
<body class="body" style="margin:0">
<jsp:include page="/top.jsp" />
<table class="bbsTable">
  <tr>
    <td width='120px' valign='top'>
      <jsp:include page="/menu.jsp" />
    </td>
    <td valign='top'>

<ul id="memorecent">
<%
	for (MemoBean memo: recent) {
%><li>
<a href="/seq/<%= memo.getSeq()+"#"+memo.getMseq() %>">
<ul><li><img src="/profile/<%= memo.getSid() %>.jpg"></li>
<li><%= memo.getId() %></li>
<li><%= memo.getBcomment() %></li>
<li><%= memo.getWhen("yyyy-MM-dd HH:mm:ss") %></li>
</ul></a>
</li>
<%
	}
%>
</ul>
<div style="width:100%; text-align: center;">
<a href="/bbs?act=MEMORECENT">Top</a>
<a href="/bbs?act=MEMORECENT&amp;mp=<%= mp - 1 %>">Prev</a> |
<%= mp %> |
<a href="/bbs?act=MEMORECENT&amp;mp=<%= mp + 1 %>">Next</a>
<jsp:include page="/footer.jsp" />
</div>
        </td>
    </tr>
</table>

<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>
