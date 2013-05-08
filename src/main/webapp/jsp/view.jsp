<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="kr.pe.okjsp.member.PointDao"%>
<%@page import="kr.pe.okjsp.util.HttpLinker"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ page import="java.util.*,kr.pe.okjsp.util.CommonUtil,kr.pe.okjsp.*"
	pageEncoding="euc-kr" %>
<%@page import="kr.pe.okjsp.member.Member"%>
<%@page import="kr.pe.okjsp.member.MemberHandler"%>
<jsp:useBean id="one"  class="kr.pe.okjsp.Article" scope="request"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler" />
<html>
<head>
    <META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">    
    <link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
    <title>OKJSP: <%= one.getSubject() %></title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script src='/js/ban.js'></script>
    <script src="/js/okjsp.js"></script>
    <script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
	<script src="/js/ajax.js"></script>
    <script src="/js/okboard_view.js"></script>
    <meta name="google-translate-customization" content="f3a40b0f1ed271cb-c894f26c0728d180-g81c25d2f6b172513-f"></meta>
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="/top.jsp" />
<jsp:include page="/menu.jsp" />
<table class="bbsTable">
  <tr>
    <td valign='top'>

<h1 id="bbstitle"><c:out value="${bbsInfoMap[one.bbs].name}" /></h1>
<div id="permlink"><a href="http://www.okjsp.net/seq/<%= one.getSeq() %>">
http://www.okjsp.net/seq/<%= one.getSeq() %></a></div>
<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
    <tr>
        <td class="td">
<%
    if (one.getId() != null) {
        %><img src="http://www.okjsp.net/profile/<%= one.getId() %>.jpg"
        	alt="<%= one.getId() %>"
        	style="width:77px"><%
    }
%>
<strong><c:out value="${one.writer}"/></strong>
<%
	Member member = (Member)session.getAttribute("member");
	if (member.getSid() == 0) {
		member.setSid(CommonUtil.getCookieLong(request, "sid"));
	}
	PointDao pointDao = new PointDao();

    if (member.getSid() > 0) {
%><sub>(<%= pointDao.getPoint(one.getSid()) %>)</sub>
<%
    }
%>
<div>
<%= one.getWhen("yyyy-MM-dd HH:mm:ss") %>
</div>
        </td>
    </tr>
    <tr>
        <td class="td">
<a href="<c:out value="${one.homepage}"/>" target="_blank"><c:out value="${one.homepage}"/></a>
        </td>
    </tr>
    <tr>
        <td class="td" class="wrap">
        <b><%= CommonUtil.showHtml(one.getSubject()) %></b>
        </td>
    </tr>
    <tr>
        <td class="td" class="wrap" height="80" valign="top">
<%-- 이미지 보이기 --%>
        <div id="centent" class="wrap">
<script type="text/javascript">
Banner.showContentRight();
</script>
<p><%= CommonUtil.rplc(one.getContentView(), "movieseq=", "")  %></p></div>
<%-- facebook like button --%>
<iframe src="http://www.facebook.com/plugins/like.php?href=http://www.okjsp.net/seq/<%= one.getSeq() %>"
        scrolling="no" frameborder="0"
        style="border:none; width:100%; height:60px"></iframe>

<%-- 하단 배너 --%>
<div style="margin:0 0 20px; width:100%;text-align:center;">
<script type="text/javascript">
Banner.showContentSection();
</script>
</div>

        <div>
<jsp:include flush="true" page="/ccl/licenses_skin.jsp">
	<jsp:param name="c" value="<%= one.getCcl_id() %>"/>
</jsp:include>
        </div>
        </td>
    </tr>
<%-- 다운로드 파일 목록 --%>
<%
  ArrayList fileList = (ArrayList) request.getAttribute("arrdf");
  if (fileList != null && !fileList.isEmpty()) {
%>
    <tr>
        <td class="td download">
        <img src="/images/file.png" alt="file">
<ul><%
    Iterator file = fileList.iterator();
    while (file.hasNext()) {
      DownFile df = (DownFile)file.next();
%><li><a href="/bbs?act=DOWN&maskname=<%= df.getMaskName() %>&fileName=<%= df.getFileName() %>"><%= df.getFileName() %>
 <%= df.getFileSize() %> Bytes (<%=df.getDownload()%>)</a></li><%
    } // end while
%>
</ul>
        </td>
    </tr>
<%
  }
%>
</table>

<div id="passwd_layer" style="position:absolute;display:none;width:220px;height:60px;padding:10px" align="center">
	<input type="password" id="passwd" name="passwd" maxlength="15">
	<br>
	<input type="button" id="submit_type" onclick="return submit_passwd()">
	<input type="button" value="취소" onclick="return toggleMenu('passwd_layer')">
</div>

<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
<tr>
    <td class="td.color">
        <input type="button" value="목록" onClick="goPage()"/>
        <input type="button" value="답변" onClick="goReply()"/>
        <input type="button" value="수정" onClick="show_passwd_layer('goModify')"/>
        <input type="button" value="삭제" onClick="show_passwd_layer('goDelete')"/>
        <input type="button" value="책갈피" onClick="goBookmark()"/>
