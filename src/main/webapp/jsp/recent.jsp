<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ page errorPage="/jsp/error.jsp"
    import="kr.pe.okjsp.*,
    	    kr.pe.okjsp.util.CommonUtil,
    	    kr.pe.okjsp.util.DateLabel,
            java.util.*,
            java.util.Iterator"
    pageEncoding="euc-kr"
%><%@ taglib uri="/WEB-INF/tld/taglibs-string.tld" prefix="str"
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <title>NEW OKJSP with CUBRID</title>
	<script type="text/javascript" src="/js/jquery/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.timeago.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.timeago.ko.js" charset="utf-8"></script>
    <script type="text/javascript" src="/js/okjsp.js"></script>
    <script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
    <LINK rel="STYLESHEET" type="TEXT/CSS" HREF="/css/okjsp2007.css.jsp">

</head>

<body class="body" style="margin:0">
<jsp:include page="/top.jsp" />
<jsp:include page="/menu.jsp" />
<table class="mainTable">
  <tr>
    <td>
<ul id="banner_top">
<li>
<script type="text/javascript">
Banner.show();
</script>
</li>
</ul>

<div id="bookList">
<h1># OKJSP 추천 도서</h1>
<ul>
<li>
<a href="/f.jsp?http://ji-n-son.co.kr/?bookinfo=%EA%B1%B0%EC%B9%A8%EC%97%86%EC%9D%B4-%EB%B0%B0%EC%9A%B0%EB%8A%94-%EB%9D%BC%EC%A6%88%EB%B2%A0%EB%A6%AC-%ED%8C%8C%EC%9D%B4" target="_blank">
<img style="width: 160px" src="http://ji-n-son.co.kr/wp/wp-content/uploads/2013/03/%EC%98%88%ED%8C%90%EC%9D%B4%EB%AF%B8%EC%A7%80_%ED%99%88%ED%8E%98%EC%9D%B4%EC%A7%80%EC%9A%A9-1024x849.jpg" class="cover">
</a>
<h2>
<a href="/f.jsp?http://ji-n-son.co.kr/?bookinfo=%EA%B1%B0%EC%B9%A8%EC%97%86%EC%9D%B4-%EB%B0%B0%EC%9A%B0%EB%8A%94-%EB%9D%BC%EC%A6%88%EB%B2%A0%EB%A6%AC-%ED%8C%8C%EC%9D%B4" target="_blank">
거침없이 배우는 라즈베리 파이</a></h2>
<p style="padding-bottom: 0">
<a href="/f.jsp?http://ji-n-son.co.kr/?bookinfo=%EA%B1%B0%EC%B9%A8%EC%97%86%EC%9D%B4-%EB%B0%B0%EC%9A%B0%EB%8A%94-%EB%9D%BC%EC%A6%88%EB%B2%A0%EB%A6%AC-%ED%8C%8C%EC%9D%B4" target="_blank">
라즈베리 파이의 공동 개발자인 에벤 업튼이 직접 저술한 책!
<br />
신용카드 크기만한 초소형 컴퓨터 라즈베리 파이의 활용과 임베디드 프로그래밍 입문을 위한 필수 지침서!
</a>
</p>
<p style="text-align: right">
에벤 업튼, 가레스 할퍼크리 공저/유하영, 전우영 공역
<br />
예약 판매중 3월 5일 ~ 3월 27일
</p>
</li>
<li style="display: none;">
<a href="/f.jsp?http://ji-n-son.co.kr/?post_type=bookinfo&p=2855" target="_blank">
<img src="/upload/1362046827360.jpg" class="cover">
</a>
<h2>
<a href="/f.jsp?http://ji-n-son.co.kr/?post_type=bookinfo&p=2855" target="_blank">
개발자의 코드 The Developer's Code</a></h2>
<p>
<a href="/f.jsp?http://ji-n-son.co.kr/?post_type=bookinfo&p=2855" target="_blank">
What Real Programmers Do!!!
<br>
당신은 이미 훌륭한 코더이다.
하지만 어려운 프로젝트를 통해 얻는 뛰어난 코딩 작업들은 언제나 충분하지 못하다.
당신에게 필요한 50여 개의 지혜가 이 책에 담겨 있다.
이 책은 베테랑 프로그래머에게는 웹 애플리케이션 개발에 대한 열정에 새로운 활기를 불어넣어 줄 것이며, 
이제 막 프로그래머의 길에 들어선 초심자에게도 좋은 지침이 될 것이다.
이 책을 통해 새롭고 현명한 방법으로 자신의 업무를 다시 생각하라.</a></p>
</li>
</ul>
</div>

