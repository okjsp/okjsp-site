package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

public class BookmarkHandler {
	DbCon dbCon = new DbCon();

	public ArrayList getFavoriteList(int size) {
		String query =
			"select a.seq, count(*) cnt, b.subject, b.writer from okboard_bookmark a, okboard b where a.seq = b.seq group by a.seq, b.subject, b.writer order by 2 desc for orderby_num() between 1 and ?";
		String type = "favorite";
		return getList(size, query, type);
	}

	public ArrayList getRecentList(int size) {
		String query =
			"select a.seq, b.subject, b.writer, a.credate from okboard_bookmark a, okboard b where a.seq = b.seq order by credate desc for orderby_num() between 1 and ?";
		String type = "recent";
		return getList(size, query, type);
	}

	private ArrayList getList(int size, String query, String type) {
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		ArrayList list = new ArrayList();
		try {
			conn = dbCon.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, size);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BookmarkExtension b = getBookmarkExtension(rs, type);
				list.add(b);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			dbCon.close(conn, pstmt, rs);
		}
		return list;
	}

	private BookmarkExtension getBookmarkExtension(ResultSet rs, String type)
			throws SQLException {
		BookmarkExtension b = new BookmarkExtension();
		if ("favorite".equals(type)) {
			b.setSeq(rs.getInt("seq"));
			b.setCount(rs.getInt("cnt"));
			b.setSubject(CommonUtil.a2k(rs.getString("subject")));
			b.setWriter(CommonUtil.a2k(rs.getString("writer")));
		} else if ("recent".equals(type)) {
			b.setSeq(rs.getInt("seq"));
			b.setSubject(CommonUtil.a2k(rs.getString("subject")));
			b.setWriter(CommonUtil.a2k(rs.getString("writer")));
			b.setCredate(rs.getTimestamp("credate"));
		}
		return b;
	}


}
