package kr.pe.okjsp.member;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

import kr.pe.okjsp.DaoUtil;
import kr.pe.okjsp.Navigation;
import kr.pe.okjsp.util.DbCon;
import kr.pe.okjsp.util.MailUtil;

/**
 * 회원 정보를 처리하는 클래스입니다.
 * @author  kenu
 */
public class MemberHandler {
	DbCon dbCon = new DbCon();

	static final String QUERY_EXISTS
		= "select count(id) from okmember where lower(id)=lower(?)";
	static final String QUERY_EMAIL_EXISTS
		= "select count(email) from okmember where lower(email)=lower(?)";
	static final String QUERY_MAX_SID
		= "select max(sid) from okmember";
	static final String QUERY_ADD
		= "insert into okmember (id, \"password\", name, email, homepage, joindate, mailing, sid, profile) values (?, old_password(?), ?, ?, ?, SYSTIMESTAMP, ?, ?, ?)";
	static final String QUERY_ROLE_ADD
		= "insert into okrole (id, \"role\") values (?,?)";
	static final String QUERY_LOGIN
		= "select * from okmember where id = ? and \"password\" = old_password(?)";
	static final String QUERY_ROLE
		= "select \"role\" from okrole where id = ?";
	static final String QUERY_COUNT
		= "select count(id) from okmember";
	static final String QUERY_UPDATE
		= "update okmember set \"password\" = old_password(?), name=?, email=?, homepage=?, mailing=? where id = ?";
	static final String QUERY_PROFILELOG
		= "update okmember set profile = 'Y' where sid = ?";
	static final String QUERY_DELETE
		= "delete from okmember where id = ? and \"password\" = old_password(?)";
	static final String QUERY_MAILING_STATUS
		= "select mailing from okmember where lower(email) = lower(?)";
	static final String QUERY_MAILING
		= "update okmember set mailing='N' where lower(email) = lower(?)";

