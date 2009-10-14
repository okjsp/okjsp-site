/*
 * Created on 2003. 4. 28.
 *
 * To change the template for this generated file go to
 * Window>Preferences>Java>Code Generation>Code and Comments
 */
package kr.pe.okjsp.util;

import java.sql.DriverManager;
import java.sql.SQLException;

import junit.framework.TestCase;
import kr.pe.okjsp.PopDb;

/**
 * @author dalnim
 *
 * To change the template for this generated type comment go to
 * Window>Preferences>Java>Code Generation>Code and Comments
 */
public class PopDbTest extends TestCase {

	/**
	 * Constructor for PopDbTest.
	 * @param arg0
	 */
	public PopDbTest(String arg0) {
		super(arg0);
	}

	public void testGetConnection() {
		PopDb pd = new PopDb();
		try {
			assertNotNull(DriverManager.getConnection("jdbc:jdc:pool"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
