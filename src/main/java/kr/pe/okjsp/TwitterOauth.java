package kr.pe.okjsp;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.http.AccessToken;
import twitter4j.http.RequestToken;

public class TwitterOauth {

	/* auth : �迵��(topolo)
	 * oatuh Consumers load 
	 * site_id :  �ش� ����Ʈ ���̵� 
	 */
	private String[] loadConsumers(String site_id) throws Exception {
		//to-do ȸ���� ���� ������ ����		
		String[] consumers = new String[2];
		
		if (site_id != null && site_id.trim().equals("okjsp")) {
			//okjsp�� �ش� ������ �ѱ��. 
			consumers[0] = "zAoP6REuI5dj4UBlMaxYg";
			consumers[1] = "fHG60FiTx9bg0LbIiyo6jR8I9My1APV1QbKD2MTF8e8";
		}
		return consumers;
	}
	
	/* auth : �迵��(topolo)
	 * oatuh ��ū �ʱ�ȭ 
	 * site_id :  �ش� ����Ʈ ���̵� 
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

	/* author : �迵��(topolo)
	 * oatuh ��ū ���� 
	 * site_id :  �ش� ����Ʈ ���̵� 
	 * useId : twitter �ĺ���
	 * AccessToken : twitter acess ��ū
	 */
	private void storeAccessToken(String site_id,int useId, AccessToken at){
		//to-do ������ ���� 
		//store at.getToken()
		//store at.getTokenSecret()
	}
	
	/* author : �迵��(topolo)
	 * twitter�� oauth ���� �߰�
	 */
	public Twitter setOauth(String site_id,Twitter twitter) throws Exception{
		// The factory instance is re-useable and thread safe.
		//twitter.setOAuthConsumer("[consumer key]", "[consumer secret]"); // consumer ������ �� �ʿ����� Ȯ�� �ʿ�
		AccessToken accessToken = loadAccessToken(site_id);
		twitter.setOAuthAccessToken(accessToken);
		return twitter;
	}
	
	/*author : �迵��(topolo)
	 * site_id��  ��ū ��� 
	 * useId : twitter �ĺ���
	 */	
	private AccessToken loadAccessToken(String site_id){
		//to-do ������ ���� 
		String token 		= ""; // load from a persistent store
		String tokenSecret 	= ""; // load from a persistent store
		return new AccessToken(token, tokenSecret);
	}	
}
