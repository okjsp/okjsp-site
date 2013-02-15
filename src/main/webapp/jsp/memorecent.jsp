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
<title>OKJSP 새 메모</title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script src="/js/okjsp.js"></script>
    <script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
    <script src='/js/okboard.js'></script>
	<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
	<link rel="stylesheet" href="/site2009/okjsp2009.css" type="text/css">
    <meta name="google-translate-customization" content="f3a40b0f1ed271cb-c894f26c0728d180-g81c25d2f6b172513-f"></meta>
</head>
<body class="body" style="margin:0">
<jsp:include page="/top.jsp" />
<jsp:include page="/menu.jsp" />
<table class="bbsTable">
  <tr>
    <td valign='top'>

<ul id="memorecent">
<%
	for (MemoBean memo: recent) {
%><li>
<a href="/seq/<%= memo.getSeq()+"#"+memo.getMseq() %>">
<ul class="box"><li><img class="box" src="http://www.okjsp.pe.kr/profile/<%= memo.getSid() %>.jpg"></li>
<li class="writer"><%= memo.getWriter() %></li>
<li><%= memo.getWhen("yyyy-MM-dd HH:mm:ss") %></li>
<li class="memo"><%= CommonUtil.showHtml(memo.getBcomment()) %></li>
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
</div>
        </td>
    </tr>
</table>
<jsp:include page="/footer.jsp" />
<div id="sub_panel">
<div id="google_translate_element"></div><script type="text/javascript">
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'ko', includedLanguages: 'en,ja,zh-CN', layout: google.translate.TranslateElement.FloatPosition.TOP_RIGHT}, 'google_translate_element');
}
</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

	<div id="ad_banners">
<script type="text/javascript">
Banner.showAside();
</script>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>
