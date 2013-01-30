/*
 * Created on 2003. 5. 7.
 *
 */
package kr.pe.okjsp;

import java.io.BufferedInputStream;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

/**
 * @author kenu
 *
 */
public class DownloadServlet extends HttpServlet {
	DbCon dbCon = new DbCon();
	static Hashtable<String, Long> map = new Hashtable<String, Long>();

	private static final long serialVersionUID = 7852865856740807559L;

	protected void doGet(
		HttpServletRequest request,
		HttpServletResponse response)
		throws ServletException, IOException {
		
		//  Download file
		String maskname = request.getParameter("maskname");
		String agent = request.getHeader("user-agent");
		String ip = request.getRemoteAddr();
		System.out.println(agent +" ip:"+ ip);

		String key = ip + "_" + maskname;
		Long logTime = (Long)map.get(key);
		long now = System.currentTimeMillis();
		if (logTime == null) {
			map.put(key, Long.valueOf(now));
			if (map.size() > 2000) {
				
				Enumeration<String> enumeration = map.keys();
				while (enumeration.hasMoreElements()) {
					String keyTmp = (String) enumeration.nextElement();
					Long oldTime = (Long)map.get(keyTmp);
					if ( now - oldTime.longValue() > 600000) {
						map.remove(keyTmp);
					}
				}
			}
		} else {
			long lastTime = ((Long)map.get(key)).longValue();
			if (now - lastTime < 600000) {
				request.setAttribute(
						"javax.servlet.jsp.jspException",
						"try 10 minutes later");
				System.out.println(agent +" ip:"+ ip + " rejected. "+(now - lastTime));

				request.getRequestDispatcher("/error.jsp").forward(
						request,response);
			}
		}

		boolean isNotValid = maskname == null || maskname.startsWith("..") || 
							"FDM 1.x".equals(agent) || agent.startsWith("NSPlayer");

		if (isNotValid) {
			request.setAttribute(
				"javax.servlet.jsp.jspException",
				"wrong path or FDM rejected");
			// 정식 경로가 아닐 경우 에러 페이지로 이동한다.
			request.getRequestDispatcher("/error.jsp").forward(
				request,response);
			return;
		}

		String key2 = "UPDIR";
		String uploadBase = Navigation.getPath(key2);
		// 절대경로입니다.
		String filePath = getServletContext().getRealPath(request.getContextPath()) + 
                         uploadBase + "/" + maskname;
		File file = new File(filePath); 
		byte b[] = new byte[4096];
		response.setContentType("application/octet-stream");
        //파일크기를 브라우저에 알려준다.
		response.setContentLength((int)file.length());
		String oriFilename = request.getParameter("fileName");
		String eucFilename = new String(oriFilename.getBytes("ISO-8859-1"),"euc-kr");
		String filename = "";
		if (agent.contains("MSIE")) { // IE
			filename = java.net.URLEncoder.encode(eucFilename, "UTF8");
		} else { // FireFox, Safari, Opera, chrome
			filename = oriFilename;
		}
		filename = CommonUtil.rplc(filename, "+", " ");
		response.setHeader(
			"Content-Disposition",
			"attachment;filename=\"" + filename + "\";");
		if (file.isFile()) {
			BufferedInputStream fin =
				new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream outs =
				new BufferedOutputStream(response.getOutputStream());
			int read = 0;
			try {
				while ((read = fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}
				fin.close();
				outs.close();
				
				countUp(maskname);
				map.remove(key);
			} catch (Exception e) {
				System.out.println(getClass().getName() + " "+e.getMessage());
			} finally {
				if (fin != null)
					fin.close();
			}
		}

	}

	/**
	 * @param maskname
	 */
	private void countUp(String maskname) {
		String query = "update okboard_file set download = download + 1 where maskname = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbCon.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, maskname);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.close(conn, pstmt);
		}
		
	}
}
