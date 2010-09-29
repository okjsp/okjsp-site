package kr.pe.okjsp.android;

import kr.pe.okjsp.Article;
import kr.pe.okjsp.android.data.ArticleDao;
import kr.pe.okjsp.android.data.ArticleDaoParsedHtml;
import android.os.Handler;
import android.os.Message;

public class ViewService implements Runnable
{
	private Handler networkHandler;
	private ArticleDao articleDao = new ArticleDaoParsedHtml();
	private String seq;
	
	@Override
	public void run()
	{
		Article article = articleDao.get(seq);
		Message message = Message.obtain(networkHandler,0,article);
		networkHandler.sendMessage(message);
	}

	public void setNetworkHandler(Handler networkHandler) {
		this.networkHandler = networkHandler;
	}

	public Handler getNetworkHandler() {
		return networkHandler;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getSeq() {
		return seq;
	}
}