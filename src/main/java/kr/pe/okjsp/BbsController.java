package kr.pe.okjsp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.util.CommonUtil;

public class BbsController extends HttpServlet {
	private static final long serialVersionUID = -1812823350032335626L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String url = req.getRequestURL().toString() + "?" + req.getQueryString();
		if (url.toLowerCase().contains("okjsp.pe.kr")) {
			url = url.replaceAll("okjsp.pe.kr", "okjsp.net");
			res.sendRedirect(url);
			return;
		} else {
			service(req, res);
		}
	}
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		long seq = CommonUtil.getNumberedSeq(req.getPathInfo());
		req.getRequestDispatcher("/bbs?seq="+seq).forward(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		service(req, res);
	}
}
