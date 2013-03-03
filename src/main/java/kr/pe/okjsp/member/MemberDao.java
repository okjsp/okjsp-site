package kr.pe.okjsp.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.pe.okjsp.DaoUtil;
import kr.pe.okjsp.util.DbCon;

public class MemberDao {
	DbCon dbCon = new DbCon();

	public int setPasswordByEmail(String email, String password)
			throws SQLException {
		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = pconn
				.prepareStatement("update okmember set \"password\" = old_password(?) where email = ?");
		pstmt.setString(1, password);
		pstmt.setString(2, email);

		int result = pstmt.executeUpdate();

		pstmt.close();
		pconn.close();

		return result;
	}

	public int addEmailWithToken(String email, String token)
			throws SQLException {
		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = pconn
				.prepareStatement("insert into forgot (seq, email, token, used) values (null, ?, ?, false)");
		pstmt.setString(1, email);
		pstmt.setString(2, token);

		int result = pstmt.executeUpdate();

		pstmt.close();
		pconn.close();

		return result;
	}

	public int validateParams(String email, String token) {
		int count = 0;
		try {
			Connection conn = dbCon.getConnection();
			PreparedStatement pstmt = conn
					.prepareStatement("select count(*) from forgot where email = ? and token = ? and used = 0");
			pstmt.setString(1, email);
			pstmt.setString(2, token);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
			pstmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public int setTokenUsed(String token) throws SQLException {
		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = pconn
				.prepareStatement("update forgot set used = 1 where token = ?");
		pstmt.setString(1, token);

		int result = pstmt.executeUpdate();

		pstmt.close();
		pconn.close();

		return result;
	}

	public boolean checkBySid(long sid) {
		int result = 0;
		try {
			Connection pconn = dbCon.getConnection();
			result = new DaoUtil().getCount(pconn,
					"select count(*) from okmember where sid = ?",
					new Object[] { sid });
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result == 1;
	}
}
