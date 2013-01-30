<%@ page import="java.util.*, java.sql.*, kr.pe.okjsp.util.*, kr.pe.okjsp.BbsInfoBean, kr.pe.okjsp.Article" contentType='text/html;charset=euc-kr' %>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.1//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
<html>
<head>
<title>OKJSP</title>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<link rel="apple-touch-icon" href="/iui/images/okJSP.png" />
<meta name="apple-touch-fullscreen" content="YES" />
<style type="text/css" media="screen">@import "/iui/iui/iui.css";</style>
<script type="application/x-javascript" src="/iui/iui/iui.js"></script>
</head>
<body>

<!-- ---------- .toolbar ---------- -->
    <div class="toolbar">
        <h1 id="pageTitle">OKJSP</h1>
        <a id="backButton" class="button" href="#"></a>
<%		
	if (member.getSid() != 0) { 
%>
		<a class="newButton" href="editor_jquery.jsp" target="_iui"></a>
<% 		
	} else { 
%>
        <a class="button" href="#loginForm" onclick="document.getElementById('artist').focus()">Login</a>
<%		
	} 
%>
    </div>
<!-- ----------/.toolbar ---------- -->   

<!-- ---------- #list ---------- -->
    <ul id="home" title="OKJSP" selected="true">
		<li class="group">Recent Posting Lists</li>
<%
	Iterator iter = list.getAllRecentList(48).iterator();
	HashMap bbsInfoMap = (HashMap)application.getAttribute("bbsInfoMap");
	Article one = null;
	int i = 0;
	
	while (iter.hasNext() && i < 7)
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
	        <li>
				<img src="/iui/iui/icon_new.png" style="	float: left; height: 35px; width: 46px;	margin: -8px 0 -7px -10px" />	             
	            <a href="/bbs?seq=<%= one.getSeq() %>&viewMode=IUI" target="_iui"><%= one.getSubject() %></a>
	        </li>
	<%
		i++;
	} // end ifwhile 
	%>		
		<li class="group">All Board Lists</li>
		<!--
		<li class="recentList">
 			<img src="/iui/iui/icon_all.png" /><a href="recentDetail.jsp" target="_iui">�ֱٱ� �Խ���</a>
		</li>
		-->		
		<li>
 			<img src="/iui/iui/icon_all.png" /><a href="main.jsp" target="_iui">��ü �Խ���</a>			
		</li>
    	<li class="group">Book</li>
		<script type="text/javascript">
		
		var kangcomList = [
							{code:'201010040001',path:'2010/09',ext:'jpg',comment:'������ ������ ���� ���� ����� �÷����� ���� ������ ����, ��ȹ,����,�����̳� ��� �����Դϴ�.'},
							{code:'2010F1446912',path:'2010/08',ext:'jpg',comment:'���� �� �ȵ���̵� �� ���� ��ȸ�Դϴ�. �������� ������ ������� ����ֽ��ϴ�. ����!!!'},
							{code:'201006080010',path:'2010/06',ext:'jpg',comment:'TDD ���뿡 ���� �ѱ����� �̾߱���Դϴ�.'},
							{code:'201004050002',path:'2010/04',ext:'jpg',comment:'���ʺ��� 2D�� 3D �׷���, �ִϸ��̼�, ���� ���α׷��ֱ��� �÷���/�÷��� �׼ǽ�ũ��Ʈ�� ��� ��'},
		                  ];
		
			function showKangcomBook(kangcomCode) {
				// http://image3.kangcom.com/2009/03/l_pic/200903110001.jpg
				if (kangcomCode != null) {
				var imageUrl = "http://image3.kangcom.com/" + kangcomCode.path + "/b_pic/" + kangcomCode.code + '.' + kangcomCode.ext;

				document.write("<li><a href=\"http://kangcom.com/common/bookinfo/bookinfo.asp?sku="+kangcomCode.code+"\" title=\""+kangcomCode.comment+"\" target=\"_new\" class=\"book\"><img src=\""+imageUrl+"\"/>"+kangcomCode.comment+"</a></li>");
		
				}
			}
		
			for (var i = 0; i < kangcomList.length && i < 6 ; i++) {
				showKangcomBook(kangcomList[i]);
			}
			
		</script>		
		<li>
<%
		String bannerPath = "/images/banner/ibookscan_468x60.gif";
		String bannerTitle = "���� PDF ��ĵ ����";
		String bannerLink = "/f.jsp?http://www.iBookScan.co.kr/";
%>
			<div style="margin:0 0 0 -10px;text-align:center;">
			 <a href="<%=bannerLink %>" title="<%= bannerTitle %>" target="_new" style="background-image: none;">
			 	<img src="<%=bannerPath %>" border="0" class="bottomBanner" width="300">
			 </a>
			</div>
		</li>						
    </ul>
<!-- ----------/#list ---------- -->
	
<!-- ---------- #loginForm ---------- -->	
    <form id="loginForm" class="dialog" method="POST" target="_self" action="/jsp/member/loginMobile.jsp" >
        <fieldset>
            <h1>Login</h1>
            <a class="button cancelButton" type="cancel" href="#">Cancel</a>
			<a class="button blueButton" type="submit" href="#">Login</a>
            <label>ID</label>
            <input id="artist" type="text" name="id" />
            <label>PW</label>
            <input type="password" name="password"/>
        </fieldset>
    </form>
<!-- ----------/#loginForm ---------- -->
<script type="text/javascript" src="http://log.inside.daum.net/dwi_log/js/dwi.js"></script>
<script type="text/javascript" >
	_dwiPID="d-9jj-269";
	if(typeof(_dwiCatch) == "function") { _dwiCatch();}
</script>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>