<div id="newsfeed">
<script type="text/javascript">
var newsList = [
    {
    	'feedURL': 'http://feeds.feedburner.com/skpreadme',
    	'titleImgSrc': 'http://readme.skplanet.co.kr/wp-content/themes/blaskan/img/logo30.png',
    	'startedAt': '2013-02-04' 
    },
    {
    	'feedURL': 'http://feeds.feedburner.com/newsmate/McKa',
    	'titleImgSrc': '/images/newsmate_logo.png',
    	'startedAt': '2012-11-28' 
    }    
];
var newsIdx = Math.floor(Math.random() * newsList.length);
var feedURL = newsList[newsIdx].feedURL;
var ajaxURL = "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=5&q=" + feedURL;
$.ajax({
	url: ajaxURL,
	dataType: 'jsonp',
	jsonp: 'callback',
	success: function(d) {
		var feed = d.responseData.feed;
		var list = feed.entries;
		
		var logo = $('<img>').attr('src', newsList[newsIdx].titleImgSrc);
		var title = $('<a>').attr('href', feed.link).
		attr('target', '_blank').append(logo);
		var li = $('<li>').append(title).addClass('th');

		$('#newsfeedList').append(li);

		for(var i in list) {
			var record = $('<a>').html(list[i].title + ' (' + $.timeago(Date.parse(list[i].publishedDate)) +')')
			.attr('href', list[i].link)
			.attr('target', '_blank');
			var li = $('<li>').append(record)
			$('#newsfeedList').append(li);
		}
		$('#newsfeedList').addClass('tablestyle').fadeIn('slow');
		
	},
	failure: function(err) {
		window.console && console.log(err);
	},
	complete: function(d) {
		window.console && console.log('complete ' + JSON.stringify(d));
	}
});
</script>

<ul id='newsfeedList'>
</ul>
</div>
<table>
  <tr>
    <td align="center" valign="top">

<!-- 최신 글 리스트 -->
<%
	long sTime=System.currentTimeMillis();
	Iterator iterList = null;
	Article one = null;
%>
<table class="tablestyle">
<%
	ArrayList arrayList = new ArrayList();
	arrayList.add("notice|공지사항");

	Iterator iter = arrayList.iterator();
	String [] rec = null;

	while(iter.hasNext()) {
	    rec = ((String)iter.next()).split("\\|");
%>
<tr>
    <td colspan="6" class="th">
<a href="/bbs?act=LIST&bbs=<%= rec[0] %>">
<b><%= rec[1] %></b>
</a>
    </td>
</tr>
<%

	iterList = getCachedList(rec[0]);
	while (iterList.hasNext()) {
	    one = (Article) iterList.next();
    %>
    <tr align="center">
        <td class="ref tiny"><%= one.getRef() %></td>
        <td class="subject"><div>
            <a href="/seq/<%= one.getSeq() %>">
            <%= CommonUtil.rplc(one.getSubject(), "<", "&lt;") %>
            </a>
        <span class="tiny"><str:replace replace="[0]" with="">[<%= one.getMemo() %>]</str:replace></span>
        </div>
        </td>
        <td class="writer"><div><%= CommonUtil.rplc(one.getWriter(), "<", "&lt;") %></div></td>
        <td class="id"><div><img src="/profile/<%= one.getId() %>.jpg"
	        	alt="<%= one.getId() %>"
	        	style="width:14px;height:14px"></div></td>
	    <td class="read tiny"><%= one.getRead() %></td>
        <td class="when tiny" title="<%= one.getWhen() %>">
        <%= DateLabel.getTimeDiffLabel(one.getWhen()) %></td>
    </tr>
<% } %>
<!--<%= System.currentTimeMillis()-sTime %>-->
<%
} // end of while iter();
%>
<tr>
    <td colspan="6" class="th">
<b>전체 게시판</b>
    </td>
