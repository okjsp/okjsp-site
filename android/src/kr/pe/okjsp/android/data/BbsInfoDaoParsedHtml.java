package kr.pe.okjsp.android.data;

import java.util.ArrayList;

import kr.pe.okjsp.BbsInfoBean;
import kr.pe.okjsp.util.HttpClient;

public class BbsInfoDaoParsedHtml implements BbsInfoDao {
	
	@Override
    public ArrayList<BbsInfoBean> getList()
    {
		ArrayList<BbsInfoBean> articleList = new ArrayList<BbsInfoBean>();
		String html = HttpClient.getContents("http://okjsp.pe.kr/bbs?act=LIST&bbs=TOOLqna","EUC-KR");
		
		int startPos = 0;
		int endPos = 0;
		
		startPos = html.indexOf("select id=\"bbslist\" onchange=\"jumpto(this)\" size=\"18\">");
		endPos = html.indexOf("</select>",startPos);
		if( startPos > -1 && endPos > -1 )
		{
			html = html.substring(startPos+54,endPos);
			html = html.replaceAll("\n|\t","");
			
			String[] array = html.split("<option value=\"");
			for( int i = 1 ; i < array.length - 1 ; i++ )
			{
				String string = array[i];
				endPos = string.indexOf("\"");
				String id = string.substring(0,endPos);
				id = id.trim();
				
				startPos = string.indexOf(">",endPos);
				endPos = string.indexOf("</option>",endPos);
				String name = string.substring(startPos+1,endPos);
				name = name.trim();
				
				BbsInfoBean bbsInfoBean = new BbsInfoBean();
				bbsInfoBean.setBbs(id);
				bbsInfoBean.setName(name);
				
				articleList.add(bbsInfoBean);
			}
		}
		
		return articleList;
	}
	
//
//	private void parseHtmlForList(ArrayList<Article> articleList, String html) {
//		html = html.replaceAll("\n","");
//		html = html.replaceAll("&nbsp;"," ");
//		String[] list = html.split("<tr class=\"body\" align=\"center\">");
//		for( int i = 1 ; i < list.length-1  ; i++)
//		{
//			int startPos = 0;
//			int endPos = 0;
//			String ref = null;
//			String subject = null;
//			String writer = null;
//			String when = null;
//			
//			String row = list[i];
//			startPos = row.indexOf("<a href=\"/seq/");
//			endPos = row.indexOf("\"",startPos+14);
//			if( startPos > -1 && endPos > -1 )
//			{
//				ref = row.substring(startPos+14,endPos);
//				ref = ref.trim();
//			}
//			
//			startPos = row.indexOf("\" >",endPos);
//			endPos = row.indexOf("<span class=\"tiny\">",startPos);
//			if( startPos > -1 && endPos > -1 )
//			{
//				subject = row.substring(startPos+3,endPos);
//				subject = subject.trim();
//				if( subject.length() > 24 )
//					subject = subject.substring(0,20) + "...";
//			}
//			
//			startPos = row.indexOf("<td class=\"writer\"><div>",startPos);
//			endPos = row.indexOf("</div>",startPos);
//			if( startPos > -1 && endPos > -1 )
//			{
//				writer = row.substring(startPos+24,endPos);
//				writer = writer.trim();
//			}
//			
//			startPos = row.indexOf("<td class=\"when tiny\" title=\"",startPos);
//			endPos = row.indexOf("\">",startPos);
//			if( startPos > -1 && endPos > -1 )
//			{
//				when = row.substring(startPos+29,endPos);
//				when = when.trim();
//				when = "20"+when;
//			}
//			
//			Article article = new Article();
//            article.setSeq(Integer.parseInt(ref));
//            article.setId(writer);
//            article.setSubject(subject);
//            article.setDate(when);
//            articleList.add(article);
//		}
//	}
}
