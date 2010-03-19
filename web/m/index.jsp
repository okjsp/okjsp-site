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
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:setProperty name="list" property="*" />
<%
    response.setContentType("text/html");

	Iterator iter = list.getList().iterator();
	Article one = null;
%>

<%@page import="kr.pe.okjsp.ArticleDao"%><html>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">

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
    <div class="toolbar">
        <h1 id="pageTitle"></h1>
        <a id="backButton" class="button" href="#"></a>
<% if (member.getSid() != 0) { %>
			<!-- Do Nothing -->
<% } else { %>
        <a class="button" href="#loginForm">Login</a>
<% } %>
    </div>
    <ul title="OKJSP BBS" selected="true">
        <li>
            <div class="digg-count">1</div>
            <a href="/bbs?act=MLIST&bbs=twitter">Twitter</a>
        </li>
        <li>
            <div class="digg-count">2</div>
            <a href="/bbs?act=MLIST&bbs=bbs6">사는 얘기</a>
        </li>
        <li>
            <div class="digg-count">3</div>
            <a href="/bbs?act=MLIST&bbs=bbs5">머리식히는 곳</a>
        </li>
        <li>
            <div class="digg-count">4</div>
            <a href="/bbs?act=MLIST&bbs=javastudy">Java Study</a>
        </li>
    </ul>
    
    <form id="loginForm" class="dialog" method="POST" target="_self" action="/jsp/member/loginMobile.jsp" >
        <fieldset>
            <h1>Login</h1>            
            <!-- 버튼에  href="#"를 넣어주지 않으면 동작하지 않는다 -->
            <a class="button leftButton" type="cancel" href="#">Cancel</a>
<% if (member.getSid() != 0) { %>
			<!-- Do Nothing -->
<% } else { %>
            <a class="button blueButton" type="submit" href="#">Login</a>
<% } %>
            
            <label>ID :</label>
            <input id="artist" type="text" name="id" />
            <label>PW:</label>
            <input type="password" name="password"/>
        </fieldset>
    </form>
    
</body>
</html>
