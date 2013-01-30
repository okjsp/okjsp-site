package kr.pe.okjsp.mobile;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.Article;
import kr.pe.okjsp.ArticleDao;
import kr.pe.okjsp.member.Member;

/**
 * ����ϱ۾���_�ѱ� ���������� �и��ؼ� ���� ����
 * @author hwayoung.kang
 *
 */
public class MobileWriteServlet extends HttpServlet {

	private static final long serialVersionUID = 4181913566227354988L;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws IOException, ServletException {
		String bbs;
		
		req.setCharacterEncoding("utf-8");
		bbs = write(req, res);
	    
	    //�� �ۼ� �Ϸ�� ȭ���� ���� �̵��ؾ� ���� ���....
	    //String togo = "/bbs?act=MLIST&bbs="+bbs;
	    String togo = "/m";
		//res.sendRedirect(togo);
	    
	    res.sendRedirect("/bbs?act=MLIST&bbs="+bbs);

	} // end doPost()

	private String write(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Member member = (Member)req.getSession().getAttribute("member");
		String id  = member.getId();
		long sid = member.getSid();
		
		Article article = new Article();
		article.setId(id);
		article.setSid(sid);
		String writer = req.getParameter("writer");
		String bbs = req.getParameter("bbs");
		String content = req.getParameter("content");
		String subject = req.getParameter("subject");
		String homepage = req.getParameter("homepage");
		String password = req.getParameter("password");
		String ccl_id = req.getParameter("ccl_id");

		article.setWriter(writer);
		article.setBbs(bbs);
		article.setContent(content);
		article.setSubject(subject);
		article.setHomepage(homepage);
		article.setPassword(password);
		article.setCcl_id(ccl_id);
		
		new ArticleDao().write(article);
		
		return article.getBbs();
	}

	public boolean hasNothing(Article article) {
		boolean hasNothing = article.getSubject() == null
				|| "".equals(article.getSubject().trim())
				|| article.getContent() == null
				|| "".equals(article.getContent().trim())
				|| article.getBbs() == null
				|| "".equals(article.getBbs().trim())
				;
		return hasNothing;
	}

}
