package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoUtil {
	/**
	 * fetch number
	 * @param conn
	 * @param query
	 * @return number
	 * @throws SQLException
	 */
	public int getNumber(Connection conn, String query) throws SQLException {

		int newSeq = 0;

		PreparedStatement pstmt = conn.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			newSeq = rs.getInt(1);
		}
		pstmt.close();
		rs.close();

		return newSeq + 1;
	}
	/**
	 * fetch count number
	 * @param conn
	 * @param query
	 * @return number
	 * @throws SQLException
	 */
	public int getCount(Connection conn, String query, Object[] params) throws SQLException {
		
		int count = 0;
		
		PreparedStatement pstmt = conn.prepareStatement(query);
		for (int i = 1; i <= params.length; i++) {
			pstmt.setString(i, String.valueOf(params[i - 1]));
		}
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			count = rs.getInt(1);
		}
		pstmt.close();
		rs.close();
		
		return count;
	}

}
