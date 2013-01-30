package kr.pe.okjsp;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.PropertyManager;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.http.AccessToken;

import com.rosaloves.net.shorturl.bitly.Bitly;
import com.rosaloves.net.shorturl.bitly.BitlyFactory;
import com.rosaloves.net.shorturl.bitly.url.BitlyUrl;

public class TwitterUpdate {
	
	private String tweetStsText = "" ;
	private String bitlyId = PropertyManager.getString("BITLYID");
	private String bitlyKey = PropertyManager.getString("BITLYKEY");
	
	//add oauth variable by topolo 2010.05.27
	private String consumer_key = PropertyManager.getString("CONSUMER_KEY");
	private String consumer_secret  = PropertyManager.getString("CONSUMER_SECRET");
	
	private String acessToken  = PropertyManager.getString("ACESSTOKEN");
	private String acessToken_secret   = PropertyManager.getString("ACESSTOKENSECRET");
	
	public void doUpdate(Article article, HttpServletRequest req) {
		if ( !isTwitterUpdate(article, req) ){
			return;
		}
		
		String subject = article.getSubject();
		String content = article.getContent();
		int seq = article.getSeq();
		
		
		BitlyUrl bUrl = null;
        String sOrgUrl = "http://www.okjsp.pe.kr/seq/"+seq;
        URL resultUrl = null;
		try {
			resultUrl = new URL(sOrgUrl);	//������ũ
		} catch (MalformedURLException e1) {
		}
		
        try {
        	Bitly bitly = BitlyFactory.newJmpInstance(bitlyId, bitlyKey);
			bUrl = bitly.shorten(sOrgUrl);
		} catch (Exception e) {
			bUrl = null;
		}
		
        if (bUrl != null){
        	resultUrl = bUrl.getShortUrl();	//ª����ũ
        }
		
		//Ʈ�� �� �ø��� �ӽ����� 
        //������: �ִ�30�� 
		if ( subject.length() > 30 ) {
			subject = subject.substring(0, 30) + "��";
		}

		/*
		*	html tag ����
		*	���� : ������[Coma] 2010.03.25
		*	CommonUtil.removeTagTest �߰��Ͽ� ������.
		*/
		content = CommonUtil.removeTag(content);
		
		if ( content.length() > 80 ) {
			content = content.substring(0, 80) + "��";			
		}
	   
		tweetStsText = subject + ": ";
		tweetStsText += content + " ";		
		tweetStsText += resultUrl;

		String result_msg = "";
		try {
			//Twitter twitter = new TwitterFactory().getInstance(twitterId, twitterPwd); //id,pw ��� ���� topolo 2010.5.27
			
			//oauth������� ���� topolo 2010.5.27 
			Twitter twitter = new TwitterFactory().getInstance(); 
			twitter.setOAuthConsumer(consumer_key,consumer_secret);
			AccessToken accessToken = null;
			accessToken = new AccessToken(acessToken, acessToken_secret); 
			twitter.setOAuthAccessToken(accessToken);     
			
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
	 * �Խ����� Ʈ���� ������ ����� �Ǿ����� Ȯ�� �� ��뿩�θ� ��ȯ�Ѵ�.
	 * 
	 * @param m_article �Խñ�
	 * @param m_req HttpServletRequest
	 * @return Ʈ���� ���� ��� ����
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
