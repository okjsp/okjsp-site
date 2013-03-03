package kr.pe.okjsp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import kr.pe.okjsp.member.PointDao;
import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

public class ArticleDao {
	DbCon dbCon = new DbCon();

	public static final String QUERY_NEW_SEQ =
		"select max(seq) from okboard";

	public static final String QUERY_NEW_SEQ_DELETED =
		"select max(seq) from okboard_deleted";

	public static final String QUERY_NEW_FILE_SEQ =
		"select max(fseq) from okboard_file";

	public static final String QUERY_ADD = 
		"insert into okboard (bbsid, seq, \"ref\", step, lev, id, writer, subject, content, \"password\", email, homepage, hit, memo, sts, wtime, ip, html, ccl_id) " +
		" values (?,?,?,0,0, ?,?,?,?,old_password(?),?,?,0,0,1, SYSTIMESTAMP, ?,?,?)";

	public static final String QUERY_NEW_REF =
		"select max(`ref`) from okboard where bbsid = ?";

	public static final String QUERY_NEW_REF_DELETED =
		"select max(`ref`) from okboard_deleted where bbsid = ?";
	
	public static final String QUERY_ADD_FILE =
		"insert into okboard_file (fseq, seq, filename, maskname, filesize, download) values (?,?,?,?,?,0)";
	
	public static final String QUERY_DEL_FSEQ_FILE =
		"update okboard_file set sts=0 where fseq=?";
	
	public static final String QUERY_ONE =
		"select  bbsid, seq, \"ref\", step, lev, id, writer, subject, \"password\", email, hit, html, homepage, wtime, ip, memo, content, ccl_id from okboard where seq = ?";

	public static final String QUERY_ONE_COUNTUP =
		"select  bbsid, seq, \"ref\", step, lev, id, writer, subject, \"password\", email, incr(hit), html, homepage, wtime, ip, memo, content, ccl_id from okboard where seq = ?";

	/**
	 * 해당번호의 게시물을 불러옵니다.
	 * 
	 * @param seq 게시물 번호
	 * @return Article 게시물
	 * @throws SQLException
	 */
	public Article getArticle(int seq) throws SQLException {
		DbCon dbCon = new DbCon();
		Connection pconn = null;
		try {
			pconn = dbCon.getConnection();
			return getArticle(seq, QUERY_ONE, pconn);
		} finally {
			dbCon.close(pconn, null);
		}
	}
	
	/**
	 * 해당번호의 조회수 1증가시키고 게시물을 불러옵니다.
	 * 
	 * @param seq 게시물 번호
	 * @param conn 커넥션
	 * @return Article 게시물
	 * @throws SQLException
	 */
	public Article getArticle(int seq, Connection conn) throws SQLException {
		return getArticle(seq, QUERY_ONE_COUNTUP, conn);
	}
	
