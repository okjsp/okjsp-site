package kr.pe.okjsp.member;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.util.Thumbnailer;

import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class for Servlet: ProfileHandler
 *
 */
 public class ProfileHandler extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public ProfileHandler() {
		super();
	}   	 	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		long sid = 0L;
		try {
			sid = ((Member)request.getSession().getAttribute("member")).getSid();
		} catch (Exception e) {
		}
		if (sid == 0) {
			throw new ServletException("need login");
		}
		// 임시디렉토리에 파일 저장
		File file = saveToTemp(request);
		// 파일 리사이징
        Thumbnailer tt = new Thumbnailer(file.getPath(),
        		getServletContext().getRealPath(request.getContextPath())
				+ "/profile/"+ sid + ".jpg", 
                385, 385);
        tt.createThumbnail();
        try {
			Thread.sleep(1000);
		} catch (InterruptedException e1) {
		}
        boolean delete = file.delete();
        System.out.println("del:"+delete);
		// DB 기록
		try {
			storeProfileInfo(sid);
		} catch (SQLException e) {
			throw new ServletException("can't log profile");
		}
		// 메시지 출력 페이지로 이동
		response.sendRedirect("/jsp/member/profileResult.jsp");
		// 실패한 경우 입력 페이지로 메시지 전달
		// 성공한 경우 프로필 페이지로 이동
	}

	/**
	 * 임시 디렉토리 "/profile/temp/"에 파일 업로드
	 * @param request
	 * @return
	 * @throws IOException
	 */
	private File saveToTemp(HttpServletRequest request) throws IOException {
		String uploadDir = getServletContext().getRealPath(request.getContextPath())
						+ "/profile/temp";
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            boolean mkdirs = dir.mkdirs();
            if (!mkdirs) {
            	throw new IOException("can't create dir");
            }
        }
		MultipartRequest multi =
			new MultipartRequest(
				request,
				uploadDir ,
				10 * 1024 * 1024);
		File file = null;
		Enumeration files = multi.getFileNames();
		while (files.hasMoreElements()) {
			String name = (String) files.nextElement();
			file = multi.getFile(name);
		}
		if (file == null) {
			throw new IOException("no file");
		}
		return file;
	}   	  	    

	private void storeProfileInfo(long id) throws SQLException {
		new MemberHandler().profileLog(id);
	}
	
}