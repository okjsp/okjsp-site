<%@ page pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"
	import="java.util.*,kr.pe.okjsp.*,
	kr.pe.okjsp.util.CommonUtil,
	kr.pe.okjsp.util.DateLabel" 
%><%
	int mp = Integer.parseInt(CommonUtil.nchk(request.getParameter("mp"), "0"));
	ArrayList<MemoBean> recent = new MemoHandler().getRecent(mp);	
%>{"paging":{"page":<%= mp + 1 %>,"total":3515,"page_size":20,"pages":176},
"memos":[
<% for(MemoBean memo: recent) { %>{"mseq":"http://www.okjsp.pe.kr/seq/<%= memo.getSeq()+"#"+memo.getMseq() %>","profile_img":"http://www.okjsp.pe.kr/profile/<%= memo.getSid() %>.jpg",
"writer":"<%= CommonUtil.rplc( CommonUtil.rplc( CommonUtil.rplc( memo.getWriter(), "\r\n", " " ), "\\", "\\\\") , "\"", "\\\"") %>",
"timestamp":"<%= memo.getWhen("yyyy-MM-dd HH:mm:ss") %>",
"memo":"<%= CommonUtil.rplc( CommonUtil.rplc( CommonUtil.rplc( memo.getBcomment(), "\r\n", " " ), "\\", "\\\\") , "\"", "\\\"") %>"
},
<% } %>
]
}