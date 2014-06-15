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

import kr.pe.okjsp.member.Member;
import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

public class ViewServlet extends HttpServlet {

	private static final long serialVersionUID = 6039563891534443020L;
	public static final String QUERY_FILE =
		"select  fseq, filename, maskname, filesize, download  from okboard_file where seq = ? and sts = 1";
	/**
	 *  CUBRID incr() 함수 사용.
	 */
	@Deprecated
	public static final String QUERY_COUNT_UP =
		"update okboard set hit = hit + 1 where seq = ?";
	public static final String QUERY_PREV =
		"select seq, subject from okboard where bbsid=? and \"ref\" < ? and \"ref\" > ?-100 order by \"ref\" desc for orderby_num() = 1";
	public static final String QUERY_NEXT =
		"select seq, subject from okboard where bbsid=? and \"ref\" > ? and rownum = 1";

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		DbCon dbCon = new DbCon();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String viewMode = CommonUtil.nchk(req.getParameter("viewMode"),"W");
		String resultPage = null;
		
		ArrayList<DownFile> arrdf;

		/*
		    seq 번호 가져오기
		*/
		int seq = 0;
		try {
			seq = Integer.parseInt(req.getParameter("seq"));
		} catch (Exception e) {

		}
		/*
		    db 가져오기
		*/
		try {
			conn = dbCon.getConnection();

			// 게시물 가져오기
			Article one = new ArticleDao().getArticle(seq, conn);
			// email filtering
			one.setEmail(CommonUtil.rplc(one.getEmail(), "@", "&#64;"));
			one.setContent(CommonUtil.rplc(one.getContent(), "@", "&#64;"));

            String bbs = one.getBbs();
			boolean valid = new BbsRoleHandler().getPermission((Member)req.getSession().getAttribute("member"), bbs);

            if (valid) {
    			req.setAttribute("one", one);
            } else {
            	res.sendRedirect("/jsp/member/login.jsp");
            }

			// file list 가져오기
			arrdf = new ArrayList<DownFile>();
			pstmt = conn.prepareStatement(QUERY_FILE);
			pstmt.setInt(1, seq);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				arrdf.add(
					new DownFile(
						rs.getInt(1),
						CommonUtil.a2k(rs.getString(2)),
						rs.getString(3),
						rs.getLong(4),
						rs.getInt("download")));
			}
			rs.close();
			pstmt.close();

			req.setAttribute("arrdf", arrdf);

			// 조회수 증가하기
			/*pstmt = conn.prepareStatement(QUERY_COUNT_UP);
			pstmt.setInt(1, seq);

			pstmt.executeUpdate();
			pstmt.close();*/

			// 이전글 번호 가져오기
			pstmt = conn.prepareStatement(QUERY_PREV);
			pstmt.setString(1, bbs);
			pstmt.setInt   (2, one.getRef());
			pstmt.setInt   (3, one.getRef());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				req.setAttribute("prevSeq", rs.getString("seq"));
				req.setAttribute("prevSubject", 
						CommonUtil.a2k(CommonUtil.rplc(rs.getString("subject"), "{", "&#123;")));
			}
			rs.close();
			pstmt.close();

			// 다음글 번호 가져오기
			pstmt = conn.prepareStatement(QUERY_NEXT);
			pstmt.setString(1, bbs);
			pstmt.setInt   (2, one.getRef());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				req.setAttribute("nextSeq", rs.getString("seq"));
				req.setAttribute("nextSubject", 
						CommonUtil.a2k(CommonUtil.rplc(rs.getString("subject"), "{", "&#123;")));
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println("ViewServlet err:" + seq + "|" + e.toString());
		} finally {
			dbCon.close(conn, pstmt, rs);
		}

		// Web 상세보기와 Mobile 상세보기 구분
		if ( "IUI".equals(viewMode) ) {
			resultPage = "/iui/view.jsp";	
		} else if ( "JQM".equals(viewMode) ) {
			resultPage = "/jqm/view.jsp";
		} else {
			resultPage = "/jsp/view.jsp";	
		}
		
		req.getRequestDispatcher(resultPage).forward(req, res);

	} // end doGet()
}