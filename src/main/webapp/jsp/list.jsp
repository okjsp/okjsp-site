<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page pageEncoding="utf-8"
    import="kr.pe.okjsp.util.CommonUtil, java.util.*,
            kr.pe.okjsp.Article,kr.pe.okjsp.util.DateLabel,
            kr.pe.okjsp.BbsInfoBean"%>
<% long stime = System.currentTimeMillis(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ taglib uri="/WEB-INF/tld/taglibs-string.tld" prefix="str" %>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />
<%
    response.setContentType("text/html;charset=euc-kr");

	Iterator iter = list.getList().iterator();
	Article one = null;
%>

<%@page import="kr.pe.okjsp.ArticleDao"%><html>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=utf-8">
<title>OKJSP <c:out value="${bbsInfoMap[list.bbs].name}" /> </title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script src="/js/okjsp.js"></script>
    <script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
    <script src='/js/okboard.js'></script>
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
<link rel="alternate" type="application/rss+xml" title="<c:out value="${bbsInfoMap[list.bbs].name}" />"
     href="http://www.okjsp.pe.kr/rss/okjsp-rss2.jsp?bbs=<%= list.getBbs() %>">
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="/top.jsp" />
<jsp:include page="/menu.jsp" />
<table class="bbsTable">
  <tr>
    <td valign='top'>
    <div style="font-size:10pt;font-weight:bold;margin:6px;padding:6px;">
      <c:out value="${requestScope.header}" escapeXml="false" /><br/>
      <c:out value="${bbsInfoMap[list.bbs].header}" escapeXml="false" />
    </div>
    <div class="tablestyle" style="font-size:10pt;font-weight:bold;padding:6px 0px">
<%
	Map map = (Map)application.getAttribute("bbsInfoMap");
	if (map != null) {
%>
<form name="navi" style="margin:0">
<select id="bbsids" onchange="jump()">
<jsp:include page="/jsp/option.jsp"></jsp:include>
</select>
[<c:out value="${list.cnt}" />]
</form>
<script type="text/javascript">
	document.getElementById("bbsids").value = "<%= request.getParameter("bbs") %>";
	function jump() {
		document.location.href='/bbs?act=LIST&bbs='+document.getElementById('bbsids').value;
	}
</script>
<%
	}
%>

    </div>
<!--<%= System.currentTimeMillis()-stime %>-->
<table class="tablestyle" border="0" cellpadding="3" cellspacing="1">
<%
	boolean isAdBBS = "recruit".equals(list.getBbs()) && list.getPg() < 1;
	if (isAdBBS) {
		ArticleDao articleDao = new ArticleDao();
		int [] seqs = articleDao.getAdList();
		for(int seq : seqs) {
			Article article = articleDao.getArticle(seq);
			if (article.getWhen() == null) continue;
%>
    <tr class="body" align="center" style="height: 32px;">
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
	} // end if 
String keyword = list.getKeyword();
String link = "&bbs="+request.getParameter("bbs")+
              "&keyfield="+CommonUtil.nchk(request.getParameter("keyfield"), "content")+
              "&keyword="+list.getKeyword();
int oldRef = -1;  // 그룹번호가 이전과 같을 경우 그룹번호 출력 안함

while (iter.hasNext()) {
    one = (Article) iter.next();
%>
    <tr class="<%= (one.getLev()==0)?"body":"reply" %>" align="center">
        <td class="ref tiny">
        <% if (oldRef!=one.getRef()) out.println(one.getRef()); %>
        </td>
        <td class="subject">
            <div>
            <a href="/seq/<%= one.getSeq() %>" >
            <okbbs:mark word='<%= keyword %>'>
<%= CommonUtil.showHtml(one.getSubject()) %>&nbsp;
            </okbbs:mark>
        <span class="tiny"><str:replace replace="[0]" with="">[<%= one.getMemo() %>]</str:replace></span>
            </a>
            </div>
        </td>
        <td class="writer"><div><%= one.getWriter() %> </div></td>
        <td class="writer"><%
    if (one.getId() != null) {
        %><img src="/profile/<%= one.getId() %>.jpg"
        	alt="<%= one.getId() %>"
        	style="width:14px;height:14px"><%
    }
        	%></td>
        <td class="read tiny"><%= one.getRead() %></td>
        <td class="when tiny" title="<%= one.getWhen("yy-MM-dd HH:mm") %>">
        <%= DateLabel.getTimeDiffLabel(one.getWhen()) %></td>
    </tr>
<%
    oldRef = one.getRef();  // 그룹번호를 기억해 놓는다.
}
%>
    <tr>
    <td colspan="7" class="td" align="center">
<%
link = "/bbs?act=LIST"+link;
request.setAttribute("total", ""+list.getCnt());
request.setAttribute("pageSize", ""+list.getPageSize());
%>
<okbbs:page link='<%= link %>'
            beginlabel="처음 "
            endlabel=" 끝"
            prevlabel="◀이전 "
            nextlabel=" 다음▶"
            pagegroupsize="10" />
    </td>
    </tr>
    <tr>
    <td colspan="7" class="td">
<form name="nav">

<select name="keyfield">
    <option value="subject">제목</option>
    <option value="content">내용</option>
    <option value="writer">작성자</option>
</select>

<input type="text" name="keyword" value="<%= list.getKeyword() %>">
<input type="submit" value="검색">
<input type="hidden" name="act"      value="LIST">
<input type="hidden" name="bbs"      value="<%= request.getParameter("bbs") %>">
<input type="hidden" name="seq">
</form>
<a href="javascript:write()">글쓰기</a>
<a href="/site2009/editor_jquery.jsp?bbs=<%= request.getParameter("bbs") %>">새로운 글쓰기</a>
(로그인 필요)
    </td>
    </tr>
</table>

<%
	// 다음 검색 mashup
	if ( keyword.length() > 0) {
%>
<div class="tablestyle searchDaum">
<jsp:include page="/mashup/daumSearch.jsp"></jsp:include>
</div>
<%
	}
	String bbs = request.getParameter("bbs");
%>
        </td>
    </tr>
</table>
<jsp:include page="/footer.jsp" >
	<jsp:param name="bbs" value="<%= bbs %>"/>
</jsp:include>
<script>
opt(document.nav.keyfield, '<c:out value="${param.keyfield}"/>');

function clearPage() {
    document.nav.act.value = "LIST";
    document.nav.pg.value = 0;
}

function write() {
    document.nav.act.value = "ADD";
    document.nav.submit();
}

function view(n) {
    document.nav.act.value = "VIEW";
    document.nav.seq.value = n;
    document.nav.submit();
}

</script>
<!--<%=System.currentTimeMillis()-stime %>-->
<div id="sub_panel">
	<div id="ad_banners">
<script type="text/javascript">
Banner.showAside();
</script>

<script type="text/javascript"><!--
google_ad_client = "ca-pub-8103607814406874";
/* okjspad_160x600 */
google_ad_slot = "6573675943";
google_ad_width = 160;
google_ad_height = 600;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>

<script src="http://widgetprovider.daum.net/view?url=http://widgetcfs1.daum.net/xml/16/widget/2008/09/24/15/28/48d9de0cd3a6e.xml&up_Category=0&up_WidgetStyle=A&up_Username=kenu.heo%40gmail.com&up_HideStatus=false&up_HideBottom=false&up_HideDateLocation=false&&width=166&height=355&widgetId=122&scrap=1" type="text/javascript"></script>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>