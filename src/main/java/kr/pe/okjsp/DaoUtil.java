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

}