	/**
	 * Method isIdExist.
	 * @param id
	 * @return boolean
	 * @throws SQLException
	 */
	public boolean isIdExist(String id) throws SQLException {
		boolean b_id_exist = true; // default true;

		if (id==null) return true;

		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;


		try{
			pstmt = pconn.prepareStatement(QUERY_EXISTS);
			pstmt.setString(1,id);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt == 0) b_id_exist = false;
			}
			rs.close();
			pstmt.close();
		}catch(Exception e){
			System.out.println("Member Handler isIdExist err:"+e.getMessage());
		} finally {
			dbCon.close(pconn, pstmt, rs);
		} // end try catch

		return b_id_exist;
	}


	/**
	 * Method isEmailExist.
	 * @param email
	 * @return boolean
	 * @throws SQLException
	 */
	public boolean isEmailExist(String email) throws SQLException {
		boolean b_email_exist = true; // default true;

		if (email==null) return true;

		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			pstmt = pconn.prepareStatement(QUERY_EMAIL_EXISTS);
			pstmt.setString(1,email);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt == 0) b_email_exist = false;
			}
			rs.close();
			pstmt.close();
		}catch(Exception e){
			System.out.println("Member Handler isEmailExist err:"+e.getMessage());
		} finally {
			dbCon.close(pconn, pstmt, rs);
		} // end try catch

		return b_email_exist;
	}

	/**
	 * Method changeInfo
	 * @param member
	 * @return int
	 * @throws SQLException
	 */
	public String changeInfo(Member member, String pact, String contextRoot) throws SQLException {
		if("modify".equals(pact)) {
			switch (updateMember(member)) {
				case 1:
				   return "수정했습니다.";
				default:
				   throw new SQLException("장애가 발생했습니다.");
			}
		} else if ("delete".equals(pact)){
			switch (deleteMember(member)) {
				case 1:
				   return "삭제되었습니다. 언제든 다시 가입하십시오.";
				default:
				   throw new SQLException("비밀번호가 틀리거나 장애가 발생했습니다.");
			}
		} else {
			switch (addMember(member, contextRoot)) {
				case 1:
					return "가입을 환영합니다.";
				default:
				   throw new SQLException("장애가 발생했습니다.");
			}
		}
	}

	/**
	 * @param member
	 * @return
	 */
	private int deleteMember(Member member) throws SQLException {
		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;

		int result_cnt = 0;

		try{
			pstmt = pconn.prepareStatement(QUERY_DELETE);
			pstmt.setString(1,member.getId());
			pstmt.setString(2,member.getPassword());

			result_cnt = pstmt.executeUpdate();

			pstmt.close();

		}catch(Exception e){
			throw new SQLException("Delete Info err:"+e.toString());
		} finally {
			dbCon.close(pconn, pstmt);
		} // end try catch

		return result_cnt;
	}

	/**
	 * @param member 수정할 회원정보
	 * @return int 처리코드
	 * @throws SQLException
	 */
	private int updateMember(Member member) throws SQLException {
		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;

		int result_cnt = 0;

		try{
			pstmt = pconn.prepareStatement(QUERY_UPDATE);
			pstmt.setString(1,member.getPassword());
			pstmt.setString(2,member.getName());
			pstmt.setString(3,member.getEmail());
			pstmt.setString(4,member.getHomepage());
			pstmt.setString(5,member.getMailing());
			pstmt.setString(6,member.getId());

			result_cnt = pstmt.executeUpdate();

			pstmt.close();

		}catch(Exception e){
			throw new SQLException("Modify Info err:"+e.toString());
		} finally {
			dbCon.close(pconn, pstmt);
		} // end try catch

		return result_cnt;
	}

	/**
	 * Method addMember.
	 * @param member
	 * @return int
	 * @throws SQLException
	 */
	private int addMember(Member member, String contextRoot) throws SQLException {
		if (isEmailExist(member.getEmail()))
			throw new SQLException("중복된 email이 있습니다.");

		Connection pconn = dbCon.getConnection();
		pconn.setAutoCommit(false);

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int insert_cnt = 0;

		try{
			member.setPassword("vv"+new Random().nextInt(1000000));
			pstmt = pconn.prepareStatement(QUERY_MAX_SID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member.setSid(rs.getLong(1) + 1);
			}
			rs.close();
			pstmt.close();
			
			pstmt = pconn.prepareStatement(QUERY_ADD);
			pstmt.setString(1,member.getId());
			pstmt.setString(2,member.getPassword());
			pstmt.setString(3,member.getName());
			pstmt.setString(4,member.getEmail());
			pstmt.setString(5,member.getHomepage());
			pstmt.setString(6,member.getMailing());
			pstmt.setLong  (7,member.getSid());
			pstmt.setString(8,member.getProfile());

			insert_cnt = pstmt.executeUpdate();

			pstmt.close();

			pstmt = pconn.prepareStatement(QUERY_ROLE_ADD);
			pstmt.setString(1,member.getId());
			pstmt.setString(2,"friend");

			pstmt.executeUpdate();
			pstmt.close();
			
			String mailto = member.getEmail();
			String subject = "[OKJSP]Confirmation Mail #" + member.getSid();
			String textMessage = "Thank you for joining OKJSP with id '" 
			    + member.getId() + "'\n"
				+ "\nYour temporary password : " + member.getPassword()
				+ "\nAfter login you can change your password as you like."
				+ "\n" + Navigation.getPath("LOGFORM") 
				+ "\n\nJSP/Eclipse developer community http://www.okjsp.net ";
			new MailUtil().send(mailto, subject, textMessage);
			
			ProfileUtil profileUtil = new ProfileUtil();
			profileUtil.copyDefaultProfile(contextRoot, member.getSid());

			pconn.commit();
		}catch(Exception e){
			pconn.rollback();
			throw new SQLException("Register err:"+e.toString());
		} finally {
			pconn.setAutoCommit(true);
			dbCon.close(pconn, pstmt, rs);
		} // end try catch

		return insert_cnt;
	}

	/**
	 * Method doLogin.
	 * @param member
	 * @return
	 * @throws Exception
	 */
	public int doLogin(Member member) throws Exception {

		if (member.getId()==null) return 0;

		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int sts = 0;

		try{
			pstmt = pconn.prepareStatement(QUERY_LOGIN);
			pstmt.setString(1,member.getId());
			pstmt.setString(2,member.getPassword());
			rs = pstmt.executeQuery();

			if(rs.next()) {
				member.setName    (rs.getString("name")    );
				member.setPassword(rs.getString("password"));
				member.setEmail   (rs.getString("email")   );
				member.setHomepage(rs.getString("homepage"));
				member.setJoindate(rs.getTimestamp("joindate"));
				member.setProfile (rs.getString("profile"));
				member.setMailing (rs.getString("mailing"));
				member.setPoint   (rs.getLong  ("point"));
				member.setSid     (rs.getLong  ("sid"));
			} else {
				throw new SQLException("비밀번호가 틀립니다.");
			}

			pstmt.close();

			if (member.getSid() > 0) {
				// 로그인을 통과한 경우 해당 role 을 불러온다.
				ArrayList<String> role = new ArrayList<String>();

				pstmt = pconn.prepareStatement(QUERY_ROLE);
				pstmt.setString(1,member.getId());

				rs = pstmt.executeQuery();

				while(rs.next()) {
					role.add(rs.getString(1));
				}
				rs.close();
				pstmt.close();
				member.setRole(role);
				new PointDao().log(member.getSid(), 1, 1, "login");
				sts = 1;
			} else {
				sts = 2; // wrong password
			}

		}catch(Exception e){
			throw e;
		} finally {
			dbCon.close(pconn, pstmt, rs);
		} // end try catch

		return sts;
	}

	/**
	 * Method getCount.
	 * @return  int
	 * @throws SQLException
	 * @uml.property  name="count"
	 */
	public int getCount() throws SQLException {
		return new DaoUtil().getNumber(dbCon.getConnection(), QUERY_COUNT);
	}

	/**
	 * 프로필 업데이트
	 * @param sid
	 * @throws SQLException
	 */
	public void profileLog(long sid) throws SQLException {
		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;

		try{
			pstmt = pconn.prepareStatement(QUERY_PROFILELOG);
			pstmt.setLong(1, sid);
			pstmt.executeUpdate();

			pstmt.close();
		} catch(Exception e){
		} finally {
			dbCon.close(pconn, pstmt);
		} // end try catch

	}
	/**
	 * 메일수신 거부 업데이트
	 * @param email
	 * @throws SQLException
	 */
	public String reject(String email) throws SQLException {
		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		
		if (!isEmailExist(email)) {
			return "없는 메일 주소입니다.";
		}
		
		try{
			pstmt = pconn.prepareStatement(QUERY_MAILING);
			pstmt.setString(1, email);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch(Exception e){
			System.out.println(e.toString());
		} finally {
			dbCon.close(pconn, pstmt);
		} // end try catch
		
		if (result == 1) {
			return "메일 수신 거부 요청 처리되었습니다.";
		} else {
			return "메일 수신 거부 요청이 처리되지 않았습니다. <br> " +
				" kenu@okjsp.pe.kr로 메일을 주시면 수동으로 수신거부요청을 처리해드리겠습니다.";
		}
	}
	/**
	 * Method mailing yn
	 * @param email
	 * @return boolean
	 * @throws SQLException
	 */
	public boolean isMailing(String email) throws SQLException {
		boolean b_email_exist = true; // default true;

		if (email==null) return true;

		Connection pconn = dbCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			pstmt = pconn.prepareStatement(QUERY_MAILING_STATUS);
			pstmt.setString(1,email);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt == 0) b_email_exist = false;
			}
			rs.close();
			pstmt.close();
		}catch(Exception e){
			System.out.println("Member Handler isEmailExist err:"+e);
		} finally {
			dbCon.close(pconn, pstmt, rs);
		} // end try catch

		return b_email_exist;
	}

}
