package kr.pe.okjsp;

import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;

public class TwitterUpdate {
	
	private String tweetStsText = "" ;
	
	public void doUpdate(Article article) {

		String subject = article.getSubject();
		String content = article.getContent();
		int seq = article.getSeq();
		
		Twitter twitter = new TwitterFactory().getInstance("okjsp", "okpass12");
		
		//트윗 글 올리기 임시포맷
		if ( subject.length() > 30 ) {
			subject = subject.substring(0, 30) + "..";
		}
						
		if (content.length() > 84 ) {
			content = content.substring(0, 84) + "..";
		} 
		
		tweetStsText = subject + ": ";
		tweetStsText += content + " ";		
		tweetStsText += "http://test/" + seq; 		 

		String result_msg = "";
		try {
	        Status status = twitter.updateStatus(tweetStsText);
	        result_msg = status.getText();
		}catch (TwitterException te) {
			te.printStackTrace();
		}

		// twitter Successfully updated 
		System.out.println("result_msg length:   "+ result_msg.length() + " & " + result_msg);
		// twitter source end
	}
}
