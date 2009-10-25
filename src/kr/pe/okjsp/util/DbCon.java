/*
 * Created on 2004. 8. 24.
 *
 */
package kr.pe.okjsp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;

/**
 * @author kenu
 * 
 */
public class DbCon {
	private static String dbUrl = null;
	private static String dbUser = null;
	private static String dbPass = null;
	static {
		ResourceBundle rb = ResourceBundle.getBundle("kr.pe.okjsp.DB");
		dbUrl = rb.getString("DBURL");
		dbUser = rb.getString("DBUSER");
		dbPass = rb.getString("DBPASS");
		try {
			Class.forName(rb.getString("DRIVER"));
		} catch (Exception e) {
			System.err.println("Unable to load driver.");
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection(dbUrl, dbUser, dbPass);
	}

	public void close(Connection pconn, Statement pstmt,
			ResultSet rs) {
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (pconn != null)
				pconn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void close(Connection pconn, Statement pstmt) {
		close(pconn, pstmt, null);
	}
}
