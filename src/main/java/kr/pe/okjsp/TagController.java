package kr.pe.okjsp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TagController extends HttpServlet {
	private static final long serialVersionUID = -1812823350032335626L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		int tagseq = 0;
		try {
			tagseq = new TagHandler().findTagseqByTag(pathInfo.substring(1));
			req.getRequestDispatcher("/jsp/taglist.jsp?tagseq="+tagseq).forward(req,res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
