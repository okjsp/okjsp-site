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
 * jangmj			2013. 3. 29.				First Draft.
 */

package kr.pe.okjsp;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.member.Member;

/** 
 * 간단한 클래스 설명 (short description about class)
 * 자세한 클래스 설명 (full description about class)
 * 
 * @author    jangmj 
 * @version   1.0 
 *
 * This file contains the declarations of String class and its helper classes. 
 */

public class HateServlet extends HttpServlet {
	public void service(HttpServletRequest request, HttpServletResponse response)throws IOException {
		String mode = request.getParameter("mode");
		String hateString = request.getParameter("hateString");
		long sid = 0L;
		try {
			sid = ((Member)request.getSession().getAttribute("member")).getSid();
		} catch (Exception e) {
			//e.printStackTrace();
		}
		
		HateDao dao = new HateDao();
		//insert
		if(hateString!=null){
			try {
				if(mode == null)
					dao.insert(sid, hateString);
				else dao.update(sid, hateString);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//select
		try {
			hateString = dao.select(sid);
			request.setAttribute("result", hateString);
			request.getRequestDispatcher("/jsp/ihateyou/hateList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
