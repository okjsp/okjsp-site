package kr.pe.okjsp.android.data;

public class SessionManager {
	
	private boolean isLogin = false;
	private String  jsessionId;
	private String  sid;
	private String  okid;
	
	public static SessionManager sessionManager = new SessionManager();
	
	public static SessionManager getInstance()
	{
		return sessionManager;
	}
	
	private SessionManager()
	{	
	}
	
	@Override
	public String toString() {
		return "JSESSIONID="+getJsessionId() + ";" + "sid=" + getSid()+";" + "okid=" + getOkid() + ";";
	}

	public void setJsessionId(String jsessionId) {
		this.jsessionId = jsessionId;
	}

	public String getJsessionId() {
		return jsessionId;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getSid() {
		return sid;
	}

	public void setOkid(String okid) {
		this.okid = okid;
	}

	public String getOkid() {
		return okid;
	}

	public void setLogin(boolean isLogin) {
		this.isLogin = isLogin;
	}

	public void loginTrue(){
		isLogin = true;		
	}
	
	public void loginFalse(){
		isLogin = false;		
	}
	public boolean isLogin() {
		return isLogin;
	}
	public void Init(){
		isLogin    = false;
		jsessionId = null;
		sid		   = null;
		okid 	   = null;
		
	}
}
