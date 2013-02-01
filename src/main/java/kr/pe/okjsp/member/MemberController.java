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
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
		String action = request.getParameter("act");

    	if ("fromEmail".equals(action)) {
			MemberService service = new MemberService();
			String email = request.getParameter("p");
			String token = request.getParameter("t");

			int result = service.validateParams(email, token);
			if (result == 1) {
				response.sendRedirect("/jsp/member/forgot/resetPassword.jsp?p=" +
						email + "&t=" + token);
			} else {
				request.getSession().setAttribute("msg", "유효하지 않은 링크입니다.");
				response.sendRedirect("/jsp/member/forgot/forgot.jsp");
			}
		}
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("act");
		if ("reset".equals(action)) {
			String email = request.getParameter("email");
			MemberService service = new MemberService();
			String[] result = service.sendRecoverPassword(email);
			if ("true".equals(result[0])) {
				response.sendRedirect("/jsp/member/forgot/reset.jsp?email="+email);
			} else {
				request.getSession().setAttribute("msg", result[1]);
				response.sendRedirect("/jsp/member/forgot/forgot.jsp");
			}
		} else if ("resetPassword".equals(action)) {
			String token = request.getParameter("t");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("confirmPassword");
			
			MemberService service = new MemberService();
			int result = service.changePassword(email, password, confirmPassword, token);
			response.sendRedirect("/jsp/member/forgot/resetEnd.jsp?email="+email+"&rc="+result);
		}
	}

}