	/**
	 * 지정한 게시물을 불러옵니다.
	 * @param seq
	 * @param sql
	 * @param conn
	 * @return {@link Article}
	 * @throws SQLException
	 */
	public Article getArticle(int seq, String sql, Connection conn) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Article article = new Article();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,seq);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				article.setBbs(rs.getString("bbsid"));
				article.setSeq(rs.getInt("seq"));
				article.setRef(rs.getInt("ref"));
				article.setStep(rs.getInt("step"));
				article.setLev(rs.getInt("lev"));
				article.setId(rs.getString("id"));
				article.setWriter(CommonUtil.a2k(rs.getString(7)));
				article.setSubject(CommonUtil.a2k(rs.getString(8)));
				article.setPassword(rs.getString(9));
				article.setEmail(CommonUtil.a2k(rs.getString(10)));
				article.setRead(rs.getInt(11));
				article.setHtml(rs.getString(12));
				article.setHomepage(CommonUtil.a2k(rs.getString(13)));
				article.setWhen(rs.getTimestamp(14));
				article.setIp(rs.getString(15));
				article.setMemo(rs.getInt(16));
				article.setContent(CommonUtil.a2k(rs.getString(17)));
				article.setCcl_id(rs.getString(18));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(null, pstmt, rs);
		}
	
		return article;
	} 
	/**
	 * <pre>
	 * okboard 입력
	 * </pre>
	 * @param conn
	 * @param article
	 * @return result record seq
	 */
	public int write(Connection conn, Article article) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(QUERY_ADD);
			int idx = 0;
			pstmt.setString(++idx, article.getBbs());
			pstmt.setInt   (++idx, article.getSeq());
			pstmt.setInt   (++idx, article.getRef());
			pstmt.setString(++idx, String.valueOf(article.getSid()));
			pstmt.setString(++idx, article.getWriter());
			pstmt.setString(++idx, article.getSubject());
			pstmt.setString(++idx, article.getContent());
			pstmt.setString(++idx, article.getPassword());
			pstmt.setString(++idx, article.getEmail());
			pstmt.setString(++idx, article.getHomepage());
			pstmt.setString(++idx, article.getIp());
			pstmt.setString(++idx, article.getHtml());
			pstmt.setString(++idx, article.getCcl_id());
			pstmt.executeUpdate();

			if (article.getSid() > 0) {
				new PointDao().log(article.getSid(), 2, 10, String.valueOf(article.getSeq()));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbCon.close(null, pstmt, rs);
		}
		return article.getSeq();
	}

	/**
	 * 답변
	 * @param conn
	 * @param article
	 * @return result count
	 */
	public int reply(Connection conn, Article article) {

		String query =
			"update okboard set step = step + 1 where bbsid = ? and \"ref\" = ? and step > ?";
		int result = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, article.getBbs());
			pstmt.setInt(2, article.getRef());
			pstmt.setInt(3, article.getStep());
			pstmt.executeUpdate();
			pstmt.close();

			query =
				"insert into okboard (bbsid, seq, \"ref\", step, lev, id, writer, "
					+ " subject, content, password, email, homepage, hit, memo, "
					+ " wtime, ip, html, ccl_id) values (?,?,?,?,?, ?,?,?,?,old_password(?), "
					+ " ?,?,0,0,SYSTIMESTAMP, ?,?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, article.getBbs());
			pstmt.setInt(2, article.getSeq());
			pstmt.setInt(3, article.getRef());
			pstmt.setInt(4, article.getStep() + 1);
			pstmt.setInt(5, article.getLev() + 1);
			pstmt.setString(6, String.valueOf(article.getSid()));
			pstmt.setString(7, article.getWriter());
			pstmt.setString(8, article.getSubject());
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getPassword());
			pstmt.setString(11, article.getEmail());
			pstmt.setString(12, article.getHomepage());
			pstmt.setString(13, article.getIp());
			pstmt.setString(14, article.getHtml());
			pstmt.setString(15, article.getCcl_id());
			result = pstmt.executeUpdate();
			if (article.getSid() > 0) {
				new PointDao().log(article.getSid(), 2, 10, String.valueOf(article.getSeq()));
			}
		} catch (SQLException e) {
			System.out.println(e.toString());
		} finally {
			dbCon.close(null, pstmt);
		}
		return result;
	}

	/**
	 * 수정
	 * @param conn
	 * @param article
	 * @return result count
	 */
	public int modify(Connection conn, Article article) {
		String query =
			"update okboard set writer=?, subject=?, content=?, \"password\"=old_password(?), email=?, homepage=?, wtime=SYSTIMESTAMP, ip=?, html=?, ccl_id=? where seq=?";
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getContent());
			pstmt.setString(4, article.getPassword());
			pstmt.setString(5, article.getEmail());
			pstmt.setString(6, article.getHomepage());
			pstmt.setString(7, article.getIp());
			pstmt.setString(8, article.getHtml());
			pstmt.setString(9, article.getCcl_id());
			pstmt.setInt(10, article.getSeq());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("ArticleDao err:" + e.toString());
		} finally {
			dbCon.close(null, pstmt);
		}
		return result;
	}

	/**
	 * ref 그룹번호 가져오기
	 * @param conn
	 * @param query
	 * @param bbs
	 * @return 게시물 그룹번호
	 * @throws SQLException
	 */
	public int fetchNewRef(Connection conn, String query, String bbs) throws SQLException {

		int newRef = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, bbs);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				newRef = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println(e.toString());
		} finally {
			dbCon.close(null, pstmt, rs);
		}

		return newRef + 1;
	}

	/**
	 * @param conn
	 * @return
	 * @throws SQLException
	 */
	DaoUtil daoUtil = new DaoUtil();
	public int getSeq(Connection conn) throws SQLException {
		return Math.max(
			daoUtil.getNumber(conn, QUERY_NEW_SEQ), 
			daoUtil.getNumber(conn, QUERY_NEW_SEQ_DELETED)
		);
	}

	/**
	 * @param conn
	 * @param bbs
	 * @return
	 * @throws SQLException
	 */
	public int getNewRef(Connection conn, String bbs) throws SQLException {
		return Math.max(
			fetchNewRef(conn, QUERY_NEW_REF, bbs),
			fetchNewRef(conn, QUERY_NEW_REF_DELETED, bbs)
		);
	}

	/**
	 * <pre>
	 * 파일 추가
	 * # 20091017 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 * </pre>
	 * @param conn
	 * @param seq
	 * @param arrdf
	 * @throws SQLException
	 */
	public void addFile(Connection conn, int seq, ArrayList<DownFile> arrdf)
			throws SQLException {
		// file 일련번호
		int fseq = daoUtil.getNumber(conn, QUERY_NEW_FILE_SEQ);

		// file 입력
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(QUERY_ADD_FILE);
			DownFile df;
			for (int i = 0; i < arrdf.size(); i++) {
				df = arrdf.get(i);
				if (df.getFileSize() > 0) {
					pstmt.clearParameters();

					pstmt.setInt(1, fseq);
					pstmt.setInt(2, seq);
					pstmt.setString(3, df.getFileName());
					pstmt.setString(4, df.getMaskName());
					pstmt.setLong(5, df.getFileSize());

					pstmt.executeUpdate();
					fseq++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(null, pstmt);
		}

	}

	public void deleteFiles(Connection conn, String[] fseqs) {
		if (fseqs == null)
			return;

		PreparedStatement pstmt = null;
		try {
			// file db에서 삭제 - sts 값 0 로 변경
			pstmt = conn.prepareStatement(QUERY_DEL_FSEQ_FILE);
			for (int i = 0; i < fseqs.length; i++) {
				pstmt.clearParameters();

				pstmt.setString(1, fseqs[i]);

				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(null, pstmt);
		}

		// file 삭제 생략

	}
	public int write(Article article) throws IOException {
		DbCon dbCon = new DbCon();
		Connection conn = null;
		int result = 0;
		try {
			conn = dbCon.getConnection();
			
			if ("recruit".equals(article.getBbs())) {
				checkSpam(conn, "recruit", String.valueOf(article.getSid()));
			}
			
			if (CommonUtil.nchk(article.getSubject()).trim().equals("")) {
				throw new IOException("No Subject");
			}
			
			conn.setAutoCommit(false);

			article.setSeq(getSeq(conn));
			article.setRef(getNewRef(conn, article.getBbs()));

			result = write(conn, article);
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			System.out.println("write err: "+e);
		} catch (IOException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw e;
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			dbCon.close(conn, null);
		}

		return result;
	}

	public void checkSpam(Connection conn, String bbs, String sid) throws IOException {

		String sql = "select count(*) FROM okboard WHERE bbsid = ? and id = ? and wtime > (sysdate - 2)";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isSpam = false;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbs);
			pstmt.setString(2, sid);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				isSpam = rs.getInt(1) >= 2;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbCon.close(null, pstmt, rs);
		}
		if (isSpam) throw new IOException("Too Many Post");

	}
	
	public int[] getAdList() {
		ArrayList<Integer> list = new ArrayList<Integer>();
		String sql = "select * from okboard_ad where startdate < sysdatetime and enddate > sysdatetime order by priority desc";
		DbCon dbCon = new DbCon();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbCon.getConnection();
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getInt("seq"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbCon.close(conn, pstmt, rs);
		}
		
		int[] ads = new int[list.size()];
		int i = 0;
		for(Integer seq : list) {
			ads[i] = seq;
			i++;
		}

		return ads;
	}

	public Collection<Article> getArticleListBySid(Connection conn, long sid) throws SQLException {
		String sql = "select * from okboard where id = ? order by seq desc";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, String.valueOf(sid));
		
		ResultSet rs = pstmt.executeQuery();
		
		ArrayList<Article> list = new ArrayList<Article>();
		
		while(rs.next()) {
			Article article = new Article();
			article.setSeq(rs.getInt("seq"));
			
			list.add(article);
		}
		
		rs.close();
		
		pstmt.close();
		
		return list;
	}

	public int delete(long seq) {
		String sql = "delete from okboard where seq = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = dbCon.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, seq);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

}
