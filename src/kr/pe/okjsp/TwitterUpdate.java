package kr.pe.okjsp;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

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
	private String twitterId = "okjsp";
	private String twitterPwd = "okpass12";
	private String bitlyId = "okjsp";
	private String bitlyKey = "R_2338c002b1dfeb9d0b111d1f0bfa8ce0";
	

	public void doUpdate(Article article, HttpServletRequest req) {
		if ( !isTwitterUpdate(article, req) ){
			return;
		}
		
		String subject = article.getSubject();
		String content = article.getContent();
		int seq = article.getSeq();

		int subjectLen = 0;
		int maxContentLen = 0;
		int urlLen = 0;
		
		Twitter twitter = new TwitterFactory().getInstance(twitterId, twitterPwd);
		Bitly bitly = BitlyFactory.newJmpInstance(bitlyId, bitlyKey);
		
		BitlyUrl bUrl = null;
        String sOrgUrl = "http://okjsp.pe.kr/seq/"+seq;
        URL resultUrl = null;
		try {
			resultUrl = new URL(sOrgUrl);	//원본링크
			urlLen = sOrgUrl.length();	
		} catch (MalformedURLException e1) {
		}
		
        try {
			bUrl = bitly.shorten(sOrgUrl);
		} catch (Exception e) {
			bUrl = null;
		}
		
        if (bUrl != null){
        	resultUrl = bUrl.getShortUrl();	//짧은링크
        	urlLen = resultUrl.toString().length();
        }
		
		//트윗 글 올리기 임시포맷 
        //글제목: 최대30자 
		if ( subject.length() > 30 ) {
			subject = subject.substring(0, 30) + "..";
		}
		subjectLen = subject.length();

		// html tag 삭제
		content = CommonUtil.removeTag(content, "<");
		

		
		//게시글내용에 링크가 있으면 bit.ly처리후 트윗
		int linkStartAt = content.indexOf("http://"); 
		int linkEndAt   = content.indexOf(" ", linkStartAt);
		String strContainLink = "";
		boolean isContainLink = linkStartAt > -1 ? true : false;

		/** 게시글 링크처리 **/
		try {
			// 트윗최대140자에서 제목길이+주소길이+기타길이(3)를 뺀다 (트윗가능한 게시판내용의 길이)
			maxContentLen = 140-(subjectLen+urlLen+3);
			
			if ( isContainLink ) {
				
				if (linkEndAt <= 0) {
					linkEndAt = content.length()-1;
				}
	
				if (linkStartAt+18 < maxContentLen ) {
					//게시글내용의 링크를 bit.ly 처리가능
					strContainLink = content.substring(linkStartAt, linkEndAt+1);
					strContainLink = strContainLink.replaceAll("&amp;", "&");
					  try {
							bUrl = bitly.shorten(strContainLink);
							content = content.substring(0, linkStartAt) + bUrl.getShortUrl();
						} catch (Exception e) {
							e.printStackTrace();
						}
				} else {
					//주소가 길어서 bit.ly 처리해도 이미 overLenth 인 경우 link 제거
					content = content.substring(0, linkStartAt);
				}
			}
		}catch (Exception e){
			//게시글링크처리중 에러
			e.printStackTrace();
		}

		if (content.length() > maxContentLen ) {			
			content = content.substring(0, maxContentLen-2) + "..";
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
	
	/**
	 * 게시판이 트위터 전송이 허용이 되었는지 확인 후 허용여부를 반환한다.
	 * 
	 * @param m_article 게시글
	 * @param m_req HttpServletRequest
	 * @return 트위터 전송 허용 여부
	 */
	private boolean isTwitterUpdate(Article m_article, HttpServletRequest m_req){
		
		try{
			HashMap bbsInfoMap = (HashMap)m_req.getSession().getServletContext().getAttribute("bbsInfoMap");
			
		    BbsInfoBean bbsInfo = ((BbsInfoBean)(bbsInfoMap.get(m_article.getBbs())));
		    if (bbsInfo == null) {
		    	System.out.println("isTwitterUpdate bbsInfo == null / m_article.getBbs() : " + m_article.getBbs());
		    	return false;
		    }
		    System.out.println("isTwitterUpdate bbsInfo.getCseq() : " + bbsInfo.getCseq());
		    if ("2".equals(bbsInfo.getCseq())) {
		    	return false;
		    }
		}catch(Exception e){
			System.out.println("isTwitterUpdate : " + e);
		}
		return true;
	}
}
