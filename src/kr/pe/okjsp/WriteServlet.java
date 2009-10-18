package kr.pe.okjsp;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.okjsp.util.CommonUtil;
import kr.pe.okjsp.util.DbCon;

import com.oreilly.servlet.MultipartRequest;

public class WriteServlet extends HttpServlet {

	private static final long serialVersionUID = 4181913566227354988L;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws IOException, ServletException {
		String bbs;
	    if("application/x-www-form-urlencoded".equals(req.getContentType())) {
	    	bbs = write(req, res);
	    } else {
	    	bbs = writeWithFiles(req, res);
	    }

		String togo = "/bbs?act=LIST&bbs=" + bbs + "&pg=0";
		res.sendRedirect(togo);

	} // end doPost()

	private String write(HttpServletRequest req, HttpServletResponse res) {
		String id = CommonUtil.getCookie(req, "okid");
		long sid = CommonUtil.getCookieLong(req, "sid");
		Article article = new Article();
		article.setId(id);
		article.setSid(sid);

		String writer = req.getParameter("writer");
		String bbs = req.getParameter("bbs");
		String content = req.getParameter("content");
		String subject = req.getParameter("subject");
		String homepage = req.getParameter("homepage");
		String password = req.getParameter("password");
		String html = req.getParameter("html");
		String ccl_id = req.getParameter("ccl_id");

		article.setWriter(writer);
		article.setBbs(bbs);
		article.setContent(content);
		article.setSubject(subject);
		article.setHomepage(homepage);
		article.setPassword(password);
		article.setHtml(html);
		article.setCcl_id(ccl_id);
		
		new ArticleDao().write(article);
		return article.getBbs();
	}

	private String writeWithFiles(HttpServletRequest req,
			HttpServletResponse res) throws IOException {
		// 디렉토리 확인
        String uploadDir = getServletContext().getRealPath(req.getContextPath())+Navigation.getPath("UPDIR");
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            boolean mkdirs = dir.mkdirs();
            if (!mkdirs) {
            	throw new IOException("can't create dir");
            }
        }
        
		MultipartRequest multi =
			new MultipartRequest(
				req,
				uploadDir,
				200 * 1024 * 1024);
		// 200MB

		ArrayList<DownFile> arrdf = new ArrayList<DownFile>();
		Article article = null;
		String id = CommonUtil.getCookie(req, "okid");
		long sid = CommonUtil.getCookieLong(req, "sid");
		try {
			
			int seq = 0, ref = 0, lev = 0, step = 0;
			String writer = multi.getParameter("writer");
			String bbs = multi.getParameter("bbs");
			String content = multi.getParameter("content");
			String email = multi.getParameter("email");
			String subject = multi.getParameter("subject");
			String homepage = multi.getParameter("homepage");
			String password = multi.getParameter("password");
			String html = multi.getParameter("html");
			String ccl_id = multi.getParameter("ccl_id");
			
			
			//id 
		    boolean isLogin = sid > 0;
		    if (!isLogin) {
		        res.sendRedirect(Navigation.getPath("LOGFORM"));
		        return null;
		    }

			article =
				new Article(
					bbs,
					seq,
					ref,
					step,
					lev,
					id,
					sid,
					writer,
					subject,
					content,
					password,
					email,
					homepage,
					0,
					null,
					html,
					req.getRemoteAddr(), ccl_id);

			int cnt = 0;
			Enumeration<String> files = multi.getFileNames();
			while (files.hasMoreElements()) {
				String name = files.nextElement();
				File f = multi.getFile(name);
				if (f != null) {
					arrdf.add(new DownFile(f, cnt++));
				}
			}
		} catch (Exception e) {
			System.out.println("WriteServlet:" + CommonUtil.a2k(e.toString()));
		}

		if (hasNothing(article)) {
			throw new SecurityException("no content");
		}
		
		/*
			db 입력
		*/
		DbCon dbCon = new DbCon();
		Connection conn = null;
		ArticleDao articleDao = new ArticleDao();
		try {

			conn = dbCon.getConnection();;

			String act = multi.getParameter("act");
			String[] delFiles = null;

			int seq = 0;
			if ("MODIFY".equals(act)) {
				seq = Integer.parseInt(multi.getParameter("seq"));
				delFiles = multi.getParameterValues("delFile");
				article.setSeq(seq);
			}

			if ("REPLY".equals(act)) {
				article.setRef(Integer.parseInt(multi.getParameter("ref")));
				article.setLev(Integer.parseInt(multi.getParameter("lev")));
				article.setStep(
						Integer.parseInt(multi.getParameter("step")));
				articleDao.reply(conn, article);

			} else if ("MODIFY".equals(act)) {
				articleDao.modify(conn, article);
				articleDao.deleteFiles(conn, delFiles);
			} else {
				articleDao.write(conn, article);
			}

			articleDao.addFile(conn, article.getSeq(), arrdf);
			
		} catch (Exception e) {
			System.out.println("WriteServlet err:" + CommonUtil.a2k(e.toString()));
		} finally {
			dbCon.close(conn, null);
		}

		return article.getBbs();
	}

	public boolean hasNothing(Article article) {
		boolean hasNothing = article.getSubject() == null
				|| "".equals(article.getSubject().trim())
				|| article.getContent() == null
				|| "".equals(article.getContent().trim())
				|| article.getBbs() == null
				|| "".equals(article.getBbs().trim())
				;
		return hasNothing;
	}
}
