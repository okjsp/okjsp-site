<%@ page pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"
	import="java.util.*,kr.pe.okjsp.*,
	kr.pe.okjsp.util.CommonUtil,
	kr.pe.okjsp.util.DateLabel" %>
<jsp:useBean id="handler" class="kr.pe.okjsp.MemoHandler"></jsp:useBean>
<html>
<script type="text/javascript">
<%
	int mp = Integer.parseInt(CommonUtil.nchk(request.getParameter("mp"), "0"));
	ArrayList<MemoBean> recent = handler.getRecent(mp);	
%>var data = [<%
	for (MemoBean memo: recent) {
%>{mseq:"http://www.okjsp.pe.kr/seq/<%= memo.getSeq()+"#"+memo.getMseq() %>",
profile_img:"http://www.okjsp.pe.kr/profile/<%= memo.getSid() %>.jpg",
writer:"<%= memo.getWriter() %>",
timestamp:"<%= memo.getWhen("yyyy-MM-dd HH:mm:ss") %>",
memo:"<%= CommonUtil.rplc( CommonUtil.rplc( memo.getBcomment(), "\r\n", " " ), "\"", "\\\"") %>"
},<%
	} // end of for
%>];

document.writeln("<ul>");
for (var idx in data) {
	document.writeln("<li>"+data[idx].memo+"</li>");
}
document.writeln("</ul>");
</script>
</html>
