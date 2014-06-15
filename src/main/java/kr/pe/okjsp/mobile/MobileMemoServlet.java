package kr.pe.okjsp.mobile;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.MemoDao;
import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;
import kr.pe.okjsp.util.DomainUtil;
import kr.pe.okjsp.util.PropertyManager;

public class MobileMemoServlet extends HttpServlet {
	DbCon dbCon = new DbCon();
	private String MASTER_MEMO;
	private static final long serialVersionUID = 3617008659201077558L;
	final static String QUERY_MEMO_DEL =
		"delete from okboard_memo where memopass = old_password(?) and mseq = ?";
	final static String QUERY_MEMO_DEL2 =
		"delete from okboard_memo where mseq = ?";

	public void init(ServletConfig config) throws ServletException {
		MASTER_MEMO = PropertyManager.getString("MASTER_MEMO");
		super.init(config);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
                        throws IOException {
	    
	    req.setCharacterEncoding("utf-8");
	    
	    String writer  = null;
	    String bcomment= null;
	    String memopass= null;
	    String ip      = req.getRemoteAddr();
	    int    seq     = 0;

	    int    mseq     = 0;
	    String delpass= null;
	    String doubleCheck = getDoubleCheck(req);

		writer  = req.getParameter("writer");
        bcomment= req.getParameter("bcomment");
        memopass= req.getParameter("memopass");
        delpass = req.getParameter("delpass");
        try {
        	seq     = Integer.parseInt(req.getParameter("seq"));
	        if (req.getParameter("mseq") != null && !"".equals(req.getParameter("mseq"))) {
	        	mseq    = Integer.parseInt(req.getParameter("mseq"));
	        }
	    } catch(Exception e) {
	        System.out.println("MemoServlet:"+e.toString());
	    }

		/*
		 * db 입력
		 */
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			if (!"okjsp".equalsIgnoreCase(doubleCheck)) {
				throw new Exception("plz, help us.");
			}

			conn = dbCon.getConnection();
			conn.setAutoCommit(false);

			int memocnt = 0;
			MemoDao memoDao = new MemoDao();
			if (MASTER_MEMO.equals(delpass)) {
				// memo 삭제
				pstmt = conn.prepareStatement(QUERY_MEMO_DEL2);
				pstmt.setInt(1, mseq);
				memocnt = pstmt.executeUpdate();
				pstmt.close();
				memocnt = -memocnt;
			} else if (mseq > 0 && !"".equals(delpass)) {
				// memo 삭제
				pstmt = conn.prepareStatement(QUERY_MEMO_DEL);
				pstmt.setString(1, delpass);
				pstmt.setInt(2, mseq);
				memocnt = pstmt.executeUpdate();
				pstmt.close();
				memocnt = -memocnt;
			} else {
				// id cookie based
				long sid = CommonUtil.getCookieLong(req, "sid");
				String id = null;
				if (sid > 0) {
					id = CommonUtil.getCookie(req, "okid");
				}
				
				if( sid == 0 ) {
					sid = Long.parseLong( req.getParameter("sid") );
					id = req.getParameter("okid");
				}
				
				memocnt = memoDao.write(conn, id, sid, writer, bcomment,
						memopass, ip, seq);
				CommonUtil.setCookie(DomainUtil.getBaseDomain(req.getRequestURL()), res, "memo", "true", 525600);
			}

			memoDao.setCount(conn, seq, memocnt);
			conn.commit();

			CommonUtil.setCookie(DomainUtil.getBaseDomain(req.getRequestURL()), res, "okwriter", writer);
		} catch (Exception e) {
			System.out.println("MemoServlet:" + e.toString());
		} finally {
			dbCon.close(conn, pstmt);
		}

	    res.sendRedirect("/bbs?act=MLIST&bbs="+req.getParameter("bbs"));
	} // end doPost()

	private String getDoubleCheck(HttpServletRequest req) {
		String doubleCheck = null;
		try {
			doubleCheck = CommonUtil.getCookie(req, "memo");
		} catch (Exception e1) {
		}
		if ("true".equals(doubleCheck)) {
			doubleCheck = "okjsp";
		} else {
			doubleCheck = req.getParameter("doublecheck");
		}
		return doubleCheck;
	}

}
