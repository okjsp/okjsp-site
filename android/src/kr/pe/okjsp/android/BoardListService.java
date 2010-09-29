package kr.pe.okjsp.android;

import java.util.ArrayList;

import kr.pe.okjsp.Article;
import kr.pe.okjsp.BbsInfoBean;
import kr.pe.okjsp.android.data.ArticleDao;
import kr.pe.okjsp.android.data.ArticleDaoParsedHtml;
import kr.pe.okjsp.android.data.BbsInfoDao;
import kr.pe.okjsp.android.data.BbsInfoDaoParsedHtml;
import android.os.Handler;
import android.os.Message;

public class BoardListService implements Runnable
{
	private Handler networkHandler;
	private BbsInfoDao bbsInfoDao = new BbsInfoDaoParsedHtml();
	
	@Override
	public void run()
	{
		ArrayList<BbsInfoBean> list = bbsInfoDao.getList();
		Message message = Message.obtain(networkHandler,0,list);
		networkHandler.sendMessage(message);
	}

	public void setNetworkHandler(Handler networkHandler) {
		this.networkHandler = networkHandler;
	}

	public Handler getNetworkHandler() {
		return networkHandler;
	}
}