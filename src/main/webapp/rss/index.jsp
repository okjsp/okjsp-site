<%@ page pageEncoding="utf-8" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>NEW OKJSP 2015</title>
	<meta HTTP-EQUIV="Content-type" CONTENT="text/html;charset=utf-8">
    <link rel="STYLESHEET" type="TEXT/CSS" HREF="/css/skin.css">
	<script type="text/javascript" src="/js/jquery/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.timeago.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.timeago.ko.js" charset="utf-8"></script>
    <script type="text/javascript" src="/js/okjsp.js"></script>
    <script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
</head>
<body class="body" style="margin:0">
<jsp:include page="/top.jsp" />
<jsp:include page="/menu.jsp" />
<table class="mainTable">
  <tr>
    <td>

<h3>OKJSP RSS</h3>
<table class="tablestyle" id="tech">
	<colgroup>
		<col width="60%" />
		<col width="40%" />
	</colgroup>
    <tr><td>JSP Tips</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=bbs4">XML</a></td>
    </tr>
    <tr><td>JSP Q&amp;A</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=bbs3">XML</a></td>
    </tr>
    <tr><td>DB Tips</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=bbs2">XML</a></td>
    </tr>
    <tr><td>DB Q&amp;A</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=bbs1">XML</a></td>
    </tr>
    <tr><td>개발툴 Tips</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=TOOL">XML</a></td>
    </tr>
    <tr><td>개발툴 Q&amp;A</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=TOOLqna">XML</a></td>
    </tr>
    <tr><td>JavaScript Tips</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=ajax">XML</a></td>
    </tr>
    <tr><td>JavaScript Q&amp;A</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=ajaxqna">XML</a></td>
    </tr>
    <tr><td>안드로이드</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=android">XML</a></td>
    </tr>
    <tr><td>HTML5</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=html5">XML</a></td>
    </tr>
    <tr><td>전자정부 표준프레임워크</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=egov">XML</a></td>
    </tr>
</table>
<table class="tablestyle" id="life">
	<colgroup>
		<col width="60%" />
		<col width="40%" />
	</colgroup>
    <tr><td>사는 얘기</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=bbs6">XML</a></td>
    </tr>
    <tr><td>머리식히는 곳</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=bbs5">XML</a></td>
    </tr>
    <tr><td>얼마면돼</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=howmuch">XML</a></td>
    </tr>
    <tr><td>토론/기타Q&amp;A</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=lifeqna">XML</a></td>
    </tr>
    <tr><td>구직</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=getjob">XML</a></td>
    </tr>
    <tr><td>구인</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=recruit">XML</a></td>
    </tr>
    <tr><td>홍보</td>
        <td><a href="/rss/okjsp-rss2.jsp?bbs=pr">XML</a></td>
    </tr>
</table>
</td></tr></table>
<jsp:include page="/footer.jsp" />

<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>