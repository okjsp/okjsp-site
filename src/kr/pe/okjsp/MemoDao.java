package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.pe.okjsp.member.PointDao;
import kr.pe.okjsp.util.DbCon;

public class MemoDao {
	DbCon dbCon = new DbCon();

	/**
	 * <pre>
	 * @deprecated 20091018 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
	 * </pre>
	 */
	final static String QUERY_MEMO_SEQ =
		"select mseq+1 from okboard_memo order by mseq desc limit 1";

	final static String QUERY_MEMO_ADD =
		"insert into okboard_memo (mseq, seq, id, sid, writer, bcomment, wtime, memopass, ip) values (?,?,?,?,?,?,SYSTIMESTAMP,old_password(?),?)";

	final static String QUERY_MEMO_COUNT =
        "update okboard set memo = memo + ? where seq = ?";

    /**
     * <pre>
     * 메모 기록
     * # 20091018 서영아빠 CUBRID로 마이그레이션 하면서 시퀀스 자동생성 방법으로 바뀜
     * </pre>
     * @param conn
     * @param id
     * @param sid
     * @param writer
     * @param bcomment
     * @param memopass
     * @param ip
     * @param seq
     * @return result
     * @throws SQLException
     */
    public int write(Connection conn, String id, long sid, String writer, String bcomment, String memopass, String ip, int seq) throws SQLException {
    	if ("null".equals(bcomment) || bcomment == null) {
    		throw new SQLException("no content by "+ip);
    	}
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int memocnt = 0;
    	String mseq = "";
    	try {
			// memo 입력
			pstmt = conn.prepareStatement(QUERY_MEMO_ADD);
			pstmt.setInt   (1, seq);
			pstmt.setString(2, id);
			pstmt.setLong  (3, sid);
			pstmt.setString(4, writer);
			pstmt.setString(5, bcomment);
			pstmt.setString(6, memopass);
			pstmt.setString(7, ip);
			memocnt = pstmt.executeUpdate();
			
			// 등록된 mseq를 가져옵니다.
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				mseq = rs.getString(1);
			}
			
			if (sid > 0) {
				new PointDao().log(sid, 2, 1, mseq);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(null, pstmt, rs);
		}
    	return memocnt;
    }

    /**
     * 메모 카운트
     * @param conn
     * @param seq
     * @param memocnt
     * @throws SQLException
     */
    public void setCount(Connection conn, int seq, int memocnt) throws SQLException {
    	PreparedStatement pstmt = null;
    	try {
			// 메모 갯수 추가/삭제
			pstmt = conn.prepareStatement(QUERY_MEMO_COUNT);
			pstmt.setInt   (1, memocnt);
			pstmt.setInt   (2, seq);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { pstmt.close(); } catch (Exception e2) {
				e2.printStackTrace();
			}
		}
    }


}
