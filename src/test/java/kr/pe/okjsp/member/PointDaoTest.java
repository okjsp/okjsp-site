package kr.pe.okjsp.member;

import java.sql.Connection;
import java.sql.SQLException;

import junit.framework.TestCase;
import kr.pe.okjsp.Article;
import kr.pe.okjsp.ArticleDao;
import kr.pe.okjsp.MemoBean;
import kr.pe.okjsp.MemoDao;
import kr.pe.okjsp.util.DbCon;

public class PointDaoTest extends TestCase {

	PointDao pointDao = new PointDao();
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		TestObject.deleteTestData();
	}
	
	@Override
	protected void tearDown() throws Exception {
		super.tearDown();
		TestObject.deleteTestData();
	}
	
	public void testPointLog() throws Exception {
		Member member = TestObject.getTestMember();
		
		boolean idExist = new MemberHandler().isIdExist(member.getId());
		assertTrue(idExist);
		
		long point = pointDao.getPoint(member.getSid());
		int addPoint = pointDao.log(member.getSid(), 1, 1, "login test");
		assertEquals(1, addPoint);
		long pointAfter = pointDao.getPoint(member.getSid());
		assertEquals(1, pointAfter - point);
	}
	
	public void testPointHistoryLogin() throws Exception {
		// pseq, id, code, tstamp, info
		long sid = 3582; //"kenu1";
		int code = 1;
		String info = "login test";
		int point = 1;
		pointDao.log(sid, code, point, info);
		
		// 로그인 1점, code 1
		Member member = TestObject.getTestMember();
		member.setPassword("okpass");
		
		long pointBefore =  pointDao.getPoint(sid);
		MemberHandler handler = new MemberHandler();
		int doLogin = handler.doLogin(member);
		assertEquals(1, doLogin);
		long pointAfter = pointDao.getPoint(sid);
		assertEquals(1, pointAfter - pointBefore);
	}
	
	public void testPointHistoryWriteLogin() throws SQLException {
		// login check
		Member member = TestObject.getTestMember();

		// 글쓰기 10점, code 2
		long pointBefore =  pointDao.getPoint(member.getSid());
		ArticleDao articleDao = new ArticleDao();
		Article article = new Article();
		Connection conn = new DbCon().getConnection();
		int seq = articleDao.getSeq(conn);
		article.setSeq(seq);
		article.setBbs("perf");
		article.setSubject("subject");
		article.setId(member.getId());
		article.setSid(member.getSid());
		article.setContent("content");
		article.setWriter(member.getId());
		int result = articleDao.write(conn , article);
		assertTrue(1 < result);
		long pointAfter = pointDao.getPoint(member.getSid());
		assertEquals(10, pointAfter - pointBefore);
	}

	public void testPointHistoryMemoWriteLogin() throws SQLException {
		// login check
		Member member = TestObject.getTestMember();
		
		// 메모글 1점, code 4
		long pointBefore =  pointDao.getPoint(member.getSid());
		MemoBean memoBean = new MemoBean();
		memoBean.setBcomment("memo test");
		MemoDao memoDao = new MemoDao();
		DbCon dbCon = new DbCon();
		Connection conn = dbCon.getConnection();
		conn.setAutoCommit(false);
		String bcomment = memoBean.getBcomment();
		String writer = member.getId();
		long sid = member.getSid();
		String id = member.getId();
		String memopass = "okpass";
		String ip = "";
		int seq = 0;
		memoDao.write(conn, id, sid, writer, bcomment, memopass, ip, seq);
		long pointAfter = pointDao.getPoint(member.getSid());
		assertEquals(1, pointAfter - pointBefore);
		conn.setAutoCommit(true);
		// 메모글 삭제 0점, code 5
		// 투표 1점 code 6
		// 회원 탈퇴시 포인트 기록 삭제 테이블로 이동
		
		// 글삭제 -50점. code 3
		// DeleteServlet.doPost();
		
	}
	
	public void testLog() {
		Member member = TestObject.getTestMember();
		int log = pointDao.log(member.getSid(), 6, 1, "testLog");
		assertTrue(log == 1);
	}
}
