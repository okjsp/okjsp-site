package kr.pe.okjsp.android;

import java.util.ArrayList;

import kr.pe.okjsp.Article;
import kr.pe.okjsp.BbsInfoBean;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class BoardListActivity extends Activity
{
	private int navigation = 1;
	private ArrayList<BbsInfoBean> boardList = new ArrayList<BbsInfoBean>();
	private BoardListAdapter listAdapter;
	private ListView listView;
	
	private Thread networkThread;
	private Handler networkHandler;
	
	@Override
    public void onCreate(Bundle savedInstanceState)
	{
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		super.onCreate(savedInstanceState);
		setContentView(R.layout.boardlist);
		
		ActivityHelper.setNavigationBar(this,navigation);
		setInit();
		setListView();
		setHandler();
		startNetwork();
    }
	
	private void setInit()
	{
	}

	private void setListView()
	{
		listAdapter = new BoardListAdapter(this,R.layout.boardlist_list, boardList);
		listView = (ListView) findViewById(R.id.listView);
        listView.setAdapter(listAdapter);
        listView.setOnItemClickListener(new OnItemClickListener()
        {
			@Override
			public void onItemClick(AdapterView parent, View view, int position, long id)
			{
				BbsInfoBean bbsInfoBean = boardList.get(position);
				Intent intent = new Intent(getApplicationContext(), AbstractArticleListActivity.class);
				intent.putExtra("navigation",navigation);
				intent.putExtra("boardName",bbsInfoBean.getBbs());
				startActivity(intent);
				overridePendingTransition(0,0);
			}
		});
	}
	
	private void updateListView()
	{
		ActivityHelper.setHeaderProgressBar(this,false);
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
						ArrayList<BbsInfoBean> list = (ArrayList<BbsInfoBean>)msg.obj;
						boardList.addAll(list);
						updateListView();
						
						String message = "데이터 가져오기 완료";
						Toast.makeText(getApplicationContext(),message, Toast.LENGTH_SHORT).show();
					break;
					}
				}
			}
		};
	}
	
	private void startNetwork()
	{
		ActivityHelper.setHeaderProgressBar(this,true);
		BoardListService boardListService = new BoardListService();
		boardListService.setNetworkHandler(networkHandler);
		
		networkThread = new Thread(boardListService);
		networkThread.start();
	}
}