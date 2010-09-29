package kr.pe.okjsp.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.List;

import kr.pe.okjsp.android.data.SessionManager;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.impl.client.DefaultHttpClient;

import android.util.Log;


public class HttpClient
{
	public static SessionManager sessionManager = SessionManager.getInstance();
	public static StringBuffer buffer = new StringBuffer(); 
	
	public static String getContents(String url,String encoding)
	{
		return getContents(url,encoding,"GET",null);
	}
	
	public static String getContents(String url,String encoding,String method,List<NameValuePair> datas)
	{
		/*
		 * List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
        nameValuePairs.add(new BasicNameValuePair("monitorid", "아이디"));
        nameValuePairs.add(new BasicNameValuePair("password", "비밀번호"));
        httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
		 */
		HttpRequestBase requestBase; 
		
		if( "POST".equals(method.toUpperCase()) )
		{
			HttpPost httpPost = null;
			try
			{
				httpPost = new HttpPost(url);
				httpPost.setEntity(new UrlEncodedFormEntity(datas));
			}
			catch (UnsupportedEncodingException e)
			{
				e.printStackTrace();
			}
			
			requestBase = (HttpRequestBase)httpPost;
		}
		else
			requestBase = new HttpGet(url);
		
	    buffer.setLength(0);
		DefaultHttpClient httpclient = new DefaultHttpClient();
		
		HttpResponse response;
		
		try
		{
			if (sessionManager.isLogin())
			{
				requestBase.setHeader("Cookie", sessionManager.toString());
			}
			
			response = httpclient.execute(requestBase);
			HttpEntity entity = response.getEntity();
			
			BufferedReader br = null;
			String s = null;
			try
			{
				br = new BufferedReader(new InputStreamReader(entity.getContent(),encoding));
				Header[] headers = response.getAllHeaders();
				
				while ((s = br.readLine()) != null)
				{
					buffer.append(s);
					buffer.append("\n");
				}
				br.close();
				
				if (!sessionManager.isLogin())
					parseHeader(headers);
			}
			finally
			{
				if (br != null)
					try { br.close(); } catch (Exception e) { }
			}
		}
		catch (ClientProtocolException e)
		{
			e.printStackTrace();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		
		return buffer.toString();
	}

	private static void parseHeader(Header[] headers)
	{
		String value;
		String jsessionId = null;
		String sid = null;
		String okid = null;
		
		for (Header header : headers) {
			if (header.getName().equalsIgnoreCase("Set-Cookie"))
			{
				Log.d("test", "=" + header.getValue());
				value = header.getValue();
				
				if (value.indexOf("JSESSIONID") > -1)
				{
					jsessionId = value.substring(11, value.indexOf(";"));
					sessionManager.setJsessionId(jsessionId);
				}
				else if (value.indexOf("sid") > -1) {
					sid = value.substring(4, value.indexOf(";"));
					sessionManager.setSid(sid);
				}
				else if (value.indexOf("okid") > -1)
				{
					okid = value.substring(5, value.indexOf(";"));
					sessionManager.setOkid(okid);
				}
			}
		}
		
		if(sid != null && okid != null)
			sessionManager.loginTrue();
	}
}