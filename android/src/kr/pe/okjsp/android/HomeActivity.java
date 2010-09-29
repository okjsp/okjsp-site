package kr.pe.okjsp.android;

import kr.pe.okjsp.android.data.SessionManager;
import kr.pe.okjsp.util.LoginHelper;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.Toast;

public class HomeActivity extends AbstractArticleListActivity 
{
	public static SessionManager sessionManager = SessionManager.getInstance();
	
	@Override
    public void onCreate(Bundle savedInstanceState)
	{
		setRecentData(true);
		super.onCreate(savedInstanceState);
		onLogin();
	}
	public boolean onCreateOptionsMenu(Menu menu) {
    	MenuInflater inflater = getMenuInflater();
    	inflater.inflate(R.menu.menu,menu);
    	
    	return true;
    }
	public boolean onOptionsItemSelected(MenuItem item) {
		Intent intent;
    	switch (item.getItemId()) {
    	case R.id.writemenu:
    		intent = new Intent(this.getApplicationContext(), WriteActivity.class);
			this.startActivity(intent);
			this.overridePendingTransition(0,0);
    		return true;
    	case R.id.loginmenu:
    		//intent = new Intent(this.getApplicationContext(), LoginDialog.class);
			//this.startActivity(intent);
			//this.overridePendingTransition(0,0);
    		LoginDialog loginDialog = new LoginDialog(this);
    		loginDialog.createLoginDialog();
    		return true;
    	}
    	return false;
    }
	private void onLogin()
	{
		if( sessionManager.isLogin() == true || LoginHelper.doLogin(getApplicationContext())== false )
			return;
		
		String message = "자동로그인을 시도합니다.";
		Toast.makeText(getApplicationContext(),message, Toast.LENGTH_SHORT).show();
		
		LoginHelper.doLogin(getApplicationContext(),true);
		
		if( !sessionManager.isLogin())
			message = "자동로그인을 실패하였습니다.";
		else
			message = "자동로그인을 완료되었습니다.";
		
		Toast.makeText(getApplicationContext(),message, Toast.LENGTH_SHORT).show();
	}
}