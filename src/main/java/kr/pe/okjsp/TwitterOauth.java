package kr.pe.okjsp;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;

public class TwitterOauth {

	/* auth : 김영수(topolo)
	 * oatuh Consumers load 
	 * site_id :  해당 사이트 아이디 
	 */
	private String[] loadConsumers(String site_id) throws Exception {
		//to-do 회원별 정보 가지고 오기		
		String[] consumers = new String[2];
		
		if (site_id != null && site_id.trim().equals("okjsp")) {
			//okjsp의 해당 정보를 넘긴다. 
			consumers[0] = "zAoP6REuI5dj4UBlMaxYg";
			consumers[1] = "fHG60FiTx9bg0LbIiyo6jR8I9My1APV1QbKD2MTF8e8";
		}
		return consumers;
	}
	
	/* auth : 김영수(topolo)
	 * oatuh 토큰 초기화 
	 * site_id :  해당 사이트 아이디 
	 */
	public void initToken(String site_id) throws Exception{
		
		// The factory instance is re-useable and thread safe.
	    Twitter twitter = new TwitterFactory().getInstance();
	    
	    String[] consumers = loadConsumers(site_id);
	    twitter.setOAuthConsumer(consumers[0], consumers[1]);
	    
	    RequestToken requestToken = twitter.getOAuthRequestToken();
	    AccessToken accessToken = null;
	    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
	    while (null == accessToken) {
	      System.out.println("Open the following URL and grant access to your account:");
	      System.out.println(requestToken.getAuthorizationURL());
	      System.out.print("Enter the PIN(if aviailable) or just hit enter.[PIN]:");
	      String pin = br.readLine();
	      try{
	         if(pin.length() > 0){
	           accessToken = twitter.getOAuthAccessToken(requestToken, pin);
	         }else{
	           accessToken = twitter.getOAuthAccessToken();
	         }
	      } catch (TwitterException te) {
	        if(401 == te.getStatusCode()){
	          System.out.println("Unable to get the access token.");
	        }else{
	          te.printStackTrace();
	        }
	      }
	    }
	    //persist to the accessToken for future reference.
		storeAccessToken(site_id,twitter.verifyCredentials().getId() , accessToken);
	}

	/* author : 김영수(topolo)
	 * oatuh 토큰 저장 
	 * site_id :  해당 사이트 아이디 
	 * useId : twitter 식별자
	 * AccessToken : twitter acess 토큰
	 */
	private void storeAccessToken(String site_id,long l, AccessToken at){
		//to-do 저장방식 선정 
		//store at.getToken()
		//store at.getTokenSecret()
	}
	
	/* author : 김영수(topolo)
	 * twitter에 oauth 정보 추가
	 */
	public Twitter setOauth(String site_id,Twitter twitter) throws Exception{
		// The factory instance is re-useable and thread safe.
		//twitter.setOAuthConsumer("[consumer key]", "[consumer secret]"); // consumer 정보가 더 필요한지 확인 필요
		AccessToken accessToken = loadAccessToken(site_id);
		twitter.setOAuthAccessToken(accessToken);
		return twitter;
	}
	
	/*author : 김영수(topolo)
	 * site_id로  토큰 얻기 
	 * useId : twitter 식별자
	 */	
	private AccessToken loadAccessToken(String site_id){
		//to-do 저장방식 선정 
		String token 		= ""; // load from a persistent store
		String tokenSecret 	= ""; // load from a persistent store
		return new AccessToken(token, tokenSecret);
	}	
}
