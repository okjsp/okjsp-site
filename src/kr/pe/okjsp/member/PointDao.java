package kr.pe.okjsp.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.pe.okjsp.util.DbCon;

public class PointDao {

	DbCon dbCon = new DbCon();
	static final String POINT_LOG 
		= "insert into point_history (sid, code, point, tstamp, info) values (?, ?, ?, SYSTIMESTAMP, ?)";
	static final String QUERY_ADD_POINT 
		= "update okmember set point = point + ? where sid = ?";
	static final String QUERY_GET_POINT
		= "select point from okmember where sid = ?";

	static final String POINT_LOG_DELETE 
		= "delete from point_history where sid = ?";
	static final String POINT_RESET 
		= "update okmember set point = 0 where sid = ?";
	static final String TEST_RECORD_LOG_DELETE 
		= "delete from okboard where bbsid = 'perf' and writer = 'kenu1'";
	static final String TEST_RECORD_SPAM_DELETE 
		= "delete from okboard where bbsid = 'recruit' and writer = 'kenu1'";
	static final String TEST_RECORD_MEMO_DELETE 
		= "delete from okboard_memo where sid = 3582";
	
	public int log(long sid, int code, int point, String info) {
	   	if (sid == 0) {
	   		return 0;
    	}
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	int result = 0;
    	
    	try {
    		conn = dbCon.getConnection();
			// 포인트 이력 입력
			pstmt = conn.prepareStatement(POINT_LOG);
			pstmt.setLong  (1, sid);
			pstmt.setString(2, Integer.toString(code));
			pstmt.setInt   (3, point);
			pstmt.setString(4, info);
			result = pstmt.executeUpdate();
			
			addPoint(conn, sid, point);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(conn, pstmt);
		}
    	return result;
		
	}
	
	/**
	 * 포인트 추가
	 * @param pconn
	 * @param sid
	 * @param point
	 * @return update row count
	 * @throws SQLException
	 */
	private int addPoint(Connection pconn, long sid, long point) throws SQLException {

		PreparedStatement pstmt = pconn.prepareStatement(QUERY_ADD_POINT);
		pstmt.setLong(1, point);
		pstmt.setLong(2, sid);
		int result = pstmt.executeUpdate();

		dbCon.close(null, pstmt);
		
		return result;
	}


	/**
	 * 포인트 조회
	 * @param sid
	 * @return point
	 * @throws SQLException
	 */
	public long getPoint(long sid) throws SQLException {
		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		long point = 0;

		try{
			pstmt = pconn.prepareStatement(QUERY_GET_POINT);
			pstmt.setLong(1, sid);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				point = rs.getLong(1);
			}
		}catch(Exception e){
			System.out.println("PointDao getPoint err:"+e);
		} finally {
			dbCon.close(pconn, pstmt, rs);
		} // end try catch
		return point;
		
	}

	/**
	 * 계정 포인트 삭제
	 * @param sid
	 * @return
	 */
	public int deletePoint(long sid) {
	   	if (sid == 0) {
	   		return 0;
    	}
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	int result = 0;
    	
    	try {
    		conn = dbCon.getConnection();
			// 테스트 레코드 기록 삭제
			pstmt = conn.prepareStatement(TEST_RECORD_LOG_DELETE);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			// 테스트 스팸 기록 삭제
			pstmt = conn.prepareStatement(TEST_RECORD_SPAM_DELETE);
			result = pstmt.executeUpdate();
			
			pstmt.close();

			// 테스트 메모 레코드 기록 삭제
			pstmt = conn.prepareStatement(TEST_RECORD_MEMO_DELETE);
			result = pstmt.executeUpdate();
			
			pstmt.close();

			// 포인트 이력 삭제
			pstmt = conn.prepareStatement(POINT_LOG_DELETE);
			pstmt.setLong  (1, sid);
			result = pstmt.executeUpdate();
			
			pstmt.close();

			pstmt = conn.prepareStatement(POINT_RESET);
			pstmt.setLong  (1, sid);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(conn, pstmt);
		}
    	return result;
		
		
	}


}
