package kr.pe.okjsp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyArticlesController extends HttpServlet {
	private static final long serialVersionUID = -1812823350032335626L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.getRequestDispatcher("/jsp/member/articlesByMe.jsp").forward(req,res);
	}
}
