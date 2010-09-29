package kr.pe.okjsp.util;

import kr.pe.okjsp.android.data.SessionManager;
import android.content.Context;
import android.content.SharedPreferences;

public class LoginHelper
{
	public static SessionManager sessionManager = SessionManager.getInstance();
	
	/*public static boolean doLogin(Context context)
	{
		return doLogin(context,false);
	}*/
	
	public static boolean doLogin(String id,String password)
	{
		String url = "http://www.okjsp.pe.kr/jsp/member/loginMobile.jsp?id="
			+ id + "&password=" + password;
	
		HttpClient.getContents(url, "EUC-KR");
		return sessionManager.isLogin();
	}
	
	public static boolean doLogin(Context context,boolean isAutoLogin)
	{
		SharedPreferences preferences = context.getSharedPreferences("autologinyn", 0);
		String autoLogin = preferences.getString("AutoLogin","NO");
		
		if( isAutoLogin && "NO".equals(autoLogin) )
			return false;
		
		String id = preferences.getString("ID","");
		String password = preferences.getString("PW","");
			
		return doLogin(id,password);
	}
	public static boolean doLogin(Context context){
		SharedPreferences preferences = context.getSharedPreferences("autologinyn", 0);
		
		String autoLogin = preferences.getString("AutoLogin","NO");
		
		if(autoLogin.equals("NO"))
			return false;
		else
			return true;
		
	}

}
