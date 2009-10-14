<%@ page 
	import="kr.pe.okjsp.util.*,java.sql.*" contentType="text/html;charset=euc-kr" errorPage="error.jsp"%>
<%@ include file="pollcfg.jsp" %><%
String pg  = CommonUtil.nchk(request.getParameter("pg"));
String seq = CommonUtil.nchk(request.getParameter("seq"));
String [] item = request.getParameterValues("item");

Connection pconn = null;
PreparedStatement pstmt = null;

try {
	pconn = DbCon.getConnection();
	pconn.setAutoCommit(false);
	
	String query = "update "+itemTableName+" set hit=hit+1 where seq = ? and itemseq = ?";
	
	pstmt = pconn.prepareStatement(query);
	
	for (int i=0;i<item.length;i++) { 
 %><br><%=i%>: <%=item[i]%>
<% 
		pstmt.setString(1,seq);
		pstmt.setString(2,item[i]);
		pstmt.executeUpdate();
	} // end for 

	pstmt.close();
	
	pconn.commit();
	pconn.close();
	
	// 중복투표방지 쿠키 설치
	CommonUtil.setCookie(response, "okpoll"+seq,"ok");

} catch(Exception e){
	out.println(e.getMessage());
	try {
	if (pconn != null ) {
		pconn.rollback();
	}
	} catch (SQLException se) {
		System.out.println(" pconn : "+se.getMessage());
		while((e=se.getNextException())!=null) {
			out.println(" pstmt next : "+se.getMessage());
		}
	}
} finally {
	try {
	if (pstmt != null ) {
		pstmt.close();
	}
	} catch (SQLException e) {
		System.out.println(" pstmt : "+e.getMessage());
		while((e=e.getNextException())!=null) {
			out.println(" pstmt next : "+e.getMessage());
		}
	}
	try {
	if (pconn != null ) {
		pconn.close();
	}
	} catch (SQLException e) {
		System.out.println(" pconn : "+e.getMessage());
		while((e=e.getNextException())!=null) {
			out.println(" pstmt next : "+e.getMessage());
		}
	}
}

String goURI = "poll_list.jsp?seq="+seq+"&pg="+pg;
session.setAttribute("goURI",goURI);
%>
<script>
alert("투표에 참가하셨습니다.");
document.location="go.jsp";
</script>
