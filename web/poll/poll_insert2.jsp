<%@ page pageEncoding="euc-kr"
	import="kr.pe.okjsp.util.*,java.sql.*" errorPage="error.jsp"%>
<%@ include file="pollcfg.jsp" %>
<%
	String polladm = CommonUtil.nchk((String)session.getAttribute("polladm"));
	if (polladm.equals("ok")) {
		
		// Request
		String question= request.getParameter("question");
		String pg= CommonUtil.nchk(request.getParameter("pg"));
		pg = (pg==null||pg.equals(""))?"0":pg;
		String [] item = request.getParameterValues("item");
		String s_date = request.getParameter("s_year")+"/"+request.getParameter("s_month")+"/"+request.getParameter("s_day");
		String e_date = request.getParameter("e_year")+"/"+request.getParameter("e_month")+"/"+request.getParameter("e_day");
		String vtype  = CommonUtil.nchk(request.getParameter("vtype"));
		int itemcnt = 0;
%>
<b><%=question%></b>
<%
		for (int i=0;i<item.length;i++) { 
			item[itemcnt] = CommonUtil.nchk(item[i]);
			if (!item[i].equals("")) {
 %><br><%=++itemcnt%>: <%=item[i]%>
<% 
		  	} // end if
		} // end for %>
<br>시작일 : <%= s_date %>
<br>종료일 : <%= e_date %>
<br>다중답변 : <%= vtype %>
<%if (question.length()==0 || vtype.length()==0){%>
<script>
history.back();
</script>
<%}else{
Connection pconn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	pconn = DbCon.getConnection();
	
	pconn.setAutoCommit(false);
	
	// 질문 입력
	String queryMax = "select max(seq) from "+tableName;
	String query=
		"insert into "+tableName+ "(seq, question, sdate, edate, vtype, wtime) values (?, ?, ?, ?, ?, now())";
	pstmt = pconn.prepareStatement(queryMax);
	rs = pstmt.executeQuery();
	int seq = 0;
	if(rs.next()) {
		seq = rs.getInt(1);
	}
	rs.close();
	pstmt.close();
	
	seq++;
	pstmt = pconn.prepareStatement(query);
	
	pstmt.setInt   (1,seq);
	pstmt.setString(2,question);
	pstmt.setString(3,s_date);
	pstmt.setString(4,e_date);
	pstmt.setString(5,vtype);
	
	pstmt.executeUpdate();
	
	pstmt.close();
	
	// item 입력
	query = "insert into "+itemTableName+" (seq, itemseq, item) values ( ?,?,?)";
	pstmt = pconn.prepareStatement(query);
	
	for(int i=0;i<itemcnt;i++) {
		pstmt.setInt(1,seq);
		pstmt.setInt(2,i);
		pstmt.setString(3,item[i]);
		pstmt.executeUpdate();
	}
	
	pstmt.close();
	
	pconn.commit();
	pconn.close();
	
} catch(Exception e){
	out.println(e.getMessage());
	try {
	if (pconn != null ) {
		pconn.rollback();
	}
	} catch (SQLException se) {
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
		while((e=e.getNextException())!=null) {
			out.println(" pstmt next : "+e.getMessage());
		}
	}
	try {
	if (pconn != null ) {
		pconn.close();
	}
	} catch (SQLException e) {
		while((e=e.getNextException())!=null) {
			out.println(" pstmt next : "+e.getMessage());
		}
	}
}
String goURI = "poll_list.jsp?pg="+pg;
session.setAttribute("goURI",goURI);
%>
<script>
alert("폴이 추가되었습니다.");
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
