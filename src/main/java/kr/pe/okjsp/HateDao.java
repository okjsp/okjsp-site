/*
 * Copyright (c) 2011 LOTTESHOPPING Co. Ltd
 * All right reserved.
 *
 * This software is the confidential and proprietary information of LOTTESHOPPING Co. Ltd.
 * You shall not disclose such Confidential Information and shall use it only in accordance
 * with the terms of the license agreement  you entered into with LOTTESHOPPING Co. Ltd
 * 
 *
 * Revision History
 * Author               Date             Description
 * ---------------   --------------    ------------------
 * jangmj			2013. 3. 28.				First Draft.
 */

package kr.pe.okjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.pe.okjsp.member.PointDao;
import kr.pe.okjsp.util.DbCon;

/** 
 * 간단한 클래스 설명 (short description about class)
 * 자세한 클래스 설명 (full description about class)
 * 
 * @author    jangmj 
 * @version   1.0 
 *
 * This file contains the declarations of String class and its helper classes. 
 */

public class HateDao {
	
	//test 입니다.
	public String select(long sid)throws Exception{
		String hateList = ""; 
		{
			DbCon dbCon = new DbCon();
			Connection pconn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			try{
				pconn = dbCon.getConnection();
				pstmt = pconn.prepareStatement("select sid, trim(hate_key) as HATE_KEY from ok_hate where sid = ?");
				pstmt.setLong(1, sid);
				rs = pstmt.executeQuery();
				int tmpCount = 0;
				while(rs.next()){
					if(tmpCount++ > 0) hateList += ";";
					hateList += rs.getString("HATE_KEY");
				}
				//out.println(hateList);
				
			} catch(SQLException e) {
				System.out.println(e.toString());
				throw e;
			} finally {
				dbCon.close(pconn, pstmt, rs);
			}
		}
		return hateList;
	}
	
	public boolean insert(long sid, String hateString)throws Exception{
		hateString = ";" + hateString + ";";
		hateString = hateString.replaceAll(";;", ";");
		return deleteInsert(sid, hateString);
	}
	
	public boolean update(long sid, String hateString)throws Exception{
		//1. select
		String orgString = select(sid);
		if(!orgString.equals("")){
			System.out.println("new ::: " + (orgString + ";" + hateString));
			hateString = orgString + ";" + hateString;			
		}
		hateString = ";" + hateString + ";";
		hateString = hateString.replaceAll(";;", ";");
		
		return deleteInsert(sid, hateString);
	}
	
	public boolean deleteInsert(long sid, String hateString)throws Exception{
		{
			DbCon dbCon = new DbCon();
			Connection pconn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			try{			
				//1. delete
				pconn = dbCon.getConnection();
				pstmt = pconn.prepareStatement("delete from ok_hate where sid = ?");
				pstmt.setLong(1, sid);
				pstmt.executeUpdate();
				
				//2. insert
				pstmt = pconn.prepareStatement("insert into ok_hate(sid, hate_key) values(?,?)");
				pstmt.setLong(1, sid);
				pstmt.setString(2, hateString);
				pstmt.executeUpdate();	
			} catch(SQLException e) {
				System.out.println(e.toString());
				throw e;
			} finally {
				dbCon.close(pconn, pstmt, rs);
			}
		}
		
		return true;
	}
	
	
}
