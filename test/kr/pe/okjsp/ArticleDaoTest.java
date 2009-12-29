package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.SQLException;

import junit.framework.TestCase;
import kr.pe.okjsp.util.DbCon;

public class ArticleDaoTest extends TestCase {
	public void testGetSeq() throws SQLException {
		Connection conn = new DbCon().getConnection();
		ArticleDao articleDao = new ArticleDao();

		int seq = articleDao.getSeq(conn);
		
		assertTrue(seq > 1);
		
		conn.close();
	}
}
