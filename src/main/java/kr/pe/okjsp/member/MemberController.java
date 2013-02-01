package kr.pe.okjsp.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

    	if ("forgot".equals(action)) {
    		request.getRequestDispatcher("/jsp/member/forgot/forgot.jsp").forward(request, response);
    	} else if ("fromEmail".equals(action)) {
			MemberService service = new MemberService();
			String email = request.getParameter("p");
			String token = request.getParameter("t");

			int result = service.validateParams(email, token);
			if (result == 1) {
				request.setAttribute("email", email);
				request.setAttribute("t", token);
				request.getRequestDispatcher("/jsp/member/forgot/resetPassword.jsp").forward(request, response);
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
		HttpSession session = request.getSession();
		if ("reset".equals(action)) {
			String email = request.getParameter("email");
			MemberService service = new MemberService();
			String[] result = service.sendRecoverPassword(email);
			if ("true".equals(result[0])) {
				response.sendRedirect("/jsp/member/forgot/reset.jsp?email="+email);
			} else {
				session.setAttribute("msg", result[1]);
				response.sendRedirect("/jsp/member/forgot/forgot.jsp");
			}
		} else if ("resetPassword".equals(action)) {
			String token = request.getParameter("t");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("confirmPassword");
			
			MemberService service = new MemberService();
			int result = service.changePassword(email, password, confirmPassword, token);
			if (result == 1) {
				session.setAttribute("msg", "비밀번호가 잘 변경되었습니다.");
			} else {
				session.setAttribute("msg", "변경되지 않았습니다. " +
						"<a href=\"mailto:kenu@okjsp.pe.kr\">kenu@okjsp.pe.kr</a>로 문의해주시기 바랍니다.");
			}
			response.sendRedirect("/jsp/member/forgot/resetEnd.jsp");
		}
	}

}
