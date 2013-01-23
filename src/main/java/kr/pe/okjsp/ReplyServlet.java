package kr.pe.okjsp;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

public class ReplyServlet extends HttpServlet {

  public void doGet(HttpServletRequest req, HttpServletResponse res)
                        throws ServletException, IOException {
/*
    seq 번호 가져오기
*/
    int seq = 0;
    try {
        seq = Integer.parseInt(req.getParameter("seq"));
    } catch(Exception e) { e.printStackTrace(); }
/*
    db 가져오기
*/
    DbCon dbCon = new DbCon();
	Connection conn = null;
    try {
        conn = dbCon.getConnection();;

// 게시물 가져오기
		Article article = new ArticleDao().getArticle(seq, conn);
        article.setSubject(
            CommonUtil.rplc("Re:"+article.getSubject(), "Re:Re:", "Re:"));
        article.setSubject( CommonUtil.k2a(article.getSubject()) );
		article.setContent("");
		article.setPassword("");
	    article.setWriter(CommonUtil.getCookie(req, "okwriter"));
	    article.setEmail(CommonUtil.getCookie(req, "okemail"));
	    article.setHomepage(CommonUtil.getCookie(req, "okhome"));

        req.setAttribute("article", article);

    } catch(Exception e) {
        System.out.println("ReplyServlet err:"+seq+e.toString());
    } finally {
		dbCon.close(conn, null);
    }

    req.setAttribute("pact", "REPLY");
    req.getRequestDispatcher("/jsp/write.jsp").forward(req, res);

  } // end doGet()

}
