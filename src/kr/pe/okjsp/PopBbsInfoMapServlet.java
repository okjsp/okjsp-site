/*
 * Created on 2003. 5. 1.
 *
 */
package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServlet;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

/**
 * @author kenu
 *
 * populate bbs information HashMap named bbsInfoMap on application scope 
 */
public class PopBbsInfoMapServlet extends HttpServlet {

	private static final long serialVersionUID = 4520095468646717761L;

	public void init() {

		HashMap bbsInfoMap = new HashMap();
		String query = "select cseq, bbsid, \"name\", header from okboard_info";
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		BbsInfoBean bbsInfoBean = null;
		DbCon dbCon = new DbCon();
		try {
			conn = dbCon.getConnection();
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				bbsInfoBean = new BbsInfoBean();
				bbsInfoBean.setCseq  (rs.getString("cseq"  ));
				bbsInfoBean.setBbs   (rs.getString("bbsid" ));
				bbsInfoBean.setName  (CommonUtil.a2k(rs.getString("name"  )));
				bbsInfoBean.setHeader(CommonUtil.a2k(rs.getString("header")));

				bbsInfoMap.put(bbsInfoBean.getBbs(), bbsInfoBean);
			} // end while
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			System.out.println("can't populate bbsInfoMap due to : "+e.toString());
			e.printStackTrace();
		} finally {
			dbCon.close(conn, pstmt, rs);
		} // end try catch
		
		// application scope¿¡ ³Ö¾îµÐ´Ù.
		getServletContext().setAttribute("bbsInfoMap", bbsInfoMap);
		System.out.println("populate bbsInfoMap : "+bbsInfoMap.size());
		
	}
}
