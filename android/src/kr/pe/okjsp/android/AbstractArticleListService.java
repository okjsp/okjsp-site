package kr.pe.okjsp.android;

import java.util.ArrayList;

import kr.pe.okjsp.Article;
import kr.pe.okjsp.android.data.ArticleDao;
import kr.pe.okjsp.android.data.ArticleDaoParsedHtml;
import android.os.Handler;
import android.os.Message;

public class AbstractArticleListService implements Runnable
{
	private boolean isRecentData = false;
	private Handler networkHandler;
	private ArticleDao articleDao = new ArticleDaoParsedHtml();
	private String boardName;
	private int page;
	
	@Override
	public void run()
	{
		ArrayList<Article> list = null;
		if(isRecentData())
		{
			if( page == 1 )
				list = articleDao.getRecentList();
			else
				list = new ArrayList<Article>();
		}
		else
			list = articleDao.getList(boardName,page);
			
		Message message = Message.obtain(networkHandler,0,list);
		networkHandler.sendMessage(message);
	}
	
	public void setNetworkHandler(Handler networkHandler) {
		this.networkHandler = networkHandler;
	}

	public Handler getNetworkHandler() {
		return networkHandler;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getBoardName() {
		return boardName;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPage() {
		return page;
	}

	public void setRecentData(boolean isRecentData) {
		this.isRecentData = isRecentData;
	}

	public boolean isRecentData() {
		return isRecentData;
	}
}