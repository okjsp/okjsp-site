package kr.pe.okjsp.android.data;

import java.util.ArrayList;

import kr.pe.okjsp.Article;

public interface ArticleDao {
    public ArrayList<Article> getList();
    public ArrayList<Article> getList(String boardName,int page);
    public Article get(String seq);
    public ArrayList<Article> getComment(String boardName,int page);
    public ArrayList<Article> getRecentList();
}
