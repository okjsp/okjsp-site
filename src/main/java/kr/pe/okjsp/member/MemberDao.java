package kr.pe.okjsp.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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

}
