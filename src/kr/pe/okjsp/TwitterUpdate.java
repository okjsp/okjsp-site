package kr.pe.okjsp;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import kr.pe.okjsp.util.CommonUtil;

import com.rosaloves.net.shorturl.bitly.Bitly;
import com.rosaloves.net.shorturl.bitly.BitlyException;
import com.rosaloves.net.shorturl.bitly.BitlyFactory;
import com.rosaloves.net.shorturl.bitly.url.BitlyUrl;

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
		int tmpContLen = 0;

		BitlyUrl bUrl = null;
        String sOrgUrl = "http://okjsp.pe.kr/seq/"+seq;
        URL resultUrl = null;
		try {
			resultUrl = new URL(sOrgUrl);
		} catch (MalformedURLException e1) {
		}

		
		Twitter twitter = new TwitterFactory().getInstance("okjsp", "okpass12");
		Bitly bitly = BitlyFactory.newJmpInstance("okjsp", "R_2338c002b1dfeb9d0b111d1f0bfa8ce0");

        try {
			bUrl = bitly.shorten(sOrgUrl);
		} catch (Exception e) {
			bUrl = null;
		}
		
        if (bUrl != null){
        	resultUrl = bUrl.getShortUrl();        	
        }else{
        	// 원래URL 사용시에는 content 를 줄여야함
        	tmpContLen = 11;
        }

		
		//트윗 글 올리기 임시포맷
		if ( subject.length() > 30 ) {
			subject = subject.substring(0, 30) + "..";
		}
	
		// html tag 삭제
		content = CommonUtil.removeTag(content);
		
		if (content.length() > 84-tmpContLen ) {
			content = content.substring(0, 84-tmpContLen) + "..";
		} 
   
		tweetStsText = subject + ": ";
		tweetStsText += content + " ";		
		tweetStsText += resultUrl; 		 

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
