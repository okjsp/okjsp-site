package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

/**
 * @author kenu
 *
 */
public class ListHandler {
	DbCon dbCon = new DbCon();

	public static final String ARTICLE_LIST =
		"SELECT bbsid, seq, \"ref\", lev, subject, id, writer, hit, wtime, memo, content FROM okboard WHERE bbsid=? AND content LIKE ? ORDER BY \"ref\" DESC, step for orderby_num() between ? and ?";

	public static final String ARTICLE_LIST_COUNT =
		"SELECT COUNT(*), MAX(\"ref\") FROM okboard WHERE bbsid=? AND content LIKE ?";

	public static final String ARTICLE_LIST_RECENT =
		"SELECT bbsid, seq, \"ref\", lev, subject, id, writer, hit, wtime, memo, content FROM okboard WHERE bbsid=? ORDER BY seq DESC for orderby_num() between 1 and ?";

	public static final String ARTICLE_LIST_ALL_RECENT =
		"SELECT okboard.bbsid, seq, \"ref\", lev, subject, id, writer, hit, wtime, memo, content FROM okboard ORDER BY seq DESC for orderby_num() between 1 and ?";
	
	public static final String ARTICLE_LIST_REF =
		"SELECT bbsid, seq, \"ref\", lev, subject, id, writer, hit, wtime, memo, content FROM okboard WHERE bbsid=? AND \"ref\"=? ORDER BY \"ref\" DESC, step";

	private String bbs;
	private String keyfield = "content";
	private String keyword = "";
	private boolean EMPTY_KEYWORD = true;
	private int cnt;
	private int pg;
	private int pageSize = 20;

	/**
	 * Method getList.
	 * @return Collection
	 * @throws SQLException
	 */
	public Collection getList() throws SQLException {
		setCnt();

		ArrayList params = new ArrayList();
		params.add(bbs);
		if (!EMPTY_KEYWORD) {
			params.add("%"+keyword+"%");
		}
		params.add(Integer.valueOf(pg*pageSize)+1);
		params.add(Integer.valueOf((pg+1)*pageSize));

		return getList(ARTICLE_LIST, params);
	}
	
	/**
	 * Method getRecentList.
	 * @param bbs
	 * @param size
	 * @return Collection
	 * @throws SQLException
	 */
	public Collection getRecentList(String bbs, int size) throws SQLException {
		this.bbs = bbs;

		ArrayList params = new ArrayList();
		params.add(bbs);
		params.add(Integer.valueOf(size));

		return getList(ARTICLE_LIST_RECENT, params);
	}
	
	CacheManager manager = CacheManager.create();
	/**
	 * Method getAllRecentList.
	 * @param size
	 * @return Collection
	 * @throws SQLException
	 */
	public Collection<Article> getAllRecentList(int size) throws SQLException {
		this.bbs = null;
		ArrayList<Object> params = new ArrayList<Object>();
		params.add(Integer.valueOf(size));
		
		if (!manager.cacheExists("testCache")) {
			manager.addCache("testCache");
		}
		Cache test = manager.getCache("testCache");
		Element element = test.get("all");
		Collection<Article> list = null;
		if (element == null) {
			list = getList(ARTICLE_LIST_ALL_RECENT, params);
			test.put(new Element("all", list));
		} else {
			list = (Collection<Article>) element.getObjectValue();
		}
		return list;
	}
	
	
	/**
	 * Method getRefList.
	 * @param bbs
	 * @param ref
	 * @return Collection
	 * @throws SQLException
	 */
	public Collection getRefList(String bbs, int ref) throws SQLException{
		this.bbs = bbs;
		
		ArrayList params = new ArrayList();
		params.add(bbs);
		params.add(Integer.valueOf(ref));

		return getList(ARTICLE_LIST_REF, params);
	}
	
