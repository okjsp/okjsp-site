package kr.pe.okjsp.android;

import java.util.ArrayList;

import kr.pe.okjsp.Article;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class AbstractArticleListActivity extends Activity implements OnScrollEndListener
{
	private String boardName = "bbs3";
	private int page = 1;
	
	private boolean isEnded = false;
	private boolean isNetworkProcess = false;
	private boolean isRecentData = false;
	
	private ArrayList<Article> articleList = new ArrayList<Article>();
	private AbstractArticleListAdapter listAdapter;
	private ListView listView;
	
	private AbstractArticleListService service = new AbstractArticleListService();
	private Thread networkThread;
	private Handler networkHandler;
	
	@Override
    public void onCreate(Bundle savedInstanceState)
	{
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		super.onCreate(savedInstanceState);
		setContentView(R.layout.home);
		
		setInit();
		setListView();
		setHandler();
		startNetwork();
    }
	
	private void setInit()
	{
		page = 1;
		
		Object object = ActivityHelper.getParameter(this,"boardName");
		if( object != null )
			setBoardName((String)object);
		
		object = ActivityHelper.getParameter(this,"navigation");
		if( object != null )
			ActivityHelper.setNavigationBar(this,(Integer)object);
		else
			ActivityHelper.setNavigationBar(this,0);
	}
	
	private void setListView()
	{
		listAdapter = new AbstractArticleListAdapter(this,R.layout.home_list, articleList);
		listView = (ListView) findViewById(R.id.listView);
        listView.setAdapter(listAdapter);
        listView.setOnScrollListener(new OnScrollAbstractListener(this,this));
        listView.setOnItemClickListener(new OnItemClickListener()
        {
			@Override
			public void onItemClick(AdapterView parent, View view, int position, long id)
			{
				Article article = articleList.get(position);
				if( article == null )
					return;
				
				Intent intent = new Intent(getApplicationContext(), ViewActivity.class);
				intent.putExtra("seq",Integer.toString(article.getSeq()));
				startActivity(intent);
				overridePendingTransition(0,0);
			}
		});
	}
	
	private void updateListView()
	{
		listAdapter.notifyDataSetChanged();
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
						ArrayList<Article> list = (ArrayList<Article>)msg.obj;
						if( list.size() > 0 )
						{
							articleList.addAll(list);
							updateListView();
							
//							String message = page + "페이지 가져오기 완료";
//							Toast.makeText(getApplicationContext(),message, Toast.LENGTH_SHORT).show();
							page++;
						}
						else
						{
							setEnded(true);
						}
						
						ActivityHelper.setHeaderProgressBar(AbstractArticleListActivity.this,false);
						setProcess(false);
						
					break;
					}
				}
			}
		};
	}
	
	private void startNetwork()
	{
		if( isEnded() )
			return;
		
		ActivityHelper.setHeaderProgressBar(this,true);
		setProcess(true);
		service.setNetworkHandler(networkHandler);
		service.setBoardName(getBoardName());
		service.setPage(page);
		service.setRecentData(isRecentData());
		
		networkThread = new Thread(service);
		networkThread.start();
	}
	
	@Override
	public void onEndProcess() {
		startNetwork();
	}

	@Override
	public boolean isProcess() {
		return isNetworkProcess;
	}

	@Override
	public void setProcess(boolean isProcess) {
		isNetworkProcess = isProcess;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getBoardName() {
		return boardName;
	}

	@Override
	public boolean isEnded() {
		return isEnded;
	}

	public void setEnded(boolean isEnded) {
		this.isEnded = isEnded;
	}

	public void setRecentData(boolean isRecentData) {
		this.isRecentData = isRecentData;
	}

	public boolean isRecentData() {
		return isRecentData;
	}
}
