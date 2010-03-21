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
<style type="text/css">
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
	
	body > ul > .divBar {
		font-size: 10px;
	    font-weight: bold;
		background-color: #DDDDDD;
		border-bottom: 1px solid #FFFFFF;	
	}	
	
	body > ul.BBSList > li.recentList {
		border-bottom: 1px solid #FFFFFF;
	    background: url(/m/images/recentlistbg.png) repeat-x;	
	}	

	body > ul.BBSList > li.bbsList {
	    background: url(/m/images/bbslistbg.png) repeat-x;	
	}	

	body > ul > li > a {
	    display: block;
	    margin: -8px 0 -8px -10px;
	    padding: 8px 32px 8px 10px;
	    text-decoration: none;
	    color: inherit;
	}
</style>
<!-- SAFARI Header End -->

</head>
<body>
	<div class="homebar">
		<h1 class="homeTitle">OKJSP.pe.kr</h1>
	</div>
	
	<ul class="bookList">
		<li>
			<a class="#" href=""></a>			
		</li>
	</ul>
		
    <ul class="BBSList">
        <li class="recentList">
            <a href="#">Twitter</a>
        </li>
        <li class="divBar">
        	BBS List
        </li>
        <li class="bbsList">
            <a href="#">사는 얘기</a>
        </li>
        <li class="bbsList">
            <a href="#">머리식히는 곳</a>
        </li>
        <li class="bbsList">
            <a href="#">Java Study</a>
        </li>
    </ul>	
</body>
</html>
