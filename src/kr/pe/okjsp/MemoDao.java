package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.pe.okjsp.member.PointDao;
import kr.pe.okjsp.util.DbCon;

public class MemoDao {
	DbCon dbCon = new DbCon();

	final static String QUERY_MEMO_SEQ =
		"select mseq+1 from okboard_memo order by mseq desc limit 1";

	final static String QUERY_MEMO_ADD =
		"insert into okboard_memo (mseq, seq, id, sid, writer, bcomment, wtime, memopass, ip) " +
		"values (?,?,?,?,?,?,now(),old_password(?),?)";

	final static String QUERY_MEMO_COUNT =
        "update okboard set memo = memo + ? where seq = ?";

    /**
     * 메모 기록
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
    	int mseq = 0;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int memocnt = 0;
    	try {
			// mseq 일련번호 가져오기
			pstmt = conn.prepareStatement(QUERY_MEMO_SEQ);
			rs = pstmt.executeQuery();
			if(rs.next())
			    mseq = rs.getInt(1);
			rs.close();
			pstmt.close();

			// memo 입력
			pstmt = conn.prepareStatement(QUERY_MEMO_ADD);
			pstmt.setInt   (1, mseq);
			pstmt.setInt   (2, seq);
			pstmt.setString(3, id);
			pstmt.setLong  (4, sid);
			pstmt.setString(5, writer);
			pstmt.setString(6, bcomment);
			pstmt.setString(7, memopass);
			pstmt.setString(8, ip);
			memocnt = pstmt.executeUpdate();
			pstmt.close();
			
			if (sid > 0) {
				new PointDao().log(sid, 2, 1, String.valueOf(mseq));
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
