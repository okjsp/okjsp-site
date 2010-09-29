package kr.pe.okjsp.android.data;

import java.util.ArrayList;

import kr.pe.okjsp.Article;
import kr.pe.okjsp.util.HttpClient;

public class ArticleDaoParsedHtml implements ArticleDao {
	
	@Override
    public ArrayList<Article> getList()
    {
		return getList("bbs3",1);
	}
	
	@Override
	public ArrayList<Article> getList(String boardName, int page)
	{
		ArrayList<Article> articleList = new ArrayList<Article>();
		
		// http://okjsp.pe.kr/bbs?act=LIST&bbs=bbs3&keyfield=content&keyword=&pg=1 페이지를 열어 HTML을 보면,
		// <tr class="body" align="center"> 의 반복된 구조임.
		// Split 한후 문자열을 가공
		// 0페이지 부터 시작함... 역시 개발자 사이트인가?
		String html = HttpClient.getContents("http://okjsp.pe.kr/bbs?act=LIST&bbs="+boardName+"&keyfield=content&keyword=&pg="+(page-1),"EUC-KR");
		parseHtmlForList(articleList, html);
		
		return articleList;
	}
	
	@Override
	public ArrayList<Article> getRecentList()
	{
		ArrayList<Article> articleList = new ArrayList<Article>();
		String html = HttpClient.getContents("http://okjsp.pe.kr/m/recentDetail.jsp","EUC-KR");
		parseHtmlRecent(articleList, html);
		
		return articleList;
	}

	private void parseHtmlRecent(ArrayList<Article> articleList, String html) {
		html = html.replaceAll("\n","");
		html = html.replaceAll("&nbsp;"," ");
		String[] list = html.split("<a href=");
		for( int i = 1 ; i < list.length-1  ; i++)
		{
			int startPos = 0;
			int endPos = 0;
			String ref = null;
			String subject = null;
			String writer = null;
			String when = null;
			
			String row = list[i];
			startPos = row.indexOf("seq=");
			endPos = row.indexOf("&mobileView=Y",startPos);
			if( startPos > -1 && endPos > -1 )
			{
				ref = row.substring(startPos+4,endPos);
				ref = ref.trim();
			}
			
			startPos = row.indexOf("target=\"_iui\">",endPos);
			endPos = row.indexOf("</a>",startPos);
			if( startPos > -1 && endPos > -1 )
			{
				subject = row.substring(startPos+14,endPos);
			}
			
			Article article = new Article();
            article.setSeq(Integer.parseInt(ref));
            article.setId("");
            article.setSubject(subject);
            article.setDate("");
            articleList.add(article);
		}
	}

	private void parseHtmlForList(ArrayList<Article> articleList, String html) {
		html = html.replaceAll("\n","");
		html = html.replaceAll("&nbsp;"," ");
		String[] list = html.split("<tr class=\"body\" align=\"center\">");
		for( int i = 1 ; i < list.length-1  ; i++)
		{
			int startPos = 0;
			int endPos = 0;
			String ref = null;
			String subject = null;
			String writer = null;
			String when = null;
			
			String row = list[i];
			startPos = row.indexOf("<a href=\"/seq/");
			endPos = row.indexOf("\"",startPos+14);
			if( startPos > -1 && endPos > -1 )
			{
				ref = row.substring(startPos+14,endPos);
				ref = ref.trim();
			}
			
			startPos = row.indexOf("\" >",endPos);
			endPos = row.indexOf("<span class=\"tiny\">",startPos);
			if( startPos > -1 && endPos > -1 )
			{
				subject = row.substring(startPos+3,endPos);
				subject = subject.trim();
				if( subject.length() > 24 )
					subject = subject.substring(0,20) + "...";
			}
			
			startPos = row.indexOf("<td class=\"writer\"><div>",startPos);
			endPos = row.indexOf("</div>",startPos);
			if( startPos > -1 && endPos > -1 )
			{
				writer = row.substring(startPos+24,endPos);
				writer = writer.trim();
			}
			
			startPos = row.indexOf("<td class=\"when tiny\" title=\"",startPos);
			endPos = row.indexOf("\">",startPos);
			if( startPos > -1 && endPos > -1 )
			{
				when = row.substring(startPos+29,endPos);
				when = when.trim();
				when = "20"+when;
			}
			
			Article article = new Article();
            article.setSeq(Integer.parseInt(ref));
            article.setId(writer);
            article.setSubject(subject);
            article.setDate(when);
            articleList.add(article);
		}
	}

	@Override
	public Article get(String seq) {
		
		String html = HttpClient.getContents("http://okjsp.pe.kr/seq/"+seq,"EUC-KR");
		int startPos = 0;
		int endPos = 0;
		
		String subject = null;
		String writer = null;
		String when = null;
		String contents = null;
		
		startPos = html.indexOf("<strong>",startPos);
		endPos = html.indexOf("</strong>",startPos);
		if( startPos > -1 && endPos > -1 )
		{
			writer = html.substring(startPos+8,endPos);
			writer = writer.trim();
		}
		
		startPos = html.indexOf("<div>",startPos);
		endPos = html.indexOf("</div>",startPos);
		if( startPos > -1 && endPos > -1 )
		{
			when = html.substring(startPos+5,endPos);
			when = when.trim();
		}
		
		startPos = html.indexOf("<b>",startPos);
		endPos = html.indexOf("</b>",startPos);
		if( startPos > -1 && endPos > -1 )
		{
			subject = html.substring(startPos+3,endPos);
			subject = subject.trim();
		}
		
		startPos = html.indexOf("<div id=\"centent\" class=\"wrap\">",startPos);
		endPos = html.indexOf("<div style=\"height:30px\"></div>",startPos);
		if( startPos > -1 && endPos > -1 )
		{
			contents = html.substring(startPos,endPos);
			contents = contents.trim();
		}
		
		Article article = new Article();
        article.setSeq(Integer.parseInt(seq));
        article.setId(writer);
        article.setSubject(subject);
        article.setContent(contents);
        article.setDate(when);
        
		return article;
	}

	@Override
	public ArrayList<Article> getComment(String boardName, int page) {
		// TODO Auto-generated method stub
		return null;
	}
}
