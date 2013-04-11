/*
 * Created on 2004. 8. 24.
 *
 */
package kr.pe.okjsp.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;

/**
 * @author kenu
 * 
 */
public class DbCon {
	private static BasicDataSource ds = null;
	static {
		String driver = PropertyManager.getString("DRIVER");
		String dbUrl = PropertyManager.getString("DBURL");
		String dbUser = PropertyManager.getString("DBUSER");
		String dbPass = PropertyManager.getString("DBPASS");
		try {
			ds = new BasicDataSource();
			ds.setDriverClassName(driver);
			ds.setUrl(dbUrl);
			ds.setUsername(dbUser);
			ds.setPassword(dbPass);
			
			ds.setMaxIdle(10);
			ds.setMaxActive(40);
			ds.setMaxWait(1000);
			ds.setValidationQuery("select 1/1");
			ds.setValidationQueryTimeout(1);
			ds.setTestOnBorrow(true);

		} catch (Exception e) {
			System.out.println("anable load DataSource~!");
			e.printStackTrace();
		} finally {
			System.out.println("\n =============================================");
			System.out.println(" DRIVER : " + driver);
			System.out.println(" =============================================\n");
		}
	}
	
	public Connection getConnection() throws SQLException {
		return ds.getConnection();
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
	 * DataSource�� ���¸� �����ش�.
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
	 * DataSource�� �����Ѵ�.
	 * </pre>
	 * @param ds
	 * @throws SQLException
	 */
	public static void shutdownDataSource(DataSource ds) throws SQLException {
		BasicDataSource bds = (BasicDataSource) ds;
		bds.close();
	}
}