package kr.pe.okjsp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.member.Member;
import kr.pe.okjsp.util.DbCon;

public class BookmarkServlet extends HttpServlet {
	DbCon dbCon = new DbCon();
	private static final long serialVersionUID = 3978708410894135602L;
	final static String QUERY_BOOKMARK_ADD =
		"insert into okboard_bookmark (id, seq, credate) values (?,?,SYSTIMESTAMP)";
	final static String QUERY_BOOKMARK_DELETE =
		"delete from okboard_bookmark where id = ? and seq = ?";
	final static String QUERY_BOOKMARK_LIST =
		"select a.seq, a.subject, b.credate from okboard a, okboard_bookmark b where a.seq = b.seq and b.id = ? order by b.credate desc";

  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }

  public void doGet(HttpServletRequest req, HttpServletResponse res)
                        throws IOException, ServletException {
    Member member = (Member)req.getSession().getAttribute("member");
    if (member == null || member.getId() == null || "".equals(member.getId())) {
    	res.sendRedirect("/jsp/member/login.jsp");
    	return;
    }
	Connection conn = null;
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	ArrayList list = new ArrayList();
	try {
		String id = member.getId();
		conn = dbCon.getConnection();
		pstmt = conn.prepareStatement(QUERY_BOOKMARK_LIST);
		pstmt.setString(1,id);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			Bookmark b = new Bookmark();
			b.setSeq(rs.getInt("seq"));
			b.setSubject(rs.getString("subject"));
			b.setCredate(rs.getTimestamp("credate"));
			list.add(b);
		}
		req.setAttribute("bookmark", list);
	} catch (Exception e) {
		System.out.println(e.toString());
	} finally {
		dbCon.close(conn, pstmt, rs);
	}

	req.getRequestDispatcher("/jsp/bookmark.jsp").forward(req, res);
  } // end doGet()

  public void doPost(HttpServletRequest req, HttpServletResponse res)
                        throws IOException, ServletException {
	Connection conn = null;
	PreparedStatement pstmt=null;
    String id      = "";
    int    seq     = 0;
    try {
        Member member = (Member)req.getSession().getAttribute("member");
    	id  = member.getId();
        seq = Integer.parseInt(req.getParameter("seq"));
    } catch(Exception e) {
    	id = "";
        System.out.println(getClass().getName() + ":" + e.toString());
    }
    if (!"".equals(id) && id != null) {
        try {
    		conn = dbCon.getConnection();
    	    String pact = req.getParameter("pact");

    	    if ("BOOKMARKDEL".equals(pact)) {
    	        pstmt = conn.prepareStatement(QUERY_BOOKMARK_DELETE);
    	    } else {
    	        pstmt = conn.prepareStatement(QUERY_BOOKMARK_ADD);
    	    }
            pstmt.setString(1, id);
            pstmt.setInt   (2, seq);
            pstmt.executeUpdate();
            pstmt.close();

        } catch(Exception e) {
            System.out.println(getClass().getName() + ":" + e.toString());
        } finally {
			dbCon.close(conn, pstmt);
        }
    }

    String togo = req.getHeader("referer");
    PrintWriter out = res.getWriter();
    res.setContentType("text/html");
    out.write("<META http-equiv=refresh content=\"0;url="+togo+"\">");
    out.close();

  } // end doPost()

}
