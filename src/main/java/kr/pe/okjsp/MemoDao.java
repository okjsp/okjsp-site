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
		"select max(mseq) seq from okboard_memo";

	final static String QUERY_MEMO_ADD =
		"insert into okboard_memo (mseq, seq, id, sid, writer, bcomment, wtime, memopass, ip) values (?,?,?,?,?,?,SYSTIMESTAMP,old_password(?),?)";

	final static String QUERY_MEMO_COUNT =
        "update okboard set memo = memo + ? where seq = ?";
	
	final static String QUERY_GET_MEMO_COUNT = "select count(1) cnt from okboard_memo where seq = ?";

    /**
     * <pre>
     * �޸� ���
     * # 20091018 �����ƺ� CUBRID�� ���̱׷��̼� �ϸ鼭 ������ �ڵ����� ������� �ٲ�
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
    	int mseq = 0;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int memocnt = 0;
    	try {
			// mseq �Ϸù�ȣ ��������
			pstmt = conn.prepareStatement(QUERY_MEMO_SEQ);
			rs = pstmt.executeQuery();
			if(rs.next())
			    mseq = rs.getInt(1);
			mseq++;
			rs.close();
			pstmt.close();

			// memo �Է�
			pstmt = conn.prepareStatement(QUERY_MEMO_ADD, PreparedStatement.RETURN_GENERATED_KEYS);
			pstmt.setInt   (1, mseq);
			pstmt.setInt   (2, seq);
			pstmt.setString(3, id);
			pstmt.setLong  (4, sid);
			pstmt.setString(5, writer);
			pstmt.setString(6, bcomment);
			pstmt.setString(7, memopass);
			pstmt.setString(8, ip);
			memocnt = pstmt.executeUpdate();
			
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
     * �޸� ī��Ʈ
     * @param conn
     * @param seq
     * @param memocnt
     * @throws SQLException
     */
    public void setCount(Connection conn, int seq, int memocnt) throws SQLException {
    	PreparedStatement pstmt = null;
    	try {
			// �޸� ���� �߰�/����
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
    
    /**
     * <pre>
     * �޸� ���
     * # 20091018 �����ƺ� CUBRID�� ���̱׷��̼� �ϸ鼭 ������ �ڵ����� ������� �ٲ�
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
    public int getMemoCount(int seq) {
	
	int memocnt = 0;
	
	DbCon dbCon = new DbCon();
	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	try {
    	    		conn = dbCon.getConnection();
    	    		
			// mseq �Ϸù�ȣ ��������
			pstmt = conn.prepareStatement(QUERY_GET_MEMO_COUNT);
			pstmt.setInt   (1, seq);
			rs = pstmt.executeQuery();
			if(rs.next())
			    memocnt = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(conn, pstmt, rs);
		}
    	return memocnt;
    }


}
