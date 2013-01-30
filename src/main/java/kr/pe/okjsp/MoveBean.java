/*
 * Created on 2003. 4. 15.
 *
 */
package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.pe.okjsp.util.DbCon;

/**
 * �Խ��� ���ݿ� ���� �ʴ� �Խù��� �̵��ϴ� Ŭ�����Դϴ�.
 * @author  kenu  http://okjsp.pe.kr  ���� 5:38:33
 */
public class MoveBean {
	/**
	 * @uml.property  name="oldBbs"
	 */
	private String oldBbs;
	/**
	 * @uml.property  name="oldRef"
	 */
	private int oldRef;
	/**
	 * @uml.property  name="newBbs"
	 */
	private String newBbs;
	private long sid; // �̵� ������ sid
	private String writer; // �̵� ������
	private String ip; // �̵� ������ ip
	private int seq; // �޸� ���� �� ����

	/**
	 * �̵��� �Խ��� ��ȯ
	 * @return  newBbs
	 * @uml.property  name="newBbs"
	 */
	public String getNewBbs() {
		return newBbs;
	}

	/**
	 * ���� �Խ��� ��ȯ
	 * @return  oldBbs
	 * @uml.property  name="oldBbs"
	 */
	public String getOldBbs() {
		return oldBbs;
	}

	/**
	 * ���� �Խù� �׷��ȣ ��ȯ
	 * @return  oldRef
	 * @uml.property  name="oldRef"
	 */
	public int getOldRef() {
		return oldRef;
	}

	/**
	 * �̵��� �Խ��� ����
	 * @param  string
	 * @uml.property  name="newBbs"
	 */
	public void setNewBbs(String string) {
		newBbs = string;
	}

	/**
	 * ���� �Խ��� ����
	 * @param  string
	 * @uml.property  name="oldBbs"
	 */
	public void setOldBbs(String string) {
		oldBbs = string;
	}

	/**
	 * ���� �Խù� �׷��ȣ ����
	 * @param  i
	 * @uml.property  name="oldRef"
	 */
	public void setOldRef(int i) {
		oldRef = i;
	}
	
	/**
	 * ���ο� �Խ������� �����մϴ�.
	 * @throws SQLException
	 */
	public void perform() throws SQLException {
		DbCon dbCon = new DbCon();
		String QUERY_NEWREF = "select \"ref\" from okboard where bbsid=? order by \"ref\" desc for orderby_num() = 1";
		String QUERY_MOVE_REF = "update okboard set bbsid=?, \"ref\"=? where bbsid=? and \"ref\"=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			conn = dbCon.getConnection();;
			conn.setAutoCommit(false);

			// �� �׷��ȣ ��������
			pstmt = conn.prepareStatement(QUERY_NEWREF);
			pstmt.setString(1,newBbs);

			rs = pstmt.executeQuery();
			int newRef = 0;
			if(rs.next()) {
				newRef = rs.getInt("ref");
			}
			rs.close();
			pstmt.close();
			
			newRef++;
			// �̵��ϱ�
			pstmt = conn.prepareStatement(QUERY_MOVE_REF);
			pstmt.setString(1,newBbs);
			pstmt.setInt   (2,newRef);
			pstmt.setString(3,oldBbs);
			pstmt.setInt   (4,oldRef);
			
			pstmt.executeUpdate();
			pstmt.close();
			
			MemoDao memoDao = new MemoDao();
			int memocnt = memoDao.write(conn, writer, sid, writer, "MOVED FROM " + oldBbs, "okdel", ip, seq);
			memoDao.setCount(conn, seq, memocnt);
			
			conn.commit();
			
		} catch(SQLException e) {
			conn.rollback();
			System.out.println(e.toString());
			throw e;
		} finally {
			conn.setAutoCommit(true);
			dbCon.close(conn, pstmt, rs);
		}
	}

	/**
	 * @param ip
	 * @uml.property  name="ip"
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * @param seq
	 * @uml.property  name="seq"
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}

	/**
	 * @param writer
	 * @uml.property  name="writer"
	 */
	public void setWriter(String writer) {
		this.writer = writer;
	}

}
