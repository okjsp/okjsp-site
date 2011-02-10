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
    <!-- Dependencies --> 
	<script src="http://yui.yahooapis.com/2.7.0/build/yahoo-dom-event/yahoo-dom-event.js" type="text/javascript"></script> 
 
	<!-- Source file --> 
	<script src="http://yui.yahooapis.com/2.7.0/build/animation/animation-min.js" type="text/javascript"></script> 
    <LINK rel="STYLESHEET" type="TEXT/CSS" HREF="/css/okjsp2007.css.jsp">
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
 {code:'201010040001',path:'2010/09',ext:'jpg',comment:'아이폰 이전과 이후 변한 모바일 플랫폼에 대한 명쾌한 설명, 기획,개발,디자이너 모두 강추입니다.'},
 {code:'2010F1446912',path:'2010/08',ext:'jpg',comment:'남들 다 안드로이드 갈 때가 기회입니다. 스프링의 진정한 경험담이 담겨있습니다. 강추!!!'},
 {code:'201006080010',path:'2010/06',ext:'jpg',comment:'TDD 적용에 관한 한국적인 이야기들입니다.'},
 {code:'201004050002',path:'2010/04',ext:'jpg',comment:'기초부터 2D와 3D 그래픽, 애니메이션, 게임 프로그래밍까지 플래시/플렉스 액션스크립트의 모든 것'},
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
	<td><div style="overflow: hidden; width: 73px; height: 12px;">
		<a href="/seq/28685">머리식히는곳</a></div>
	</td>
    <td class="subject">
    	<div>
	    	<a href="/seq/28685"><펌> 훌륭한프로그래머의딜레마</a>
        </div>
	</td>
	<td class="writer"><div>현성</div></td>
	<td class="id"></td>
	<td title="2003" class="when tiny">2003</td>
    </tr><%
	HashMap bbsInfoMap = (HashMap)application.getAttribute("bbsInfoMap");
	iterList = list.getAllRecentList(48).iterator();
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
        <td><div style="width:73px;height:12px;overflow:hidden">
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
		<ul>
		<li>
		<a href="/f.jsp?http://olccenter.or.kr/" target="_blank"
		><img src="/images/banner/olc_134x60.gif"
			alt="개방형 소프트웨어 교육센터, 동영상 교육"
		></a>
		</li>
		<li>
		<a href="/f.jsp?http://www.apptalk.tv" target="_blank"
		><img src="/images/banner/apptalk_134x60.jpg"
			alt="세상의 모든 앱을 영상으로. 앱의 모든 것, 앱톡"
		></a>
		</li>
		</ul>
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