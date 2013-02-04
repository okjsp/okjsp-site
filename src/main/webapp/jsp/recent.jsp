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
<div style="float:none; margin: 6px 0 0;"><b># OKJSP 추천 도서</b></div>

<script type="text/javascript">
/* okjsp-site */
aladdin_ttb_key = 'ttbkenu1710002';
aladdin_ttb_channel = '32572';
aladdin_ttb_width = '505';
aladdin_ttb_height = '183';
</script>
<script type="text/javascript" language="javascript" src="http://ttb2.aladin.co.kr/ad_ttb.aspx"></script>
</div>

<div id="newsmate">
<script type="text/javascript">
var feedURL = "http://feeds.feedburner.com/skpreadme";
var ajaxURL = "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=5&q=" + feedURL;
$.ajax({
	url: ajaxURL,
	dataType: 'jsonp',
	jsonp: 'callback',
	success: function(d) {
		var feed = d.responseData.feed;
		var list = feed.entries;
		
		var logo = $('<img>').attr('src', 'http://readme.skplanet.co.kr/wp-content/themes/blaskan/img/logo30.png');
		var title = $('<a>').attr('href', feed.link).
		attr('target', '_blank').append(logo);
		var li = $('<li>').append(title).addClass('th');

		$('#newsmateList').append(li);

		for(var i in list) {
			var record = $('<a>').html(list[i].title + ' (' + $.timeago(Date.parse(list[i].publishedDate)) +')')
			.attr('href', list[i].link)
			.attr('target', '_blank');
			var li = $('<li>').append(record)
			$('#newsmateList').append(li);
		}
		$('#newsmateList').addClass('tablestyle').fadeIn('slow');
		
	},
	failure: function(err) {
		console.log(err);
	},
	complete: function(d) {
		console.log('complete ' + d);
	}
});
</script>

<ul id='newsmateList'>
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
        <td class="ref tiny" style="width: 40px; font-weight: bold;">AD</td>
        <td class="subject" style="text-align: left">
            <a href="/seq/<%= article.getSeq() %>" style="font-weight:bold"><%= article.getSubject() %></a>
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
