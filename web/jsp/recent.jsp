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
    <script type="text/javascript" src="/js/okjsp.js"></script>
    <script type="text/javascript" src="/js/banner.js"></script>
    <script type="text/javascript" src="/js/bannerData.js"></script>
    <LINK rel="STYLESHEET" type="TEXT/CSS" HREF="/css/okjsp2007.css.jsp">
    <style type="text/css">
.recent_first {
overflow: hidden; width: 73px; height: 14px;
}</style>
</head>

<body class="body" style="margin:0">
<jsp:include page="/top.jsp" />
<table class="mainTable">
  <tr>
    <td width='120' valign='top'>
      <jsp:include page="/menu.jsp" />
    </td>
    <td valign='top'>
<ul id="banner_top">
<li>
<script type="text/javascript">
Banner.show();
</script>
</li>
</ul>

<table width="600" border="0" cellspacing="0">
  <tr>
    <td align="center" valign="top">
<div id="bookList">
<div style="float:none; margin: 6px 0 0;"><b># OKJSP 추천 도서</b></div>
<script type="text/javascript">
function showKangcomBook(kangcomCode) {
	// http://image3.kangcom.com/2009/03/l_pic/200903110001.jpg
	if (kangcomCode != null){
	var imageUrl = "http://image3.kangcom.com/" + kangcomCode.path
	    + "/b_pic/" + kangcomCode.code + '.' + kangcomCode.ext; 
  document.write('<div class="book">\
<a href="http://kangcom.com/common/bookinfo/bookinfo.asp?sku='+kangcomCode.code+'"\
title="'+kangcomCode.comment+'">\
<img src="'+imageUrl+'" class="bookimg">\
</a></div>');
	}
}
var kangcomList = [
 {code:'201106030004',path:'2011/02',ext:'jpg',comment:'[제대로 된 안드로이드 앱 개발을 위한] 안드로이드 프로그래밍'},
 {code:'201105270002',path:'2011/06',ext:'jpg',comment:'Blog2Book 자바 개발자와 시스템 운영자를 위한 트러블 슈팅 이야기'},
];

for (var i = 0; i < kangcomList.length && i < 6 ; i++) {
	showKangcomBook(kangcomList[i]);
}
	</script>
</div>
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
    <td colspan="5" class="th">
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
        <td class="id"><div><%
	    if (one.getId() != null) {
	        %><img src="/profile/<%= one.getId() %>.jpg"
	        	alt="<%= one.getId() %>"
	        	style="width:14px;height:14px"
	        	onerror="this.src='/images/spacer.gif'"><%
	    }
        	%></div></td>
        <td class="when tiny" title="<%= one.getWhen() %>">
        <%= DateLabel.getTimeDiffLabel(one.getWhen()) %></td>
    </tr>
<% } %>
<!--<%= System.currentTimeMillis()-sTime %>-->
<%
} // end of while iter();
%>
<tr>
    <td colspan="5" class="th">
<b>전체 게시판</b>
    </td>
</tr>
<tr align="center">
	<td><div class="recent_first">
		<a href="/seq/145985">사는 얘기</a></div>
	</td>
    <td class="subject">
    	<div>
	    	<a href="/seq/145985">[공지] 농협에 근무해봤던 분들께 부탁드립니다.</a>
        </div>
	</td>
	<td class="writer"><div>환자</div></td>
	<td class="id"></td>
	<td title="2009-12-25 09:12:28" class="when tiny">2년전</td>
    </tr><%
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
    	if (bbsInfo.getCseq() == null || "".equals(bbsInfo.getCseq()) || "twitter".equals(bbsInfo.getBbs())) {
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
        <td class="id"><div><%
    if (one.getId() != null) {
        %><img src="/profile/<%= one.getId() %>.jpg"
        	alt="<%= one.getId() %>"
        	style="width:14px;height:14px"
        	onerror="this.src='/images/spacer.gif'"><%
    }
        	%></div></td>
        <td class="when tiny" title="<%= one.getWhen() %>">
        <%= DateLabel.getTimeDiffLabel(one.getWhen()) %></td>
    </tr>
<%
	}
%></table>
    </td>
  </tr>
</table>

<jsp:include page="/footer.jsp" />
    </td>
  </tr>
</table>
<div id="sub_panel">
	<div id="ad_banners">
<script type="text/javascript">
Banner.showAside();
</script>
<p id="adinfo"><a href="/seq/163503">광고문의</a>
</p>
	</div>
	<div id="imaso_div">
	<script type="text/javascript"><!--
imaso_ad_client = "pub-31415924";
//-->
</script> 
<script type="text/javascript" src="http://widget.imaso.co.kr/pagead/show_ads.js"></script>
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