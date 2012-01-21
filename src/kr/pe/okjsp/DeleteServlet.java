package kr.pe.okjsp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.member.PointDao;
import kr.pe.okjsp.util.DbCon;
import kr.pe.okjsp.util.PropertyManager;

public class DeleteServlet extends HttpServlet {
	DbCon dbCon = new DbCon();
	private static final long serialVersionUID = 1L;
	public static final String QUERY_PASSWORD =
		"select \"password\", bbsid from okboard where seq = ? and \"password\" = old_password(?)";
	public static final String QUERY_MOVE =
		"insert into okboard_deleted select * from okboard where seq=?";
	public static final String QUERY_DELETE =
		"delete from okboard where seq=?";
	public static final String QUERY_DEL_SEQ_FILE =
		"update okboard_file set sts=0 where seq=?";
	private static String MASTER_PASSWORD = 
		PropertyManager.getString("MASTER_PASSWORD");;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		super.doGet(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {

		/*
		    seq 번호 가져오기
		*/
		int seq = 0;
		String resourceName = "/jsp/delete.jsp";
		String confirmPassword = req.getParameter("password");
		try {
			seq = Integer.parseInt(req.getParameter("seq"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*
		    db 가져오기
		*/
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbCon.getConnection();

			// 게시물 가져오기
			pstmt = conn.prepareStatement(QUERY_PASSWORD);
			pstmt.setInt(1, seq);
			pstmt.setString(2, confirmPassword);

			rs = pstmt.executeQuery();
			int passwordCount = 0;
			if (rs.next()) {
				passwordCount++;
			}

			rs.close();
			pstmt.close();
			
			Article article = new ArticleDao().getArticle(seq);

			// password 확인
			if (confirmPassword.equals(MASTER_PASSWORD)
				|| passwordCount == 1 ) {
				// db에서 삭제 - 삭제 테이블로 이동
				doQuery(conn, QUERY_MOVE, seq);
				doQuery(conn, QUERY_DELETE, seq);
				// memo 삭제 생략
				// file db에서 삭제 - sts 값 0 로 변경
				doQuery(conn, QUERY_DEL_SEQ_FILE, seq);
				// file 삭제 생략
				try {
					long sid = Long.parseLong(article.getId());
					new PointDao().log(sid, 3, -50, String.valueOf(article.getSeq()));
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				resourceName = "/jsp/error.jsp";
				throw new Exception("WRONG PASSWORD");
			}

		} catch (Exception e) {
			req.setAttribute("javax.servlet.jsp.jspException", e);
			resourceName = "/jsp/error.jsp";
		} finally {
			dbCon.close(conn, pstmt, rs);
		}
		req.getRequestDispatcher(resourceName+"?bbs="+req.getParameter("bbs")).forward(req, res);

	} // end doPost()

	private void doQuery(Connection conn, String query, int seq) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, seq);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(null, pstmt);
		}

	}

}
