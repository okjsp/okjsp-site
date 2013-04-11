package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.pe.okjsp.member.Member;
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
	
	public static final String MINUS_HATE_LIST = 
			" AND 0 = nvl(INSTR((SELECT hate_key FROM ok_hate WHERE sid = ?), ';'|| trim(ID) ||';') ,0) AND 0 = nvl( INSTR((SELECT hate_key FROM ok_hate WHERE sid = ?), ';'|| trim(WRITER) ||';') ,0)";

	public static final String ARTICLE_LIST_MINUS_HATE_LIST =
		"SELECT bbsid, seq, \"ref\", lev, subject, id, writer, hit, wtime, memo, content FROM okboard WHERE bbsid=? AND content LIKE ? "+ MINUS_HATE_LIST +" ORDER BY \"ref\" DESC, step for orderby_num() between ? and ?";

	public static final String ARTICLE_LIST =
			"SELECT bbsid, seq, \"ref\", lev, subject, id, writer, hit, wtime, memo, content FROM okboard WHERE bbsid=? AND content LIKE ? ORDER BY \"ref\" DESC, step for orderby_num() between ? and ?";

	public static final String ARTICLE_LIST_COUNT_MINUS_HATE_LIST =
			"SELECT COUNT(*), MAX(\"ref\") FROM okboard WHERE bbsid=? AND content LIKE ? "+ MINUS_HATE_LIST;
	
	public static final String ARTICLE_LIST_COUNT =
		"SELECT COUNT(*), MAX(\"ref\") FROM okboard WHERE bbsid=? AND content LIKE ? ";

	public static final String ARTICLE_LIST_RECENT =
		"SELECT bbsid, seq, \"ref\", lev, subject, id, writer, hit, wtime, memo, content FROM okboard WHERE bbsid=? ORDER BY seq DESC for orderby_num() between 1 and ?";

	public static final String ARTICLE_LIST_ALL_RECENT =
		"SELECT okboard.bbsid, seq, \"ref\", lev, subject, id, writer, hit, wtime, memo, content FROM okboard  ORDER BY seq DESC for orderby_num() between 1 and ?";
	
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
	public Collection getList(HttpServletRequest request) throws SQLException {
		
		long sid = 0L;
		
		try {
			HttpSession s = request.getSession();
			sid = ((Member)request.getSession().getAttribute("member")).getSid();
		} catch (Exception e) {
			//e.printStackTrace();
		}
		//System.out.println("sid :::::::: " + sid);
		
		setCnt(sid);

		ArrayList params = new ArrayList();
		params.add(bbs);
		if (!EMPTY_KEYWORD) {
			params.add("%"+keyword+"%");
		}
		
		String LIST_QUERY = "";
		//로그인시에만 ignore 쿼리바인딩
		if(sid != 0 ){
			params.add(sid);
			params.add(sid);
			LIST_QUERY = ARTICLE_LIST_MINUS_HATE_LIST;
		}
		//비로그인시 그냥 조회쿼리 수행
		else LIST_QUERY = ARTICLE_LIST;
		params.add(Integer.valueOf(pg*pageSize)+1);
		params.add(Integer.valueOf((pg+1)*pageSize));
		

		return getList(LIST_QUERY, params);
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
	public void setCnt(long sid) throws SQLException {
		Connection pconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			pconn = dbCon.getConnection();

			int tmpCount = 1;
			String sql = "";
			
			//로그인시에만 ignore 쿼리바인딩
			if(sid==0) sql = ARTICLE_LIST_COUNT;
			else sql = ARTICLE_LIST_COUNT_MINUS_HATE_LIST;
			
			if (EMPTY_KEYWORD) {
				pstmt = pconn.prepareStatement(
						CommonUtil.rplc(sql, 
								" AND content LIKE ?", 
								"" ) );
				pstmt.setString(tmpCount++,bbs);
			} else {
				pstmt = pconn.prepareStatement(
						CommonUtil.rplc(sql, "content", keyfield) );
				pstmt.setString(tmpCount++,bbs);
				pstmt.setString(tmpCount++,"%"+keyword+"%");	
			}
			
			//로그인시에만 ignore 쿼리바인딩
			if(sid!=0){
				pstmt.setLong(tmpCount++,sid);
				pstmt.setLong(tmpCount++,sid);
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
