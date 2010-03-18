<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page pageEncoding="euc-kr" import="java.util.*,kr.pe.okjsp.BbsInfoBean" %>
<%!
public HashMap<Integer,String> getListMap()
{
    HashMap<Integer,String> listMap = new HashMap<Integer,String>();
    
    listMap.put(0,"techtrend");
    listMap.put(1,"lecture");
    listMap.put(2,"TOOL");
    listMap.put(3,"TOOLqna");
    listMap.put(4,"ajax");
    listMap.put(5,"ajaxqna");
    listMap.put(6,"bbs2");
    listMap.put(7,"bbs1");
    listMap.put(8,"bbs4");
    listMap.put(9,"bbs3");
    listMap.put(10,"weblogic");
    listMap.put(11,"weblgqna");
    listMap.put(12,"xmltip");
    listMap.put(13,"xmlqna");
    listMap.put(14,"ruby");
    listMap.put(15,"rubyqna");
    listMap.put(16,"flex");
    listMap.put(17,"flexqna");
    listMap.put(18,"bbs7");
    listMap.put(19,"docs");
    listMap.put(20,"etc");
    listMap.put(21,"bbs6");
    listMap.put(22,"japanlife");
    listMap.put(23,"bbs5");
    listMap.put(24,"movie");
    listMap.put(25,"howmuch");
    listMap.put(26,"lifeqna");
    listMap.put(27,"news");
    listMap.put(28,"solo");
    listMap.put(29,"recruit");
    listMap.put(30,"engdocs");
    listMap.put(31,"krtomcat");
    listMap.put(32,"link");
    listMap.put(33,"goodjob");
    listMap.put(34,"market");
    listMap.put(35,"model2jsp");
    listMap.put(36,"notice");
    listMap.put(37,"okboard");
    listMap.put(38,"useful");
    listMap.put(39,"mac");
    listMap.put(40,"ihaveadream");
    listMap.put(41,"javastudy");
    listMap.put(42,"ns");
    listMap.put(43,"dbstudy");
    listMap.put(44,"springstudy");
    listMap.put(45,"xf");
    listMap.put(46,"trash");    
    listMap.put(47,"twitter");
    
    return listMap;
}
%>
<html>
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
    </div>
    <ul title="OKJSP" selected="true">
		<%
			HashMap map = (HashMap)application.getAttribute("bbsInfoMap");
			int listSize = getListMap().size();
			
			for(int i=0; i<listSize; i++)
			{
			    BbsInfoBean bbsInfo = (BbsInfoBean)map.get(getListMap().get(i));			    
		%>
        <li>
            <div class="digg-count"><%=(i+1)%></div>
            <a href="/bbs?act=MLIST&bbs=<%=bbsInfo.getBbs()%>"><%=bbsInfo.getName()%></a>
        </li>
		<%
			}
		%>
		<li>
			<div class="digg-count">49</div>
 			<a href="#">최근글 게시판</a>
		</li>
			
    </ul>
</body>
</html>
