package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.pe.okjsp.member.PointDao;
import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

public class ArticleDao {
	DbCon dbCon = new DbCon();
	/**
	 * @deprecated 20091017 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 */
	public static final String QUERY_NEW_SEQ =
		"select seq+1 from okboard order by seq desc limit 0,1";
	/**
	 * @deprecated 20091017 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 */
	public static final String QUERY_NEW_SEQ_DELETED =
		"select seq+1 from okboard_deleted order by seq desc limit 0,1";
	/**
	 * @deprecated 20091017 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 */
	public static final String QUERY_NEW_FILE_SEQ =
		"select fseq+1 from okboard_file order by fseq desc limit 0,1";
	/**
	 * @deprecated 20091017 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 */
	public static final String QUERY_NEW_REF =
		"select ref+1 from okboard where bbsid = ? order by ref desc limit 0,1";
	/**
	 * @deprecated 20091017 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 */
	public static final String QUERY_NEW_REF_DELETED =
		"select ref+1 from okboard where bbsid = ? order by ref desc limit 0,1";
	public static final String QUERY_ADD_FILE =
		"insert into okboard_file (seq, filename, maskname, filesize, download) values (?,?,?,?,0)";
	public static final String QUERY_DEL_FSEQ_FILE =
		"update okboard_file set sts=0 where fseq=?";
	public static final String QUERY_ONE =
		"select  bbsid, seq, \"ref\", step, lev, id, writer, subject, \"password\", email, hit, html, homepage, wtime, ip, memo, content, ccl_id from okboard where seq = ?";
	/**
	 * 해당번호의 게시물을 불러옵니다.
	 * 
	 * @param seq 게시물 번호
	 * @param conn 커넥션
	 * @return Article 게시물
	 * @throws SQLException
	 */
	public Article getArticle(int seq, Connection conn) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Article article = new Article();
		try {
			pstmt = conn.prepareStatement(QUERY_ONE);
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
	 * okboard 입력
	 * @param conn
	 * @param article
	 * @return result record count
	 */
	public int write(Connection conn, Article article) {
		String query =
			"insert into okboard (bbsid, step, lev, id, writer,subject, content, \"password\", email, homepage, hit, memo, sts,wtime, ip, html, ccl_id) values (?,0,0, ?,?,?,?,old_password(?),?,?,0,0,1, SYSTIMESTAMP, ?,?,?)";
		PreparedStatement pstmt = null;
		int result = 0;
		String seq = "";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, article.getBbs());
			pstmt.setString(2, article.getId());
			pstmt.setString(3, article.getWriter());
			pstmt.setString(4, article.getSubject());
			pstmt.setString(5, article.getContent());
			pstmt.setString(6, article.getPassword());
			pstmt.setString(7, article.getEmail());
			pstmt.setString(8, article.getHomepage());
			pstmt.setString(9, article.getIp());
			pstmt.setString(10, article.getHtml());
			pstmt.setString(11, article.getCcl_id());
			result = pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				seq = rs.getString(1);
			}
			
			if (article.getSid() > 0) {
				new PointDao().log(article.getSid(), 2, 10, seq);
				article.setSeq(Integer.parseInt(seq));
			}
		} catch (SQLException e) {
			System.out.println(e.toString());
		} finally {
			dbCon.close(null, pstmt, rs);
		}
		return result * article.getSeq();
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
				"insert into okboard (bbsid, seq, ref, step, lev, writer, "
					+ " subject, content, password, email, homepage, hit, memo, "
					+ " wtime, ip, html, ccl_id) values (?,?,?,?,?, ?,?,?,old_password(?),?, "
					+ " ?,0,0,SYSTIMESTAMP,?, ?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, article.getBbs());
			pstmt.setInt(2, article.getSeq());
			pstmt.setInt(3, article.getRef());
			pstmt.setInt(4, article.getStep() + 1);
			pstmt.setInt(5, article.getLev() + 1);
			pstmt.setString(6, article.getWriter());
			pstmt.setString(7, article.getSubject());
			pstmt.setString(8, article.getContent());
			pstmt.setString(9, article.getPassword());
			pstmt.setString(10, article.getEmail());
			pstmt.setString(11, article.getHomepage());
			pstmt.setString(12, article.getIp());
			pstmt.setString(13, article.getHtml());
			pstmt.setString(14, article.getCcl_id());
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
	 * 일련번호 가져오기
	 * @param conn
	 * @param query
	 * @return 일련번호
	 * @throws SQLException
	 */
	public int fetchNew(Connection conn, String query) throws SQLException {

		int newSeq = 0;

		PreparedStatement pstmt = conn.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			newSeq = rs.getInt(1);
		}
		dbCon.close(null, pstmt, rs);

		return newSeq;
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

		int newRef = 1;

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

		return newRef;
	}

	/**
	 * @deprecated 20091017 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 * @param conn
	 * @return
	 * @throws SQLException
	 */
	public int getSeq(Connection conn) throws SQLException {
		return Math.max(
			fetchNew(conn, QUERY_NEW_SEQ), 
			fetchNew(conn, QUERY_NEW_SEQ_DELETED)
		);
	}

	/**
	 * @deprecated 20091017 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
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

		// file 입력
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(QUERY_ADD_FILE);
			DownFile df;
			for (int i = 0; i < arrdf.size(); i++) {
				df = arrdf.get(i);
				if (df.getFileSize() > 0) {
					pstmt.clearParameters();

					pstmt.setInt(1, seq);
					pstmt.setString(2, df.getFileName());
					pstmt.setString(3, df.getMaskName());
					pstmt.setLong(4, df.getFileSize());

					pstmt.executeUpdate();
				}
			}

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
	public int write(Article article) {
		DbCon dbCon = new DbCon();
		Connection conn = null;
		try {
			conn = dbCon.getConnection();
			return write(conn, article);
		} catch (Exception e) {
			System.out.println("write err: "+e);
		} finally {
			dbCon.close(conn, null);
		}

		return 0;
	}


}
