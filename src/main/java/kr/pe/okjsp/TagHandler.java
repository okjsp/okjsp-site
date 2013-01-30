package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

public class TagHandler {
	DbCon dbCon = new DbCon();
	final static String QUERY_TAG_SELECT = "select tagseq from okboard_tag where tag = ?";
	final static String QUERY_TAG_INFO = "select tagseq, tag, cnt from okboard_tag where tagseq = ?";
	final static String QUERY_TAG_RECENT = "select tagseq, tag, cnt from okboard_tag order by tagseq desc for orderby_num() = ?";
	/**
	 * @deprecated 20091019 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 */
	final static String QUERY_TAG_TAGSEQ = "select tagseq from okboard_tag order by tagseq desc limit 1";
	final static String QUERY_TAG_INSERT = "insert into okboard_tag (tag, cnt, credate) values (?, 0, SYSTIMESTAMP)";
	final static String QUERY_TAG_USER_INSERT = "insert into okboard_tag_user (tagseq, userid, seq, credate) values (?, ?, ?, SYSTIMESTAMP)";
	final static String QUERY_TAG_CNT_UP = "update okboard_tag set cnt = cnt + 1 where tagseq = ?";
	final static String QUERY_TAG_BY_SEQ = "select a.tagseq, max(a.tag) tag, max(a.cnt) cnt from okboard_tag a, okboard_tag_user b where a.tagseq = b.tagseq and b.seq = ? group by a.tagseq order by cnt desc";
	final static String QUERY_TAG_BY_USERID = "select a.tag, a.cnt, b.seq from okboard_tag a, okboard_tag_user b where a.tagseq = b.tagseq and b.userid = ? order by b.credate";
	final static String QUERY_TAG_BY_TAGSEQ = "select b.seq, bbsid, writer, subject, wtime from okboard_tag_user a, okboard b where a.seq = b.seq and a.tagseq = ? group by a.seq order by a.credate desc";

