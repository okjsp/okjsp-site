package kr.pe.okjsp.mobile;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.MemoServlet;

public class MobileMemoServlet extends MemoServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 647882790485532153L;

	public void doPost(HttpServletRequest req, HttpServletResponse res)
                        throws IOException {
	    
	    req.setCharacterEncoding("utf-8");
	    
	    save(req, res);

	    res.sendRedirect("/bbs?act=MLIST&bbs="+req.getParameter("bbs"));
	} // end doPost()

}
