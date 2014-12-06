package kr.pe.okjsp.mobile;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.DeleteServlet;
import kr.pe.okjsp.util.DbCon;

/**
 * 아이폰 게시물 삭제
 * @author hwayoung.kang
 *
 */
public class MobileDeleteServlet extends DeleteServlet {
	private static final long serialVersionUID = 1L;
	DbCon dbCon = new DbCon();

	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {

		saveArticle(req);
		
		//삭제뒤에 화면을 어디로 가아하는건지...일단 해당 bbs 리스트로 간다
		//req.getRequestDispatcher(resourceName+"?bbs="+req.getParameter("bbs")).forward(req, res);
		//req.getRequestDispatcher(resourceName+"?bbs="+req.getParameter("bbs")+"&act=MLIST").forward(req, res);
		//String togo = "/bbs?bbs="+req.getParameter("bbs")+"&act=MLIST";	//미치긋네 타이틀을 어떻게 해야 하나 ㅠ,.ㅠ
		res.sendRedirect("/m");

	} // end doPost()

}
