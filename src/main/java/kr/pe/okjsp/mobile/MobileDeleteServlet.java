package kr.pe.okjsp.mobile;

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

import kr.pe.okjsp.Article;
import kr.pe.okjsp.util.DbCon;
import kr.pe.okjsp.util.PropertyManager;

/**
 * ������ �Խù� ����
 * @author hwayoung.kang
 *
 */
public class MobileDeleteServlet extends HttpServlet {
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
		    seq ��ȣ ��������
		*/
		int seq = 0;
		
		//���� ������ ��� �ؾ� ���� ���......������κκ�
		String confirmPassword = req.getParameter("password");
		try {
			seq = Integer.parseInt(req.getParameter("seq"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*
		    db ��������
		*/
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Article article = new Article();
		try {
			conn = dbCon.getConnection();

			// �Խù� ��������
			pstmt = conn.prepareStatement(QUERY_PASSWORD);
			pstmt.setInt(1, seq);
			pstmt.setString(2, confirmPassword);

			rs = pstmt.executeQuery();
			int passwordCount = 0;
			if (rs.next()) {
				passwordCount++;
				article.setBbs(rs.getString("bbsid"));
			}

			rs.close();
			pstmt.close();

			// password Ȯ��
			if (confirmPassword.equals(MASTER_PASSWORD)
				|| passwordCount == 1 ) {
				// db���� ���� - ���� ���̺�� �̵�
				doQuery(conn, QUERY_MOVE, seq);
				doQuery(conn, QUERY_DELETE, seq);
				// memo ���� ����
				// file db���� ���� - sts �� 0 �� ����
				doQuery(conn, QUERY_DEL_SEQ_FILE, seq);
				// file ���� ����
				
			} else {
				throw new Exception("WRONG PASSWORD");
			}

		} catch (Exception e) {
			req.setAttribute("javax.servlet.jsp.jspException", e);
		} finally {
			dbCon.close(conn, pstmt, rs);
		}
		
		//�����ڿ� ȭ���� ���� �����ϴ°���...�ϴ� �ش� bbs ����Ʈ�� ����
		//req.getRequestDispatcher(resourceName+"?bbs="+req.getParameter("bbs")).forward(req, res);
		//req.getRequestDispatcher(resourceName+"?bbs="+req.getParameter("bbs")+"&act=MLIST").forward(req, res);
		//String togo = "/bbs?bbs="+req.getParameter("bbs")+"&act=MLIST";	//��ġ�߳� Ÿ��Ʋ�� ��� �ؾ� �ϳ� ��,.��
		String togo = "/m";
		res.sendRedirect(togo);

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
