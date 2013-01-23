package kr.pe.okjsp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

public class ModifyServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }

  public void doGet(HttpServletRequest req, HttpServletResponse res)
                        throws ServletException, IOException {
  }

  DbCon dbCon = new DbCon();
  public void doPost(HttpServletRequest req, HttpServletResponse res)
                        throws ServletException, IOException {

/*
    seq 번호 가져오기
*/
    int seq = 0;
    String resourceName = "/jsp/write.jsp";
    String confirmPassword = req.getParameter("password");
    try {
        seq = Integer.parseInt(req.getParameter("seq"));
    } catch(Exception e) {

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
		Article one = new ArticleDao().getArticle(seq, conn);
        one.setWriter (one.getWriter ());
        one.setSubject(CommonUtil.k2a(one.getSubject()));
        one.setContent(CommonUtil.k2a(one.getContent()));
        one.setHomepage(CommonUtil.k2a(one.getHomepage()));

// password 확인
        if(getEncryptedString(confirmPassword, conn).equals(one.getPassword())) {
            req.setAttribute("article", one);
        } else {
            resourceName = "/jsp/error.jsp";
            throw new Exception("WRONG PASSWORD");
        }

// file list 가져오기
        ArrayList arrdf = new ArrayList();
        String query=  "select  FSEQ, FILENAME, MASKNAME, FILESIZE, DOWNLOAD " +
                " from okboard_file where sts>0 and seq = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1,seq);

        rs = pstmt.executeQuery();
        while (rs.next()) {
            arrdf.add(new DownFile(rs.getInt(1), CommonUtil.a2k(rs.getString(2)), rs.getString(3),
                                   rs.getLong(4), rs.getInt(1)
                                  ) );
        }
        rs.close();
        pstmt.close();

        req.setAttribute("arrdf", arrdf);

    } catch(Throwable t) {
        req.setAttribute("javax.servlet.jsp.jspException", t);
        System.out.println("ModifyServlet err:"+seq+"|"+t.toString());
    } finally {
		dbCon.close(conn, pstmt, rs);
    }

    req.setAttribute("pact", "MODIFY");
    req.getRequestDispatcher(resourceName).forward(req, res);

  } // end doPost()

	private String getEncryptedString(String confirmPassword, Connection conn) {
		if (conn == null) {
			return confirmPassword;
		}
		String cryptedString = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select old_password(?) from db_root";
			pstmt = conn.prepareStatement(sql );
			pstmt.setString(1, confirmPassword);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cryptedString = rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(null, pstmt, rs);
		}
		return cryptedString;
	}

}
