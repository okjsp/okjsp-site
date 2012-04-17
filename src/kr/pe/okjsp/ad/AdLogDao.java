package kr.pe.okjsp.ad;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.pe.okjsp.util.DbCon;

public class AdLogDao {
	DbCon dbCon = new DbCon();
	private String AD_LOG = "insert into okad_log (credate, url, referer, sid, ip) values (now(), ?, ?, ?, ?);";

	public int log(AdLog log) {
	   	if (log == null) {
	   		return 0;
    	}
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	int result = 0;
    	
    	try {
    		conn = dbCon.getConnection();
			pstmt = conn.prepareStatement(AD_LOG);
			pstmt.setString(1, log.getUrl());
			pstmt.setString(2, log.getReferer());
			pstmt.setLong  (3, log.getSid());
			pstmt.setString(4, log.getIp());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(conn, pstmt);
		}
    	return result;
	}
}
