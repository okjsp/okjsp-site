<%---------------------------------------------------------------------------------------------------------    
  FileName    : recentDetail.jsp
  Author      : BLUEPOET
  Regdate     : 2010-03-19
  Lastdate 	  : 
  Description : OKJSP 최신글 상세페이지  
  ver         : 1.0
-----------------------------------------------------------------------------------------------------------%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, kr.pe.okjsp.*, kr.pe.okjsp.util.*, kr.pe.okjsp.Article" contentType='text/html;charset=euc-kr'%>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />
<html>
<head>

<!-- IUI Header Start -->
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<link rel="apple-touch-icon" href="../../m/iui/iui-logo-touch-icon.png" />
<meta name="apple-touch-fullscreen" content="YES" />
<style type="text/css" media="screen">@import "../../m/iui/iui.css";</style>
<script type="application/x-javascript" src="../../m/iui/iui.js"></script>
<style type="text/css">
body > ul > li {
    font-size: 14px;
}
body > ul > li > a {
    padding-left: 54px;
    padding-right: 40px;
    min-height: 34px;
}
li .digg-count {
    display: block;
    position: absolute;
    margin: 0;
    left: 6px;
    top: 7px;
    text-align: center;
    font-size: 110%;
    letter-spacing: -0.07em;
    color: #93883F;
    font-weight: bold;
    text-decoration: none;
    width: 36px;
    height: 30px;
    padding: 7px 0 0 0;
    background: url(../../m/iui/shade-compact.gif) no-repeat;
}
h2 {
    margin: 10px;
    color: slateblue;
}
p {
    margin: 10px;
}
</style>
<!-- IUI Header End -->

</head>
<body>
<ul title="최신글 보기" selected="true">
	<li>
		<div class="digg-count">1</div>
		<a href="/bbs?seq=28685&mobileView=Y"><펌> 훌륭한프로그래머의딜레마</a>
	</li>
<%
	Iterator iter = list.getAllRecentList(48).iterator();
	HashMap bbsInfoMap = (HashMap)application.getAttribute("bbsInfoMap");
	Article one = null;
	int i = 0;
	
	while (iter.hasNext() && i < 40) 
	{
	    one = (Article) iter.next();
	    BbsInfoBean bbsInfo = ((BbsInfoBean)(bbsInfoMap.get(one.getBbs())));
	    if (bbsInfo == null) {
	    	bbsInfo = new BbsInfoBean();
	    }
	    
	    if (bbsInfo.getCseq() == null || "".equals(bbsInfo.getCseq()) || "twitter".equals(bbsInfo.getBbs())) {
    		continue;
    	}
    	
	    if ("2".equals(bbsInfo.getCseq())) {
	    	continue;
	    }
	    
	%>
	        <li><!-- ############ IUI List ########### -->
	        	<!-- 번호 클릭하면 에러나는거 수정:a를 div로 변경 -->
	            <div class="digg-count"><%=(i+2)%></div>
	            <a href="/bbs?seq=<%= one.getSeq() %>&mobileView=Y"><%= one.getSubject() %></a>
	        </li>
	<%
		i++;
	} // end ifwhile 
	%>
</ul>
</body>
</html>
