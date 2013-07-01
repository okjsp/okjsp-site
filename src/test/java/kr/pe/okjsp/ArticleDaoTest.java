package kr.pe.okjsp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import junit.framework.TestCase;
import kr.pe.okjsp.member.Member;
import kr.pe.okjsp.member.TestObject;
import kr.pe.okjsp.util.DbCon;

public class ArticleDaoTest extends TestCase {
	public void testGetSeq() throws SQLException {
		Connection conn = new DbCon().getConnection();
		ArticleDao articleDao = new ArticleDao();

		int seq = articleDao.getSeq(conn);
		
		assertTrue(seq > 1);
		
		conn.close();
	}
	
	public void testWriteEmpty() {
		ArticleDao articleDao = new ArticleDao();
		Article article = new Article();
		try {
			int seq = articleDao.write(article);

			int result = articleDao.delete(seq);
			assertTrue(result == 1);

			fail("Write Empty Article");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void _testWrite() throws Exception {
		ArticleDao articleDao = new ArticleDao();
		Member member = TestObject.getTestMember();
		Article article = TestObject.getTestArticle(member);
		int seq = articleDao.write(article);
		assertTrue(seq > 1);
		
		int result = articleDao.delete(seq);
		assertTrue(result == 1);
	}

	public void _testCheckSpam() throws IOException {
		Member member = TestObject.getTestMember();
		Article article = TestObject.getTestArticle(member);

		ArticleDao articleDao = new ArticleDao();

		int seq = articleDao.write(article);
		assertTrue(1 < seq);

		seq = articleDao.write(article);
		assertTrue(1 < seq);

		try {
			seq = articleDao.write(article);
			fail("Write Spam Articles");
		} catch (IOException e) {
			e.printStackTrace();
		}
		TestObject.deleteTestData();
	}

}
