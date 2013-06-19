package kr.pe.okjsp;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
import kr.pe.okjsp.util.DomainUtil;
import kr.pe.okjsp.util.Spam;

import com.oreilly.servlet.MultipartRequest;

public class WriteServlet extends HttpServlet {

	private static final long serialVersionUID = 4181913566227354988L;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws IOException, ServletException {
		String bbs;
	    boolean equals = "application/x-www-form-urlencoded".equals(req.getContentType());
		if(equals) {
	    	bbs = write(req, res);
	    } else {
	    	bbs = writeWithFiles(req, res);
	    }
	    
		String togo = "/bbs?act=LIST&bbs=" + bbs + "&pg=0";
		res.sendRedirect(togo);

	} // end doPost()

	private String write(HttpServletRequest req, HttpServletResponse res) throws IOException {
		long sid = CommonUtil.getCookieLong(req, "sid");
		Spam.checkSpammer(sid);
		
		Article article = new Article();
		article.setSid(sid);

		String writer = req.getParameter("writer");
		String bbs = req.getParameter("bbs");
		String content = req.getParameter("content");
		String subject = req.getParameter("subject");
		String homepage = req.getParameter("homepage");
		String password = req.getParameter("password");
		String html = req.getParameter("html");
		String ccl_id = req.getParameter("ccl_id");
		String ip = req.getRemoteAddr();

		article.setWriter(writer);
		article.setBbs(bbs);
		article.setContent(content);
		article.setSubject(subject);
		article.setHomepage(homepage);
		article.setPassword(password);
		article.setHtml(html);
		article.setCcl_id(ccl_id);
		article.setIp(ip);
		
		new ArticleDao().write(article);
		
		// 트위터 글쓰기 추가
//		new TwitterUpdate().doUpdate(article, req);
		
		setWriterCookie(DomainUtil.getBaseDomain(req.getRequestURL()), res, article);

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
        
        // MultipartRequest는 인코딩을 지정해 줘야 하기 때문에 request의 인코딩을 뽑아서 넣어줘야합니다.
        String encoding = CommonUtil.nchk(req.getCharacterEncoding(), "euc-kr");
        
		MultipartRequest multi =
			new MultipartRequest(
				req,
				uploadDir,
				200 * 1024 * 1024,
				encoding);
		// 200MB
		ArrayList<DownFile> arrdf = new ArrayList<DownFile>();
		Article article = null;
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
			String ip = req.getRemoteAddr();
			
			//id 
		    boolean isLogin = sid > 0 && !"".equals(writer);
		    if (!isLogin) {
		        res.sendRedirect(Navigation.getPath("LOGFORM"));
		        return null;
		    }
// Multipart 가 들어가면 무조건 8859_1로 변함 ㅡ.ㅡ
			article =
				new Article(
					bbs,
					seq,
					ref,
					step,
					lev,
					null,
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
					ip, ccl_id);

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
		
		String act = multi.getParameter("act");
		
		try {

			conn = dbCon.getConnection();
			conn.setAutoCommit(false);

			
			String[] delFiles = null;

			int seq = 0;
			if ("MODIFY".equals(act)) {
				seq = Integer.parseInt(multi.getParameter("seq"));
				delFiles = multi.getParameterValues("delFile");
				article.setSeq(seq);
			}

			if ("REPLY".equals(act)) {
				article.setSeq(articleDao.getSeq(conn));
				article.setRef(Integer.parseInt(multi.getParameter("ref")));
				article.setLev(Integer.parseInt(multi.getParameter("lev")));
				article.setStep(
						Integer.parseInt(multi.getParameter("step")));
				articleDao.reply(conn, article);

			} else if ("MODIFY".equals(act)) {
				articleDao.modify(conn, article);
				articleDao.deleteFiles(conn, delFiles);
			} else {
				article.setSeq(articleDao.getSeq(conn));
				article.setRef(articleDao.getNewRef(conn, article.getBbs()));
				articleDao.write(article);
			}

			articleDao.addFile(conn, article.getSeq(), arrdf);
			conn.commit();
		} catch (Exception e) {
			System.out.println("WriteServlet err:" + CommonUtil.a2k(e.toString()));
		} finally {
			dbCon.close(conn, null);
		}

		/*
			트위터 글쓰기 추가 
			2010.03.25 윤정부[Coma] 수정 : 수정시 트위터 전송 안되게 처리함.
			act 변수 위치 변경하였음.
		*/
		
		if(!"MODIFY".equals(act) && !"REPLY".equals(act))
		{
//			new TwitterUpdate().doUpdate(article, req);
		}
		
		setWriterCookie(DomainUtil.getBaseDomain(req.getRequestURL()), res, article);
		
		return article.getBbs();
	}

	private void setWriterCookie(String domain, HttpServletResponse res, Article article) {
		try {
			CommonUtil.setCookie(domain, res, "sid", ""+article.getSid());
			CommonUtil.setCookie(domain, res, "okhome", ""+article.getHomepage());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
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