</tr>
<%
	ArticleDao articleDao = new ArticleDao();
	int [] seqs = articleDao.getAdList();
	for(int seq : seqs) {
		Article article = articleDao.getArticle(seq);
		if (article.getSeq() == 0) {
			continue;
		}
%>
    <tr class="body" align="center" style="height:32px">
        <td class="ref tiny" style="width: 40px; font-weight: bold;">Sponsored</td>
        <td class="subject" style="text-align: left">
            <a href="/f.jsp?/seq/<%= article.getSeq() %>" style="font-weight:bold"><%= article.getSubject() %></a>
        </td>
        <td class="writer"><div><b><%= article.getWriter() %></b></div></td>
        <td class="writer"><img src="/profile/<%= article.getId() %>.jpg" style="width: 14px; height: 14px;" alt="<%= article.getWriter() %>"/></td>
        <td class="read tiny"><b><%= article.getRead() %></b></td>
        <td class="when tiny" title="<%= article.getWhen("yyyy-MM-dd HH:mm:ss") %>">
        <b><%= DateLabel.getTimeDiffLabel(article.getWhen()) %></b></td>
    </tr>
<%
	} // end for
	HashMap bbsInfoMap = (HashMap)application.getAttribute("bbsInfoMap");
	iterList = list.getAllRecentList(108).iterator();
	int i = 0;
	while (iterList.hasNext() && i < 40) {

	    one = (Article) iterList.next();
	    BbsInfoBean bbsInfo = ((BbsInfoBean)(bbsInfoMap.get(one.getBbs())));
	    if (bbsInfo == null) {
	    	bbsInfo = new BbsInfoBean();
	    }
    	
	    // 모바일웹 프로젝트 진행중에는 테스트 데이타인
    	// twitter 와 null 은 보여지지 않습니다.
    	if (bbsInfo.getCseq() == null || "".equals(bbsInfo.getCseq()) 
    	|| "twitter".equals(bbsInfo.getBbs()) || "trash".equals(bbsInfo.getBbs())) {
    		continue;
    	}
    	
	    if ("2".equals(bbsInfo.getCseq())) {
	    	continue;
	    }
	    i++;
%>
    <tr align="center">
        <td><div class="recent_first">
        <a href="/bbs?act=LIST&bbs=<%= one.getBbs() %>">
        <%= bbsInfo.getName() %></a></div></td>
        <td class="subject"><div>
            <a href="/seq/<%= one.getSeq() %>">
            <%= CommonUtil.rplc(one.getSubject(), "<", "&lt;") %>
            </a>
        <span class="tiny">[<%= one.getMemo() %>]</span>
        </div>
        </td>
        <td class="writer"><div><%= CommonUtil.rplc(one.getWriter(), "<", "&lt;") %></div></td>
        <td class="id"><div><img src="/profile/<%= one.getId() %>.jpg"
        	alt="<%= one.getId() %>"
        	style="width:14px;height:14px"></div></td>
        <td class="read tiny"><%= one.getRead() %></td>
        <td class="when tiny" title="<%= one.getWhen() %>">
        <%= DateLabel.getTimeDiffLabel(one.getWhen()) %></td>
    </tr>
<%
	}
%></table>
    </td>
  </tr>
</table>

<div id="okevent" style="margin-left:3px">
<iframe src="https://www.google.com/calendar/embed?src=mavru91b8uc53stgqbso2pl668%40group.calendar.google.com&ctz=Asia/Seoul" style="border: 0" width="642" height="480" frameborder="0" scrolling="no"></iframe>
</div>
    </td>
  </tr>
</table>
<jsp:include page="/footer.jsp" />
<div id="sub_panel">
	<div id="ad_banners">
<script type="text/javascript">
Banner.showAside();
</script>
<script src="http://widgetprovider.daum.net/view?url=http://widgetcfs1.daum.net/xml/16/widget/2008/09/24/15/28/48d9de0cd3a6e.xml&up_Category=0&up_WidgetStyle=A&up_Username=kenu.heo%40gmail.com&up_HideStatus=false&up_HideBottom=false&up_HideDateLocation=false&&width=166&height=355&widgetId=122&scrap=1" type="text/javascript"></script>
	</div>
</div>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>
<%!
	ListHandler list = new ListHandler();
	Iterator getCachedList(String bbsid) {
		Iterator iter = null;
		try {
			iter = list.getRecentList(bbsid, 5).iterator();
		} catch(Exception e) {
			iter = new ArrayList().iterator();
		}
		return iter;
	}

%>
