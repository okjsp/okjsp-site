<%@ page import="kr.pe.okjsp.util.*, java.sql.*" 
	contentType="text/html;charset=euc-kr" errorPage="error.jsp"%>
<%@ include file="pollcfg.jsp" %>
<%
String polladm = CommonUtil.nchk((String)session.getAttribute("polladm"));
if (polladm.equals("ok")) {

	// Request
	String seq = CommonUtil.nchk(request.getParameter("seq"));
	String pg  = CommonUtil.nchk(request.getParameter("pg"));
	if (seq.length()==0) {
%>
<script>
alert("정보가 부족합니다.");
history.back();
</script>
<%
	} else {
		Connection pconn = null;
		PreparedStatement pstmt = null;
		
		String query_del0 = " delete from "+tableName+" where seq = ? ";
		String query_del1 = " delete from "+itemTableName+" where seq = ? ";
		
		try {
			pconn = DbCon.getConnection();
			pconn.setAutoCommit(false);
			
			pstmt = pconn.prepareStatement(query_del0);
			pstmt.setString(1,seq);
			
			pstmt.executeUpdate();
			pstmt.close();
			
			pstmt = pconn.prepareStatement(query_del1);
			pstmt.setString(1,seq);
			
			pstmt.executeUpdate();
			pstmt.close();
			
			pconn.commit();
			pconn.close();
			
		} catch(Exception e){
			out.println(e.getMessage());
		} finally {
			if (pstmt!=null) pstmt.close();
			if (pconn!=null) pconn.close();
		}
		
		String goURI = "poll_list.jsp?pg="+pg;
		session.setAttribute("goURI",goURI);
%>
<script>
alert("폴이 삭제되었습니다.");
document.location="go.jsp";
</script>
<%
	} // end of if
}else{
// 관리자 권한이 없을 경우.
%>
<script>
top.document.location="/";
</script>
<%}%>
