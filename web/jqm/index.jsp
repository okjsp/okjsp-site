<%@ page import="java.util.*, java.sql.*, kr.pe.okjsp.util.*, kr.pe.okjsp.BbsInfoBean, kr.pe.okjsp.Article" contentType='text/html;charset=euc-kr' %>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>OKJSP with jQueryMobile</title>
<link rel="apple-touch-icon" href="/m/images/okJSP.png" />
<link rel="stylesheet" href="/jqm/src/jquery.mobile-1.0a3.css" />
<link rel="stylesheet" href="/jqm/css/index.css" />
<style type="text/css">
	#OJ-homeheader {
		text-align: center;
		color: #395b85;
	}
	
	#OJ-homeheader > #okjsp-logo {
	 	margin: 15px 50px 0 0;
	}
	
	#OJ-homeheader > p {
		margin: 0 0 0 50px;
	}
	
</style>
<script src="http://code.jquery.com/jquery-1.4.4.min.js"></script> 
<script type="text/javascript" src="/jqm/src/jquery.mobile-1.0a3.js"></script>
<script type="text/javascript" src="/jqm/js/index.js"></script>
</head>
<body>
<div data-role="page" data-theme="b" id="jqm-home">
	<div id="OJ-homeheader"> 
		<h1 id="okjsp-logo"><img src="/jqm/src/okjsp_10th.png"/></h1> 
		<p>with jQueryMobile</p> 
	</div>
	  
	<div data-role="content" style="padding-top: 0;">
		<ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b"> 
			<li data-role="list-divider">Recent posting lists</li>
<%
	Iterator iter = list.getAllRecentList(48).iterator();
	HashMap bbsInfoMap = (HashMap)application.getAttribute("bbsInfoMap");
	Article one = null;
	int i = 0;
	
	while (iter.hasNext() && i < 30)
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
			<li><a href="/bbs?seq=<%= one.getSeq() %>&viewMode=JQM" target="JQM"><%= one.getSubject() %></a></li>
	<%
		i++;
	}  
	%>
			<li data-role="list-divider">All board lists</li> 
			<li><a href="board.jsp" target="JQM">Board Lists</a></li>
		</ul> 
	</div> 	
</div>
</body>
</html>