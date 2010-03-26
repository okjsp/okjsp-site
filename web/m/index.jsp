<%---------------------------------------------------------------------------------------------------------    
  FileName    : index.jsp
  Author      : BLUEPOET, ZKUAHN
  Regdate     : 2010-03-19
  Lastdate 	  : 2010-03-26
  Description : OKJSP 모바일 초기접속 페이지  
  ver         : 1.0
-----------------------------------------------------------------------------------------------------------%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, java.sql.*, kr.pe.okjsp.util.*, kr.pe.okjsp.BbsInfoBean " contentType='text/html;charset=euc-kr' %>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<%!
public HashMap getRecentList()
{
    int i =0;
    HashMap recentList = new HashMap();
    
    StringBuffer query = new StringBuffer();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;	
	DbCon dbCon = new DbCon();
	
	try 
	{
		conn = dbCon.getConnection();
		 
	    query.append(" select bbsid, count(*) as cnt from okboard ");
	    query.append(" where ");
	    //query.append(" cast(wtime as date)=cast(systimestamp as date)-1 ");
	    query.append(" cast(wtime as date)=sysdate ");
	    //query.append(" bbsid in ('bbs3','bbs4','bbs5') ");
	    query.append(" group by bbsid ");
	    query.append(" order by cnt desc ");
	    query.append(" for ORDERBY_NUM() <= 3 ");
		pstmt = conn.prepareStatement(query.toString());
		rs = pstmt.executeQuery();
	
		while(rs.next()) 
		{
			recentList.put("bbsid["+i+"]",rs.getString("bbsid"));
			recentList.put("cnt["+i+"]", rs.getInt("cnt"));
			recentList.put("nCount", i);
			
			i++;
		}
		
		rs.close();
		pstmt.close();
	} 
	catch(Exception e) 
	{
		e.printStackTrace();
	} finally 
	{
		dbCon.close(conn, pstmt, rs);
	}
	
	return recentList;
}
%>
<html>
<head>
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
<!-- IUI Header Start -->
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<link rel="apple-touch-icon" href="/m/iui/iui-logo-touch-icon.png" />
<meta name="apple-touch-fullscreen" content="YES" />
<style type="text/css" media="screen">@import "/m/iui/iui.css";</style>
<script type="application/x-javascript" src="/m/iui/iui.js"></script>
<style type="text/css">
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
    background: url(/m/iui/shade-compact.gif) no-repeat;
}
</style>
<!-- IUI Header End -->

</head>
<body>
    <div class="toolbar">
        <h1 id="pageTitle"></h1>
        <a id="backButton" class="button" href="#"></a>
<% if (member.getSid() != 0) { %>
		<!-- Do Nothing : 로그인 버튼 감춘다. 로그아웃 버튼은 불필요 -->
<% } else { %>
        <a class="button" href="#loginForm">Login</a>
<% } %>
    </div>
   
    <ul id="home" title="OKJSP.pe.kr" selected="true">
    	<li class="group">Book List</li>
		<li class="bookList" style="text-align: center;">
			<a href="#book" style="background-image: none;"><img src="/m/images/book/book1.png"/></a>			
		</li>
		<li class="group">Recent Posting List</li>
		<%			
			HashMap map = (HashMap)application.getAttribute("bbsInfoMap");
		
			if(getRecentList().size() == 0)
			{									
				%><li>
					오늘 올라온 글이 없습니다.
				</li>
			<%}
			else
			{
				int listSize = (Integer)getRecentList().get("nCount");
				
				for(int i=0; i<=listSize; i++)
				{
				    BbsInfoBean bbsInfo = (BbsInfoBean)map.get(getRecentList().get("bbsid["+i+"]"));			    
			%>
        <li class="recentList">
            <a href="/bbs?act=MLIST&bbs=<%=bbsInfo.getBbs()%>"><%=bbsInfo.getName()%>[<%=getRecentList().get("cnt["+i+"]")%>]</a>
        </li>
			<%
				}
			}
			%>
		<li class="recentList">
 			<a href="recentDetail.jsp">최근글 게시판</a>
		</li>
		<li class="group">All Board Lists</li>
		<li>
 			<a href="main.jsp" >전체 게시판</a>			
		</li>
		<li style="text-align: center;">			
			<a href="#" style="background-image: none;"><img src="/m/images/banner/acorn.png"/></a>
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