<%
        if (request.getParameter("keyword") != null) {
%>
        <a href="javascript:clearKeyword()">
			검색어(<b><%=  CommonUtil.nchk(request.getParameter("keyword"))  %></b>)제거
		</a>
<%
        }
%>
    </td>
</tr>
<%
// 관리자 일 경우 게시물 이동권한을 갖는다. 
	boolean isAdmin = member != null && ("kenu".equals(member.getId()) 
			|| "okjsp".equals(member.getId())
			|| "kwamuki".equals(member.getId())
			|| "sbroh".equals(member.getId()));
	if (isAdmin) {
%>
<tr>
    <td class="td">
<form name="fmove" method="POST" onSubmit="return chk_memo(this)" style="margin:0px">
	<select name="newBbs">
<%
	Map map = (Map)application.getAttribute("bbsInfoMap");
	Object[] blist = map.keySet().toArray();
	Arrays.sort(blist);
	for (int i = 0; i < blist.length; i++) {
		Object bbsId = blist[i];
		BbsInfoBean bib = (BbsInfoBean)(map.get(bbsId));
%><option value="<%= bib.getBbs() %>"><%= bib.getBbs() + " | " + bib.getName() %></option>
<%
	} // end while
%>
	</select>
        <input type="hidden" name="pact" value="MOVE">
        <input type="hidden" name="oldBbs" value="<%= one.getBbs() %>">
        <input type="hidden" name="oldRef" value="<%= one.getRef() %>">
        <input type="hidden" name="seq" value="<%= one.getSeq() %>">
        <input type="hidden" name="ip" value="<%= request.getRemoteAddr() %>">
        <input type="hidden" name="writer" value="<c:out value="${member.id}"/>">
        <a href="javascript:movePage()"><b>이동</b></a>
</form>
    </td>
</tr>
<% 
	} // end if isAdmin
%>
</table>

<form name="f0" method="POST" onSubmit="return chk_memo(this)">
    <input type="hidden" name="pact" value="MEMO">
    <input type="hidden" name="seq" value="<%= one.getSeq() %>">
    <input type="hidden" name="pg" value="<%= list.getPg() %>">
    <input type="hidden" name="keyfield" value="<%=  CommonUtil.nchk(request.getParameter("keyfield"),"content")  %>">
    <input type="hidden" name="keyword" value="<%=  CommonUtil.nchk(request.getParameter("keyword"))  %>">
    <input type="hidden" name="bbs" value="<%= one.getBbs() %>">
    <input type="hidden" name="viewstamp" value="<%= System.currentTimeMillis() %>">
	<div id="layer_delpass" style="position:absolute;display:none;width:220px;height:60px;padding:10px" align="center">
		<input type="password" id="delpass" name="delpass" maxlength="15">
		<input type="hidden" name="mseq">
		<br>
		<input type="submit" value="삭제">
		<input type="button" value="취소"
		onclick="document.f0.mseq.value='';document.f0.delpass.value='';return toggleMenu('layer_delpass')">
	</div>
<div id="m" class="tablestyle">
<%
  ArrayList<MemoBean> memoList = new MemoHandler().getList(one.getSeq());
  Iterator memo = null;
  if (memoList != null) {
    memo = memoList.iterator();
    while (memo.hasNext()) {
      MemoBean mb = (MemoBean)memo.next();

%>
<a name="<%= mb.getMseq() %>"><!--()--></a>
<ul><li class="c">
<%= HttpLinker.getLinkedSource( CommonUtil.showHtml( mb.getBcomment() ) ) %>
</li>
<li class="w"><%
    if (mb.getId() != null) {
        %><img src="http://www.okjsp.net/profile/<%= mb.getSid() %>.jpg"
        	alt="<%= mb.getSid() %>"
        	style="width:36px;height:36px"><%
    }
%><%= mb.getWriter() %>
<%
    if (member.getSid() > 0) {
%><sub>(<%= pointDao.getPoint(mb.getSid()) %>)</sub>
<%
    }
%>
</li>
<li class="d"><%= mb.getWhen("yyyy-MM-dd HH:mm:ss")
%></li><li class="e"><a href="javascript:show_memodel('<%= mb.getMseq() %>')">x</a>
<%-- facebook like button --%>
<iframe src="http://www.facebook.com/plugins/like.php?href=http://www.okjsp.net/seq/<%= mb.getSeq()+"%23"+mb.getMseq() %>"
        scrolling="no" frameborder="0"
        style="border:none; width:100%; height:27px"></iframe>
</li></ul>
<%
    } // end while
  }
%>
</div>
<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
    <tr>
    <td colspan="2" width="100%" class="td" align="right">
