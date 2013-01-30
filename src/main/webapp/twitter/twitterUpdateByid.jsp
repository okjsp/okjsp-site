<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="twitter4j.http.AccessToken,twitter4j.Status,twitter4j.Twitter,twitter4j.TwitterException,twitter4j.TwitterFactory,twitter4j.http.RequestToken"  %>
<h1>id/pw로  글쓰기</h1>&nbsp;&nbsp;<a href="index.jsp">처음으로 가기</a><br>
<%
 
String twitterId = "okjsp";
String twitterPwd = "okpass12";
String tweetStsText = request.getParameter("tweetStsText");
String result_msg = "";
if (tweetStsText.trim().equals("")) {
%>
	<script language="javascript">
		alert("글이 없네요.");
		history.back();
	</script>
<%
} else {
	try {
		
		Twitter twitter = new TwitterFactory().getInstance(twitterId, twitterPwd);
		
		Status status = twitter.updateStatus(tweetStsText);
		result_msg = status.getText();
		
	}catch (TwitterException te) {
		out.println("<br>" + te.toString());
	}
}
out.println("<a href='http://twitter.com/okjsp' target='twitter'>글 확인 하러 가기 </a>");
%>
