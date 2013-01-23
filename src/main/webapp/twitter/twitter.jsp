<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="twitter4j.Status,twitter4j.Twitter,twitter4j.TwitterException,twitter4j.TwitterFactory,twitter4j.http.RequestToken"  %>
<h1>requestToken 얻기</h1>&nbsp;&nbsp;<a href="index.jsp">처음으로 가기</a><br>
<%
final String CONSUMER_KEY = "zAoP6REuI5dj4UBlMaxYg";   
final String CONSUMER_SECRET = "fHG60FiTx9bg0LbIiyo6jR8I9My1APV1QbKD2MTF8e8";   
  
Twitter twitter = new Twitter();   
twitter.setOAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET);   
  
RequestToken requestToken = null;   
try {   
   requestToken = twitter.getOAuthRequestToken();  
   out.println(requestToken);
   
   out.println("<p><a href='http://twitter.com/oauth/authorize?oauth_token=" + requestToken.getToken() + "'>인증하러가기 to http://twitter.com/oauth/authorize</a>");
   
   session.setAttribute("rtoken",requestToken.getToken());
   session.setAttribute("rstoken",requestToken.getTokenSecret());
   
   String rtoken = session.getAttribute("rtoken").toString().trim();
   String rstoken = session.getAttribute("rstoken").toString().trim();
   
   out.println("<p>처음 인증값rtoken : " + rtoken + "<br>");
   out.println("처음 인증값rstoken : " + rstoken + "<br>");
   
} catch (TwitterException te) {   
	out.println("<br>" + te.toString());
} 

%>
