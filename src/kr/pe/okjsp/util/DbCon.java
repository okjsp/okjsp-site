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

/**
 * @author kenu
 * 
 */
public class DbCon {
	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection("jdbc:jdc:jdcpool");
	}

	public void close(Connection pconn, PreparedStatement pstmt,
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

	public void close(Connection pconn, PreparedStatement pstmt) {
		close(pconn, pstmt, null);
	}
}
