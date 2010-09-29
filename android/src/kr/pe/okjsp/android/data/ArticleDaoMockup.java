package kr.pe.okjsp.android.data;

import java.util.ArrayList;

import kr.pe.okjsp.Article;

public class ArticleDaoMockup implements ArticleDao {

    @Override
    public ArrayList<Article> getList() {
        
        ArrayList<Article> list = new ArrayList<Article>();
        for( int i = 0 ; i < 10 ; i++ )
        {
            Article article = new Article();
            article.setSeq(i);
            article.setId("글쓴이"+i);
            article.setSubject("제목입니다."+i);
            list.add(article);
        }
        
        return list;
    }

	@Override
	public ArrayList<Article> getList(String boardName, int page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Article get(String seq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Article> getComment(String boardName, int page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Article> getRecentList() {
		// TODO Auto-generated method stub
		return null;
	}
}
