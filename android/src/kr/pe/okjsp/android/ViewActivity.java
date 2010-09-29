package kr.pe.okjsp.android;

import kr.pe.okjsp.Article;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Window;
import android.widget.TextView;
import android.widget.Toast;

public class ViewActivity extends Activity
{
	private String seq;
	private Article article;
	private Thread networkThread;
	private Handler networkHandler;
	
	private TextView subjectTextView;
	private TextView contentsTextView;
	
	@Override
    public void onCreate(Bundle savedInstanceState)
	{
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		super.onCreate(savedInstanceState);
		setContentView(R.layout.view);
		
		ActivityHelper.setNavigationBar(this,0);
		setInit();
		setHandler();
		startNetwork();
    }
	
	@Override
	protected void onDestroy()
	{
		super.onDestroy();
	}
	
	private void setInit()
	{
		Intent intent = getIntent();
		seq = intent.getExtras().get("seq").toString();
	}
	
	private void updateView()
	{
		ActivityHelper.setHeaderProgressBar(this,false);
		
		subjectTextView = (TextView)findViewById(R.id.subjectTextView);
		contentsTextView = (TextView)findViewById(R.id.contentsTextView);
		
		String contents = article.getContent();
		contents = contents.substring(31);
		contents = contents.replaceAll("<DIV>|<P>|</DIV>|</div>","");
		contents = contents.replaceAll("</P>|<BR>","\n");
		contents = contents.trim();
		
		subjectTextView.setText(article.getSubject());
		contentsTextView.setText(contents);
	}
	
	private void setHandler()
	{
		networkHandler = new Handler()
		{
			public void handleMessage(Message msg)
			{
				super.handleMessage(msg);
				
				if( msg != null )
				{
					switch (msg.what)
					{
					case 0:
						article = (Article)msg.obj;
						updateView();
//						String message = "데이터 가져오기 완료";
//						Toast.makeText(getApplicationContext(),message, Toast.LENGTH_SHORT).show();
					break;
					}
				}
			}
		};
	}
	
	private void startNetwork()
	{
		ActivityHelper.setHeaderProgressBar(this,true);
		ViewService viewService = new ViewService();
		viewService.setNetworkHandler(networkHandler);
		viewService.setSeq(seq);
		
		networkThread = new Thread(viewService);
		networkThread.start();
	}
}