	/**
	 * Sets the cnt.
	 */
	public void setCnt() throws SQLException {
		Connection pconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			pconn = dbCon.getConnection();

			// 게시물 수 가져오기
			if (EMPTY_KEYWORD) {
				pstmt = pconn.prepareStatement(
						CommonUtil.rplc(ARTICLE_LIST_COUNT, 
								" AND content LIKE ?", 
								"" ) );
				pstmt.setString(1,bbs);
			} else {
				pstmt = pconn.prepareStatement(
						CommonUtil.rplc(ARTICLE_LIST_COUNT, "content", keyfield) );
				pstmt.setString(1,bbs);
				pstmt.setString(2,"%"+keyword+"%");
			}

			rs = pstmt.executeQuery();
			if(rs.next()) {
				this.cnt = rs.getInt(1);
			}
		} catch(SQLException e) {
			System.out.println(e.toString());
			throw e;
		} finally {
			dbCon.close(pconn, pstmt, rs);
		}
	}

	/**
	 * Method getList.
	 * @param query
	 * @return Collection
	 * @throws SQLException
	 */
	public Collection<Article> getList(String query, ArrayList<Object> params) throws SQLException {
		ArrayList<Article> alist = new ArrayList<Article>(pageSize);

		Connection pconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;


		try{
			pconn = dbCon.getConnection();
			String queryList = null;
			int idxWhere = query.indexOf("WHERE ");
			if (idxWhere > 0) {
				String query1 = query.substring(0, idxWhere);
				String query2 = query.substring(idxWhere);
				
				// 게시물 목록 가져오기
				if (EMPTY_KEYWORD) {
					query2 = CommonUtil.rplc(query2,
							" AND content LIKE ?",
					"");
				}
				keyfield =  ("subject writer ip".indexOf(keyfield)==-1)
						? "content"
						: keyfield;
				queryList = query1 +
				CommonUtil.rplc(query2, "content", keyfield);
			} else {
				queryList = query;
			}
			pstmt = pconn.prepareStatement(queryList );

			for(int i = 0; i<params.size(); i++) {
				pstmt.setObject(i+1,params.get(i));
			}

			rs = pstmt.executeQuery();
			Article one = null;
			
			while(rs.next()) {
				one = new Article();

				one.setBbs(rs.getString("bbsid"));
				one.setSeq(rs.getInt("seq"));
				one.setRef(rs.getInt("ref"));
				one.setLev(rs.getInt("lev"));
				one.setSubject(CommonUtil.a2k(rs.getString("subject")));
				one.setId(rs.getString("id"));
				one.setWriter(CommonUtil.a2k(rs.getString("writer")));
				one.setWhen(rs.getTimestamp("wtime"));
				one.setRead(rs.getInt("hit"));
				one.setMemo(rs.getInt("memo"));
				one.setContent(CommonUtil.a2k(rs.getString("content")));
				
				alist.add(one);
			}
		} catch(SQLException e) {
			System.out.println(e.toString());
			throw e;
		} finally {
			dbCon.close(pconn, pstmt, rs);
		}
		    
		return alist;
	}

	/**
	 * Returns the bbs.
	 * @return String
	 */
	public String getBbs() {
		return bbs;
	}

	/**
	 * Returns the cnt.
	 * @return int
	 */
	public int getCnt() {
		return cnt;
	}

	/**
	 * Returns the keyfield.
	 * @return String
	 */
	public String getKeyfield() {
		return keyfield;
	}

	/**
	 * Returns the keyword.
	 * @return String
	 */
	public String getKeyword() {
		return keyword;
	}

	/**
	 * Returns the pageSize.
	 * @return int
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * Returns the pg.
	 * @return int
	 */
	public int getPg() {
		return pg;
	}

	/**
	 * Sets the bbs.
	 * @param bbs The bbs to set
	 */
	public void setBbs(String bbs) {
		this.bbs = bbs;
	}

	/**
	 * Sets the keyfield.
	 * @param keyfield The keyfield to set
	 */
	public void setKeyfield(String keyfield) {
		this.keyfield = keyfield;
	}

	/**
	 * Sets the keyword.
	 * useBean 에서 setter 호출시 charset encoding이 8859_1로 되는것 같음
	 * @param keyword The keyword to set
	 */
	public void setKeyword(String keyword) {
		this.keyword = CommonUtil.a2kProp(CommonUtil.nchk(keyword));
		EMPTY_KEYWORD = "".equals(keyword);
	}

	/**
	 * Sets the pageSize.
	 * @param pageSize The pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * Sets the pg.
	 * @param pg The pg to set
	 */
	public void setPg(int pg) {
		this.pg = pg;
	}

}
