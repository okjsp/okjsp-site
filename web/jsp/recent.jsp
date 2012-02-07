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
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
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
		int [] seqs = {
		183691,183534,183154,183497};
		ArticleDao articleDao = new ArticleDao();
		for(int seq : seqs) {
			Article article = articleDao.getArticle(seq);
%>
    <tr class="body" align="center">
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

<jsp:include page="/footer.jsp" />
    </td>
  </tr>
</table>
<div id="sub_panel">
	<div id="ad_banners">
<script type="text/javascript">
Banner.showAside();
</script>
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