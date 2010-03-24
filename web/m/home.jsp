<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page pageEncoding="euc-kr"
    import="kr.pe.okjsp.util.CommonUtil, java.util.Iterator,
            kr.pe.okjsp.Article,kr.pe.okjsp.util.DateLabel" %>
<%@page import="java.util.Map"%>
<%@page import="kr.pe.okjsp.BbsInfoBean"%>
<%@page import="java.util.Arrays"%>
<% long stime = System.currentTimeMillis(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ taglib uri="/WEB-INF/tld/taglibs-string.tld" prefix="str" %>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />
<%--
    response.setContentType("text/html");

	Iterator iter = list.getList().iterator();
	Article one = null;
--%>

<%@page import="kr.pe.okjsp.ArticleDao"%><html>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
<!-- SAFARI Header Start -->
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<link rel="apple-touch-icon" href="/m/images/okJSP.png" />
<meta name="apple-touch-fullscreen" content="YES" />
<style type="text/css" media="screen">@import "/m/css/iui_okjsp.css";</style>
<script type="application/x-javascript" src="/m/js/iui.js"></script>
<style type="text/css"><!--

	body {
	    margin: 0;
	    font-family: Helvetica;
	    background: #FFFFFF;
	    color: #000000;
	    overflow-x: hidden;
	    -webkit-user-select: none;
	    -webkit-text-size-adjust: none;
	}

	body > .homebar {
	    box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	    border-bottom: 1px solid #2d3642;
	    border-top: 1px solid #6d84a2;
	    padding: 10px;
	    height: 45px;
	    background: url(/m/images/homebar.png) #6d84a2 repeat-x;		
	}
	
	.homebar > .homeTitle {
	    position: absolute;
	    overflow: hidden;
	    left: 50%;
	    margin: 1px 0 0 -75px;
	    height: 45px;
	    font-size: 20px;
	    width: 150px;
	    font-weight: bold;
	    text-shadow: rgba(0, 0, 0, 0.4) 0px -1px 0;
	    text-align: center;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    color: #FFFFFF;
	}	

	body > ul > li {
	    position: relative;
	    margin: 0 0 0 -40px;
	    padding: 8px 0 8px 10px;
	    font-size: 20px;
	    font-weight: bold;
	    list-style: none;
	    font-size: 14px;
	}
	
	body > ul > li > a {
	    display: block;
	    margin: -8px 0 -8px -10px;
	    padding: 8px 32px 8px 10px;
	    text-decoration: none;
	    color: inherit;
	}	

	body > ul > li.divBar {
		height: 8px; 
		background-color: #DDDDDD;
		border-bottom: 1px solid #FFFFFF;
		font-size: 12px;
	    font-weight: bold;	
	}	

    body > ul.bookList > li {
    	float: left;
    	margin-left: -15px; /* 도대체 왜 마진이 마이너스부터 적용되는 겅미? 알수 없습니다 from 안광운 */
    }

	body > ul.BBSList > li.recentList {
		border-bottom: 1px solid #FFFFFF;
	    background: url(/m/images/recentlistbg.png) repeat-x;	
	}	
	
	body > ul.BBSList > li.recentList > a {
		margin-left: 5px;
	    background: url(/m/images/newIcon.png) no-repeat left center;
	}		
	
	body > ul.BBSList > li > a > .listTitle {
		padding: 0 0 0 25px;
	}		
	
	body > ul.BBSList > li.bbsList {
	    background: url(/m/images/bbslistbg.png) repeat-x;	
	}	

	body > ul.BBSList > li.bbsList > a {
		margin-left: 5px;	
	    background: url(/m/images/listIcon.png) no-repeat left center;
	}	

	body > .getNextButton, .banner {
		text-align: center;
		margin-bottom: 17px;
	}
	
	body > .getNextButton > a {
		text-decoration: none;
 		font-size: 20px;
		color: #5360b4;
	}
	
	body > .info {
	    box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	    border-top: 1px solid #6d84a2;
	    padding: 10px;
	    height: 44px;
	    background: url(/m/iui/toolbar.png) repeat-x;	
	}		

	.button {
	    overflow: hidden;
	    margin: 0;
	    border-width: 0 5px;
	    padding: 8px 10px;
	    width: auto;
	    height: 30px;
	    line-height: 25px;
	    font-family: inherit;
	    font-size: 12px;
	    font-weight: bold;
	    color: #FFFFFF;
	    text-shadow: rgba(0, 0, 0, 0.6) 0px -1px 0;
	    text-overflow: ellipsis;
	    text-decoration: none;
	    white-space: nowrap;
	    background: none;
	    -webkit-border-image: url(/m/iui/toolButton.png) 0 5 0 5;
	}	

	.leftButton {
	    left: 6px;
	    right: auto;
	}	

	.clearBoth {
	clear: both;
	}
--></style>
<!-- SAFARI Header End -->

</head>
<body>
	<div class="homebar">
		<h1 class="homeTitle">OKJSP.pe.kr</h1>
	</div>

	<ul class="bookList">
		<li>
			<a href="#"><img src="/m/images/book/book1.png"/></a>			
		</li>
		<li>
			<a href="#"><img src="/m/images/book/book2.png"></a>			
		</li>
		<li>
			<a href="#"><img src="/m/images/book/book3.png"></a>			
		</li>
	</ul>
	
	<div class="clearBoth"></div>
		
    <ul class="BBSList">
        <li class="recentList">
            <a href="#"><span class="listTitle">RECENT Posting List</span></a>
        </li>
        <li class="divBar">
			BBS List
        </li>
        <li class="bbsList">
            <a href="#"><span class="listTitle">사는 얘기</span></a>
        </li>
        <li class="bbsList">
            <a href="#"><span class="listTitle">머리식히는 곳</span></a>
        </li>
        <li class="bbsList">
            <a href="#"><span class="listTitle">Java Study</span></a>
        </li>
        <li class="bbsList">
            <a href="#"><span class="listTitle">사는 얘기</span></a>
        </li>
        <li class="bbsList">
            <a href="#"><span class="listTitle">머리식히는 곳</span></a>
        </li>
        <li class="bbsList">
            <a href="#"><span class="listTitle">Java Study</span></a>
        </li>        
    </ul>	
    
	<div class="getNextButton">
		<a href="#">Get Next Page Stories...</a>
	</div>    
	
	<div class="banner">
		<a href="#"><img src="/m/images/banner/acorn.png"/></a>
	</div>
	
	<div class="info">
    	<a class="button leftButton" href="#">Info</a>
	</div>
</body>
</html>
