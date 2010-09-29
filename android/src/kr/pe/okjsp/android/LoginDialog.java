package kr.pe.okjsp.android;

import kr.pe.okjsp.android.data.SessionManager;
import kr.pe.okjsp.util.LoginHelper;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.CompoundButton.OnCheckedChangeListener;

public class LoginDialog extends Activity implements OnCheckedChangeListener
{
	private static SessionManager sessionManager = SessionManager.getInstance();
	private CheckBox checkBox;
	private AlertDialog.Builder dialog;
	private EditText ID;
	private EditText PW;
	private TextView textView;
	private TextView lg_sf;
	private Activity activity;
	private View layout;
	
	public LoginDialog(Activity activity)
	{
		this.activity = activity;
		setInit();
	}
	
	public void createLoginDialog()
	{
		dialog = new AlertDialog.Builder(activity);
		dialog.setTitle("로그인하시겠습니까?");
		dialog.setView(layout);
		setLoginButton();
		setCancelButton();	
		AlertDialog alertDialog = dialog.create();
		alertDialog.show();
	}
	
	private void setInit()
	{
		LayoutInflater inflater = (LayoutInflater) activity.getSystemService(activity.LAYOUT_INFLATER_SERVICE);
		layout = inflater.inflate(R.layout.logindialog,(ViewGroup) activity.findViewById(R.id.layout_root));
		checkBox = (CheckBox)layout.findViewById(R.id.check);
		checkBox.setOnCheckedChangeListener(this);
		textView = (TextView) layout.findViewById(R.id.textView1);
		lg_sf = (TextView)layout.findViewById(R.id.lg_SF);
		ID = (EditText) layout.findViewById(R.id.ID);
		PW = (EditText) layout.findViewById(R.id.PW);
	}

	private void setCancelButton() {
		dialog.setNegativeButton("취소", new DialogInterface.OnClickListener()
		{
			public void onClick(DialogInterface dialog, int which)
			{
				dialog.cancel();
			}
		});
	}

	private void setLoginButton(){
		dialog.setPositiveButton("로그인", new DialogInterface.OnClickListener()
		{
			public void onClick(DialogInterface dialog, int which)
			{
				String id = ID.getText().toString();
				String password = PW.getText().toString();
				
				//아이디나 비번 빈칸 일 때 버튼 누른경우
				if( id==null || password == null)
				{
					 
				}
				
				LoginHelper.doLogin(id,password);
				
				if( !sessionManager.isLogin() )
				{
					lg_sf.setText("로그인 실패");
					sessionManager.Init();
					return;
				}
				
				lg_sf.setText("로그인 성공");
				
				SharedPreferences pref = activity.getSharedPreferences("autologinyn", 0);
				SharedPreferences.Editor editor = pref.edit();
				editor.putString("ID", id);
				editor.putString("PW", password);
				editor.commit();
				
//				showDialog(2);
			}
		});
	}

	@Override
    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked)
	{
		String checkedStr = "";
		checkedStr= (isChecked)?"Yes" : "No";
		
		SharedPreferences pref = activity.getSharedPreferences("autologinyn", 0);
		SharedPreferences.Editor editor = pref.edit();
		
		if(checkedStr.equals("Yes")){
			editor.putString("AutoLogin", "Yes");
			editor.commit();
		}else
		{
			editor.putString("AutoLogin", "No");
			editor.commit();
		}
		checkBox.setText(checkedStr);
    }
	
	/*
	protected Dialog onCreateDialog(int i) {
		
		switch(i){
			case 1:
				return new AlertDialog.Builder(Login.this)
		        .setIcon(R.drawable.alert_dialog_icon)
		        .setTitle("아이디와  비밀번호를 입력해 주세요.")
		        .setPositiveButton("OK", new DialogInterface.OnClickListener() {
		            public void onClick(DialogInterface dialog, int whichButton) { 
		              //   User clicked OK so do some stuff 
		            }
		        })
		        .setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
		            public void onClick(DialogInterface dialog, int whichButton) {
	
		              //   User clicked Cancel so do some stuff 
		            }
		        })
		        .create();
				
			case 2:
		
				return new AlertDialog.Builder(Login.this)
		        .setIcon(R.drawable.alert_dialog_icon)
		        
		        
		        
//		        .setTitle(R.string.alert_dialog_two_buttons_msg + sessionManager.getOkid())
		        .setTitle(sessionManager.getOkid())
                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
		            public void onClick(DialogInterface dialog, int whichButton) { 
		              //   User clicked OK so do some stuff 
		            }
		        })
		        .setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
		            public void onClick(DialogInterface dialog, int whichButton) {
	
		             //    User clicked Cancel so do some stuff 
		            }
		        })
		        .create();
		} 
		return null;
	}*/
}