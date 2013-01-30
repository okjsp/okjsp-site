<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="twitter4j.http.AccessToken,twitter4j.Status,twitter4j.Twitter,twitter4j.TwitterException,twitter4j.TwitterFactory,twitter4j.http.RequestToken"  %>
<h1>글쓰기 결과</h1>&nbsp;&nbsp;<a href="index.jsp">처음으로 가기</a><br>
<%
String tweetStsText = request.getParameter("tweetStsText");
if (tweetStsText.trim().equals("")) {
	%>
		<script language="javascript">
			alert("글이 없네요.");
			history.back();
		</script>
	<%
} else {

	String result_msg = "";
	
	final String CONSUMER_KEY = "zAoP6REuI5dj4UBlMaxYg";   
	final String CONSUMER_SECRET = "fHG60FiTx9bg0LbIiyo6jR8I9My1APV1QbKD2MTF8e8";   
	 
	String rtoken = session.getAttribute("rtoken").toString().trim();
	String rstoken = session.getAttribute("rstoken").toString().trim();
	
	out.println("처음 인증값 rtoken : " + rtoken + "<br>");
	out.println("처음 인증값 rstoken : " + rstoken + "<br>");
	
	String atoken = session.getAttribute("atoken").toString().trim();
	String astoken = session.getAttribute("astoken").toString().trim();
	
	out.println("두번째 인증값 atoken : " + atoken + "<br>");
	out.println("두번째 인증값 astoken : " + astoken + "<br>");
	
	try {
		
		Twitter twitter = new Twitter(); 
		twitter.setOAuthConsumer(CONSUMER_KEY,CONSUMER_SECRET);
		AccessToken accessToken = null;
		accessToken = new AccessToken(atoken, astoken); 
		twitter.setOAuthAccessToken(accessToken);      
	
		
		Status status = twitter.updateStatus(tweetStsText);
		result_msg = status.getText();
		
	}catch (TwitterException te) {
		out.println("<br>" + te.toString());
	}
}

%>
<p></p>
<a href='http://twitter.com/okjsp' target='twitter'>글 확인 하러 가기 </a><br><p></p>
<form name="tw" action="twitterUpdate.jsp">
<input type='text' name="tweetStsText" value="<%=tweetStsText %>"><br>
<input type="submit" value="트위터 글쓰기 ">
</form>
