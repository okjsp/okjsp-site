<%@ page pageEncoding="utf-8"
import="kr.pe.okjsp.*,
        kr.pe.okjsp.member.*" %><%
	String result = "ok";
	try {
	    String tag = request.getParameter("tag");
		String id = null;
		Member member = (Member)session.getAttribute("member");
		if (member != null) {
			id = member.getId();
		}
		if (id == null || id.trim().length() == 0) {
			throw new Exception ("need login");
		}
		int seq = Integer.parseInt(request.getParameter("seq"));
		if (tag != null && tag.trim().length() > 0) {
			if (tag.indexOf("<") > -1) {
				throw new Exception("no HTML tag");
			}
			new TagHandler().add(tag, id, seq);
		} else {
			throw new Exception("need tag");
		}
	} catch (Exception e) {
		result = e.getMessage();
	}

%><%= result %>