package kr.pe.okjsp.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberController
 */
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("act");
		if ("reset".equals(action)) {
			String email = request.getParameter("email");
			MemberService service = new MemberService();
			service.sendRecoverPassword(email);
			response.sendRedirect("/jsp/member/forgot/reset.jsp?email="+email);
		} else if ("resetPassword".equals(action)) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("confirmPassword");
			
			MemberService service = new MemberService();
			int result = service.changePassword(email, password, confirmPassword);
			response.sendRedirect("/jsp/member/forgot/resetEnd.jsp?email="+email+"&rc="+result);
		}
	}

}