<%
    if (member.getSid() > 0) {
%>
        <textarea name="bcomment" style="width:100%;height:80px"></textarea>
        id:<input type="text" class="memoid" name="writer"
            maxlength="50" value="<%= CommonUtil.a2k(CommonUtil.getCookie(request, "okwriter")) %>">
        pw:<input type="password" class="memopw" name="memopass" maxlength="15">
	    <input type="hidden" name="doublecheck" class="memodc" value="okjsp">
	    <br /><span style="color:#f00">IP 기록됩니다. 예민한 얘기는 올리지 않으시는 게 사이트 운영에 도움이 됩니다.
	    <br />개조심할 필요는 있으니까요. 낮말은 새, 밤말은 쥐, 인터넷말은 검색엔진</span>
        <br /><input type="submit" name="send" value="Memo">
<%
    } else {
%>
        <textarea name="bcomment" style="width:100%;height:80px" readonly="readonly" 
        onclick="document.location.href='<%= Navigation.getPath("LOGFORM") %>?returnPath='+document.location.href">로그인 후 메모글을 쓸 수 있습니다.</textarea>
<%
    }

%>
    </td>
    </tr>
</table>
</form>
<%-- next, group, prev --%>
<%
String link = "&bbs="+one.getBbs()+
                "&keyfield="+CommonUtil.nchk(request.getParameter("keyfield"), "content")+
                "&keyword="+java.net.URLEncoder.encode( CommonUtil.nchk(request.getParameter("keyword")), "8859_1");
%>
<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
    <c:if test="${!empty requestScope.nextSeq}">
    <tr>
        <td align="center" class="td">
            다음글
        </td>
        <td class="td" colspan="5">
            <a href="/seq/<c:out value="${requestScope.nextSeq}"/>">
            <c:out value="${requestScope.nextSubject}"/></a>
        </td>
    </tr>
    </c:if>
<%
java.util.Iterator iter = list.getRefList(one.getBbs() , one.getRef()).iterator();

int oldRef = -1;  // 그룹번호가 이전과 같을 경우 그룹번호 출력 안함
while (iter.hasNext()) {
    one = (Article) iter.next();
%>
    <tr class="<%= (one.getLev()==0)?"body":"reply" %>" align="center">
        <td>
<% 
        if ((""+one.getSeq()).equals(request.getParameter("seq"))) out.println(">>"); 

		if (oldRef!=one.getRef()) out.println(one.getRef());  
%>
        </td>
        <td align="left">
            <a href="/seq/<%= one.getSeq() %>">
            <%= CommonUtil.showHtml(one.getSubject()) %>&nbsp;
            </a>
        <span class="tiny">[<%= one.getMemo() %>]</span>
        <%-- Twitter 공식 트윗 버튼 --%>
<a href="//twitter.com/share" class="twitter-share-button"
	data-count="horizontal" data-via="okjsp"
	data-text="<%=CommonUtil.showHtml(one.getSubject())%>"> [Tweet]</a><script
	type="text/javascript" src="//platform.twitter.com/widgets.js"></script>
        
        </td>
        <td><%= one.getWriter(9) %></td>
        <td class="tiny"><%= one.getRead() %></td>
        <td class="tiny"><%= one.getWhen("yyyy-MM-dd HH:mm:ss") %></td>
    </tr>
<%
    oldRef = one.getRef();  // 그룹번호를 기억해 놓는다.
}
%>
    <c:if test="${!empty requestScope.prevSeq}">
    <tr>
        <td class="td" colspan="6">
        </td>
    </tr>
    <tr>
        <td align="center" class="td">
            이전글
        </td>
        <td class="td" colspan="5">
            <a href="/seq/<c:out value="${requestScope.prevSeq}"/>">
            <c:out value="${requestScope.prevSubject}"/></a>
        </td>
    </tr>
    </c:if>
</table>


<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
<tr>
    <td class="td.color">
        <input type="button" value="목록" onClick="goPage()"/>
        <input type="button" value="답변" onClick="goReply()"/>
        <input type="button" value="수정" onClick="show_passwd_layer('goModify')"/>
        <input type="button" value="삭제" onClick="show_passwd_layer('goDelete')"/>
        <input type="button" value="책갈피" onClick="goBookmark()"/>
        <c:if test="${!empty param.keyword}" >
        <a href="javascript:clearKeyword()">
			검색어(<b><%=  CommonUtil.nchk(request.getParameter("keyword"))  %></b>)제거
		</a>
        </c:if>
    </td>
</tr>
</table>

<!-- hidden navigation form -->
<form name="f1">
    <input type="hidden" name="act" value="LIST">
    <input type="hidden" name="bbs" value="<%= one.getBbs() %>">
    <input type="hidden" name="seq" value="<%= one.getSeq() %>">
    <input type="hidden" name="pg" value="<%= list.getPg() %>">
    <input type="hidden" name="keyfield" value="<c:out value="${param.keyfield}" default="content"/>">
    <input type="hidden" name="keyword" value="<%= CommonUtil.nchk(request.getParameter("keyword")) %>">
    <input type="hidden" name="pact" value="">
    <input type="hidden" name="password" value="">
</form>
    </td>
  </tr>
</table>
<jsp:include page="/footer.jsp" >
	<jsp:param name="bbs" value="<%= one.getBbs() %>"/>
</jsp:include>
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