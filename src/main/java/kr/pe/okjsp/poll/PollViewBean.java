package kr.pe.okjsp.poll;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.pe.okjsp.util.DbCon;

/**
 * @author  kenu  투표 결과를 표시하는 빈
 */
public class PollViewBean {
	DbCon dbCon = new DbCon();
	/**
	 * @uml.property  name="seq"
	 */
	private int seq;
	/**
	 * @uml.property  name="isum"
	 */
	private int isum;
	/**
	 * @uml.property  name="question"
	 */
	private String question;
	

	/**
	 * @return
	 * @uml.property  name="seq"
	 */
	public int getSeq() {
		return seq;
	}

	/**
	 * @param  i
	 * @uml.property  name="seq"
	 */
	public void setSeq(int i) {
		seq = i;
	}
	
	public ArrayList getList() throws Exception {

		Connection pconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int imax=0;
		isum = 0;
		ArrayList arrList = new ArrayList();
		String [] one = null;

		try {
			pconn = dbCon.getConnection();
			String query="";
			if (seq == 0) {
				query = "select max(seq) seq from polllist";
				pstmt = pconn.prepareStatement(query);
	
				rs = pstmt.executeQuery();
				if (rs.next()) {
					seq      = rs.getInt("seq");
				}
		
				rs.close();
				pstmt.close();
			}
	
			query = "select max(question) question, max(vtype) vtype, max(hit) imax, sum(hit) isum from polllist a , pollitem b where a.seq = ? and a.seq=b.seq";
	
			pstmt = pconn.prepareStatement(query);
	
			pstmt.setLong(1,seq);
	
			rs = pstmt.executeQuery();
			if (rs.next()) {
				this.question = rs.getString("question");
				imax     = rs.getInt("imax");
				this.isum     = rs.getInt("isum");
			}
	
			rs.close();
			pstmt.close();
	
				query = "select * from pollitem where seq = ? order by itemseq";
		
				int xx=90;
		 
				pstmt = pconn.prepareStatement(query);
				pstmt.setLong(1,seq);
				rs = pstmt.executeQuery();
		
				while(rs.next()) {
					one = new String[5];
					one[0] = rs.getString("itemseq");
					one[1] = rs.getString("item");
					one[2] = rs.getString("hit");
					one[3] = String.valueOf(rs.getInt("hit") / (double)imax * xx);
					one[4] = String.valueOf((rs.getInt("hit") * 1000/ (double)isum) / 10.0);
					arrList.add(one);
				} // end of while
		
				pstmt.close();
		
			pconn.close();

		} catch(Exception e){
			throw e;
		} finally {
			dbCon.close(pconn, pstmt, rs);
		}
		return arrList;
		
	}

	/**
	 * @return
	 * @uml.property  name="question"
	 */
	public String getQuestion() {
		return question;
	}

	/**
	 * @return
	 * @uml.property  name="isum"
	 */
	public int getIsum() {
		return isum;
	}

}
