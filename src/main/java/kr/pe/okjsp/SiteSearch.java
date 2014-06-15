/*
 * Created on 2003. 4. 28.
 *
 */
package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

/**
 * @author  kenu  게시판 별로 검색 결과 게시물수를 구하는 클래스
 */
public class SiteSearch {
	/**
	 * @uml.property  name="keyfield"
	 */
	private String keyfield;
	/**
	 * @uml.property  name="keyword"
	 */
	private String keyword;
    private static String QUERY_SITE_SEARCH = 
			"select okboard.bbsid, count(*) cnt from okboard " +
			" join okboard_info " +
			" on okboard.bbsid = okboard_info.bbsid " +
			" and okboard.content like ? " +
			" and okboard_info.cseq = 1 group by okboard.bbsid";

    public Collection<BbsInfoBean> searchContentWith(String keyword) throws Exception {
		if (keyword==null || keyword.length()<2) {
			throw new Exception("검색어는 두 글자 이상입니다.");
		}
		
		DbCon dbCon = new DbCon();

		List<BbsInfoBean> list = new LinkedList<BbsInfoBean>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		keyfield =  (keyfield==null || "subject writer".indexOf(keyfield)==-1)
					? "content"
					: keyfield;

		try{
			conn = dbCon.getConnection();

			// 게시물 목록 가져오기
			pstmt = conn.prepareStatement(
							CommonUtil.rplc(QUERY_SITE_SEARCH, "content", keyfield) );

			pstmt.setString(1, '%'+keyword+'%');
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(new BbsInfoBean(rs.getString(1), rs.getInt(2)));
			}
			rs.close();
			pstmt.close();

		} catch (SQLException e) {
			throw e;
		} finally {
			dbCon.close(conn, pstmt, rs);
		}

		return list;
   	
    }
    
    /**
     * 사이트 검색 결과를 반환합니다.
     * @return Collection
     * @throws Exception
     */
    public Collection<BbsInfoBean> getResult() throws Exception {
		return searchContentWith(this.keyword);

	}

	/**
	 * @return  keyfield
	 * @uml.property  name="keyfield"
	 */
	public String getKeyfield() {
		return CommonUtil.nchk(keyfield, "subject");
	}

	/**
	 * @return  keyword
	 * @uml.property  name="keyword"
	 */
	public String getKeyword() {
		return keyword;
	}

	/**
	 * @return keywordKor
	 */
	public String getKeywordKor() {
		return CommonUtil.a2k(keyword);
	}

	/**
	 * @param  string
	 * @uml.property  name="keyfield"
	 */
	public void setKeyfield(String string) {
		keyfield = string;
	}

	/**
	 * @param  string
	 * @uml.property  name="keyword"
	 */
	public void setKeyword(String string) {
		keyword = string;
	}

}
