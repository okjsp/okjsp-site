package kr.pe.okjsp.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.pe.okjsp.Article;
import kr.pe.okjsp.member.MemberHandler;
import kr.pe.okjsp.util.DbCon;

public class ArticleDao extends MemberHandler {
	private final String OKBOARD_LIST_BY_SID = "select * from okboard where id = ? order by seq desc";
	DbCon dbCon = new DbCon();
	

	private Article getArticle(ResultSet rs) throws SQLException {
		Article row = new Article();
		row.setBbs(rs.getString("bbsid"));
		row.setSubject(rs.getString("subject"));
		row.setContent(rs.getString("content"));
		row.setRead(rs.getInt("hit"));
		row.setMemo(rs.getInt("memo"));
		row.setWhen(rs.getTimestamp("wtime"));
		row.setSeq(rs.getInt("seq"));
		row.setWriter(rs.getString("writer"));
		return row;
	}
	
	public List<Article> getArticleListBy(String sid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<Article> list = new ArrayList<Article>();
		
		try {
			conn = dbCon.getConnection();
			pstmt = conn.prepareStatement(OKBOARD_LIST_BY_SID);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(getArticle(rs));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(conn, pstmt, rs);
		}
		return list;
	}
	
	
}
