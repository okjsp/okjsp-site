package kr.pe.okjsp;

import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;

import junit.framework.TestCase;

public class ListHandlerTest extends TestCase {

	public void testGetRecent() throws SQLException {
		ListHandler list = new ListHandler();
		assertEquals(5, list.getRecentList("techtrend", 5).size());
		assertEquals(5, list.getRecentList("bbs3", 5).size());
		assertEquals(5, list.getRecentList("techtrend", 5).size());
		assertEquals(5, list.getRecentList("bbs3", 5).size());
	}
	public void testGetAllRecent() throws SQLException {
		ListHandler list = new ListHandler();
		Collection<Article> allRecentList = list.getAllRecentList(50);
		assertEquals(50, allRecentList.size());
		Collection<Article> allRecentList2 = list.getAllRecentList(50);
		assertEquals(50, allRecentList2.size());
		assertEquals(getFirstContent(allRecentList), getFirstContent(allRecentList2));
		assertEquals(50, list.getAllRecentList(50).size());
		assertEquals(50, list.getAllRecentList(50).size());
		assertEquals(50, list.getAllRecentList(50).size());
		assertEquals(50, list.getAllRecentList(50).size());
	}
	private String getFirstContent(Collection<Article> allRecentList) {
		Iterator<Article> iterator = allRecentList.iterator();
		Article next = iterator.next();
		return next.getContent();
	}
}
