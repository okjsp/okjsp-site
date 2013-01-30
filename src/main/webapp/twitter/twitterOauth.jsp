<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,twitter4j.Status,twitter4j.Twitter,twitter4j.TwitterException,twitter4j.TwitterFactory,twitter4j.http.RequestToken,twitter4j.http.AccessToken"  %>
<h1>consumer return page - acessToekn 얻기</h1>&nbsp;&nbsp;<a href="index.jsp">처음으로 가기</a><br>
<%
final String CONSUMER_KEY = "zAoP6REuI5dj4UBlMaxYg";   
final String CONSUMER_SECRET = "fHG60FiTx9bg0LbIiyo6jR8I9My1APV1QbKD2MTF8e8";  

Twitter twitter = new Twitter();   
twitter.setOAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET);   
  
String oauthToken = request.getParameter("oauth_token"); 
String rtoken = session.getAttribute("rtoken").toString().trim();
String rstoken = session.getAttribute("rstoken").toString().trim();

out.println("처음 인증값 rtoken : " + rtoken + "<br>");
out.println("처음 인증값rstoken : " + rstoken + "<br>");

AccessToken accessToken = null;

if (rtoken.equals(oauthToken)) {   
   try {   
	   accessToken = twitter.getOAuthAccessToken(oauthToken, rstoken);   
   } catch (TwitterException te) {   
		out.println("<br>" + te.toString());	   
   }   
  
   twitter.setOAuthAccessToken(accessToken);   
  
   session.setAttribute("atoken",accessToken.getToken());
   session.setAttribute("astoken",accessToken.getTokenSecret());
   
   String atoken = session.getAttribute("atoken").toString().trim();
   String astoken = session.getAttribute("astoken").toString().trim();
   
   out.println("두번째 인증값 atoken : " + atoken + "<br>");
   out.println("두번째 인증값astoken : " + astoken + "<br>");
    
}   

%>

<form name="tw" action="twitterUpdate.jsp">
<input type='text' name="tweetStsText" value="okjsp twiter oath"><br>
<input type="submit" value="트위터 글쓰기 ">
</form>