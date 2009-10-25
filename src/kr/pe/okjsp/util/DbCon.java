/*
 * Created on 2004. 8. 24.
 *
 */
package kr.pe.okjsp.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;

/**
 * @author kenu
 * 
 */
public class DbCon {
	private static BasicDataSource ds = null;
	static {
		try {
			ResourceBundle rb = ResourceBundle.getBundle("kr.pe.okjsp.DB");
			ds = new BasicDataSource();
			ds.setDriverClassName(rb.getString("DRIVER"));
			ds.setUrl(rb.getString("DBURL"));
			ds.setUsername(rb.getString("DBUSER"));
			ds.setPassword(rb.getString("DBPASS"));
		} catch (Exception e) {
			System.out.println("anable load DataSource~!");
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws SQLException {
		Connection con = ds.getConnection();
		return con;
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
	
	/**
	 * <pre>
	 * DataSource의 상태를 보여준다.
	 * </pre>
	 * @param ds
	 * @throws SQLException
	 */
	public static void printDataSourceStats(DataSource ds) throws SQLException {
		BasicDataSource bds = (BasicDataSource) ds;
		System.out.println("NumActive: " + bds.getNumActive());
		System.out.println("NumIdle: " + bds.getNumIdle());
	}

	/**
	 * <pre>
	 * DataSource를 종료한다.
	 * </pre>
	 * @param ds
	 * @throws SQLException
	 */
	public static void shutdownDataSource(DataSource ds) throws SQLException {
		BasicDataSource bds = (BasicDataSource) ds;
		bds.close();
	}
}