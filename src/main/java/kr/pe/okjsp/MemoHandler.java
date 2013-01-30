package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

/**
 * @author  kenu
 */
public class MemoHandler {
	DbCon dbCon = new DbCon();
    public final static String MEMO_QUERY =
            "select mseq, id, writer, bcomment, wtime, ip, sid from okboard_memo where seq = ? order by mseq";

    public final static String MEMO_COUNT =
            "select count(mseq) from okboard_memo where bcomment like ?";

    public final static String MEMO_RECENT_BCOMMENT =
    	"select mseq, a.id, a.writer, bcomment, a.wtime, a.seq, a.ip, a.sid from okboard_memo a, okboard b where " +
    	" b.bbsid not in ('jco', 'jcocfrc', 'perf', '0612', 'eclipsejava') " +
    	" and a.seq = b.seq  and mseq>=0 and bcomment like ? " +
    	" order by mseq desc for orderby_num() between ? and ?";

    public final static String MEMO_RECENT_WRITER =
    	"select mseq, a.id, a.writer, bcomment, a.wtime, a.seq, a.ip, a.sid from okboard_memo a, okboard b where " +
    	" b.bbsid not in ('jco', 'jcocfrc', 'perf', '0612', 'eclipsejava') " +
    	" and a.seq = b.seq  and mseq>=0 and a.writer like ? order by mseq desc for orderby_num() between ? and ?";

	public  int pageSize;       // 페이지 리스트 사이즈
    /**
	 * @uml.property  name="field"
	 */
    public  String field;       // 검색어 종류
    /**
	 * @uml.property  name="keyword"
	 */
    public  String keyword;     // 검색어

    public MemoHandler() {
    	pageSize = 20;
    	field= "";
    	keyword = "";
    }

    /**
	 * Method getList.
	 * @param seq
	 * @return ArrayList
	 * @throws SQLException
	 */
	public ArrayList<MemoBean> getList(int seq) {
		Connection pconn = null;
		ArrayList<MemoBean> arrayList = new ArrayList<MemoBean>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pconn = dbCon.getConnection();
			pstmt = pconn.prepareStatement(MEMO_QUERY);
			pstmt.setInt(1, seq);
			rs = pstmt.executeQuery();
			MemoBean mb = null;

			while (rs.next()) {
				mb = new MemoBean();
				mb.setSeq(seq);
				mb.setMseq(rs.getInt(1));
				mb.setId(rs.getString(2));
				mb.setWriter(CommonUtil.a2k(rs.getString(3)));
				mb.setBcomment(CommonUtil.a2k(rs.getString(4)));
				mb.setWtime(rs.getTimestamp(5));
				mb.setIp(rs.getString(6));
				mb.setSid(rs.getLong(7));

				arrayList.add(mb);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			dbCon.close(pconn, pstmt, rs);
		}

		return arrayList;
	}

    /**
	 * Method getRecent.
	 * @param page
	 * @return ArrayList
	 */
	public ArrayList<MemoBean> getRecent(int page) throws Exception {

		Connection pconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<MemoBean> arrayList = new ArrayList<MemoBean>();

		try {
			pconn = dbCon.getConnection();
			if ("w".equals(field)) {
				pstmt = pconn.prepareStatement(MEMO_RECENT_WRITER);
			} else {
				pstmt = pconn.prepareStatement(MEMO_RECENT_BCOMMENT);
			}
			pstmt.setString(1,"%"+keyword+"%");
			int startMseq = page * pageSize;
			pstmt.setInt(2,startMseq + 1);
			pstmt.setInt(3,startMseq + pageSize);
			rs = pstmt.executeQuery();

			MemoBean mb = null;

			while(rs.next()) {
				mb = new MemoBean();
				mb.setSeq(rs.getInt("seq"));
				mb.setMseq    (rs.getInt      ("mseq")    );
				mb.setId      (rs.getString   ("id")      );
				mb.setWriter  (CommonUtil.a2k(rs.getString   ("writer")  ));
				mb.setBcomment(CommonUtil.a2k(rs.getString   ("bcomment")));
				mb.setWtime   (rs.getTimestamp("wtime")   );
				mb.setIp      (rs.getString   ("ip")      );
				mb.setSid     (rs.getLong     ("sid")     );

				arrayList.add(mb);
			}
			rs.close();
			pstmt.close();

		} catch(Exception e) {
			throw e;
		} finally {
			dbCon.close(pconn, pstmt, rs);
		}

		return arrayList;
    }


    /**
     * Memo 의 갯수를 반환합니다.
     * @return int
     */
    public int getCount() throws SQLException {
    	int cnt = 0;
		Connection pconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			pconn = dbCon.getConnection();
			pstmt = pconn.prepareStatement(MEMO_COUNT);
			pstmt.setString(1,"%"+keyword+"%");
			rs = pstmt.executeQuery();

			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			System.out.println(e.toString());
		} finally {
			dbCon.close(pconn, pstmt, rs);
		}

        return cnt;
    }

	/**
	 * @return
	 * @uml.property  name="field"
	 */
	public String getField() {
		if (!"w".equals(field)) field = "c";
		return field;
	}

	/**
	 * @param field
	 * @uml.property  name="field"
	 */
	public void setField(String field) {
		this.field = field;
	}

	public void setKeyfield(String field) {
		if ("writer".equals(field)) field = "w";
		this.field = field;
	}

	/**
	 * @return
	 * @uml.property  name="keyword"
	 */
	public String getKeyword() {
		return keyword;
	}

	/**
	 * @param keyword
	 * @uml.property  name="keyword"
	 */
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

}