	/**
	 * <pre>
	 * # 20091018 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 *</pre>
	 * @param tag
	 * @param id
	 * @param seq
	 * @throws Exception
	 */
	public void add(String tag, String id, int seq) throws Exception {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			con = dbCon.getConnection();
			con.setAutoCommit(false);
			int tagseq = 0;
			tagseq = findTagseqByTag(tag, con);

			if (tagseq == 0) {
				pstmt = con.prepareStatement(QUERY_TAG_INSERT, PreparedStatement.RETURN_GENERATED_KEYS);
				pstmt.setString(1, tag);
				pstmt.executeUpdate();
				pstmt.close();
				
				rs = pstmt.getGeneratedKeys();
				while (rs.next()) {
					tagseq = rs.getInt(1);
				}
			}
			pstmt = con.prepareStatement(QUERY_TAG_USER_INSERT);
			pstmt.setInt(1, tagseq);
			pstmt.setString(2, id);
			pstmt.setInt(3, seq);
			pstmt.executeUpdate();
			pstmt.close();

			pstmt = con.prepareStatement(QUERY_TAG_CNT_UP);
			pstmt.setInt(1, tagseq);
			pstmt.executeUpdate();
			pstmt.close();
			
			con.commit();
		} catch (SQLException e) {
			System.out.println("TagHandler add() sql: "+ e.toString());
			if (e.toString().indexOf("Duplicate entry") > -1) {
				throw new Exception("duplicate tag");
			}
			throw e;
		} catch (Exception e) {
			System.out.println("TagHandler add(): "+ e.toString());
			throw e;
		} finally {
			dbCon.close(con, pstmt, rs);
		}
	}

	/**
	 * 입력된 태그에 해당하는 tagseq를 반환한다.
	 * @param tag
	 * @param con
	 * @return tagseq int
	 * @throws SQLException
	 */
	private int findTagseqByTag(String tag, Connection con)
			throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int tagseq = 0;
		try {
			pstmt = con.prepareStatement(QUERY_TAG_SELECT);
			pstmt.setString(1, tag);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				tagseq = rs.getInt("tagseq");
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
		} finally {
			dbCon.close(null, pstmt, rs);
		} 
		return tagseq;
	}
	
	public int findTagseqByTag(String tag) {
		Connection con = null;
		int tagseq = 0;
		try {
			con = dbCon.getConnection();
			tagseq = findTagseqByTag(tag, con);
		} catch (Exception e) {
			System.out.println("TagHandler findTagseqByTag(): "+ e.toString());
		} finally {
			dbCon.close(con, null);
		}
		return tagseq;
	}

	public ArrayList getTagsBySeq(int seq) {
		ArrayList list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dbCon.getConnection();
			pstmt = con.prepareStatement(QUERY_TAG_BY_SEQ);
			pstmt.setInt(1, seq);
			rs = pstmt.executeQuery();
			Tag tag = null;
			while (rs.next()) {
				tag = new Tag();
				tag.setTagseq(rs.getInt("tagseq"));
				tag.setCnt(rs.getInt("cnt"));
				tag.setTag(CommonUtil.a2k(rs.getString("tag")));
				tag.setSeq(seq);
				list.add(tag);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println("TagHandler getTagsBySeq(): "+ e.toString());
		} finally {
			dbCon.close(con, pstmt, rs);
		}
		return list;
	}

	public ArrayList getTagsByUser(String id) {
		ArrayList list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dbCon.getConnection();
			pstmt = con.prepareStatement(QUERY_TAG_BY_USERID);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			Tag tag = null;
			while (rs.next()) {
				tag = new Tag();
				tag.setTag(CommonUtil.a2k(rs.getString("tag")));
				tag.setCnt(rs.getInt("cnt"));
				tag.setSeq(rs.getInt("seq"));
				list.add(tag);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println("TagHandler getTagsBySeq(): "+ e.toString());
		} finally {
			dbCon.close(con, pstmt, rs);
		}
		return list;
	}

	public ArrayList getArticlesByTagseq(int tagseq) {
		ArrayList list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dbCon.getConnection();
			pstmt = con.prepareStatement(QUERY_TAG_BY_TAGSEQ);
			pstmt.setInt(1, tagseq);
			rs = pstmt.executeQuery();
			Article one = null;
			while (rs.next()) {
				one = new Article();
				one.setSeq(rs.getInt("seq"));
				one.setBbs(rs.getString("bbsid"));
				one.setWriter(CommonUtil.a2k(rs.getString("writer")));
				one.setSubject(CommonUtil.a2k(rs.getString("subject")));
				one.setWhen(rs.getTimestamp("wtime"));
				list.add(one);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println("TagHandler getArticlesByTagseq(): "+ e.toString());
		} finally {
			dbCon.close(con, pstmt, rs);
		}
		return list;
	}
	public Tag getTag(int tagseq) {
		Tag tag = new Tag();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dbCon.getConnection();
			pstmt = con.prepareStatement(QUERY_TAG_INFO);
			pstmt.setInt(1, tagseq);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				tag.setTag(CommonUtil.a2k(rs.getString("tag")));
				tag.setTagseq(rs.getInt("tagseq"));
				tag.setCnt(rs.getInt("cnt"));
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println("TagHandler getTag(): "+ e.toString());
		} finally {
			dbCon.close(con, pstmt, rs);
		}
		return tag;
	}
	public ArrayList getRecentTags(int rowcnt) {
		ArrayList list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dbCon.getConnection();
			pstmt = con.prepareStatement(QUERY_TAG_RECENT);
			pstmt.setInt(1, rowcnt);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Tag tag = new Tag();
				tag.setTag(CommonUtil.a2k(rs.getString("tag")));
				tag.setTagseq(rs.getInt("tagseq"));
				tag.setCnt(rs.getInt("cnt"));
				list.add(tag);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println("TagHandler getTagMany(): "+ e.toString());
		} finally {
			dbCon.close(con, pstmt, rs);
		}
		return list;
	}
}
