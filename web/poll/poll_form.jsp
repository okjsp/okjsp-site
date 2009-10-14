<%@ page import="kr.pe.okjsp.util.*,java.sql.*"
pageEncoding="euc-kr"
errorPage="error.jsp"%>
<%
	response.setContentType("text/html;");
	String seq = CommonUtil.nchk(request.getParameter("seq"));
	String pg  = CommonUtil.nchk(request.getParameter("pg"));
	pg = pg.equals("")?"0":pg;

	Connection pconn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String question = "";
	int vtype=1;

	try {
		pconn = DbCon.getConnection();

		String query="";

		query = "select * from polllist where active = 1 order by seq desc";
		if (!seq.equals("")) {
			query = "select * from polllist where seq = ?";
		}
		pstmt = pconn.prepareStatement(query);

		if (!seq.equals("")) {
			pstmt.setString(1,seq);
		}
		rs = pstmt.executeQuery();
		if (rs.next()) {
			question = CommonUtil.k2a(rs.getString("question"));
			vtype    = rs.getInt("vtype");
			seq      = rs.getString("seq");
		}

		rs.close();
		pstmt.close();

		// item 출력
		if (!seq.equals("")) {
%>
<link rel="stylesheet" href="/poll/poll.css" type="text/css">
<script language="JavaScript" src="/poll/js/poll.js"></script>

<form name="fp" action="/poll/poll_to.jsp" method="post" onSubmit="return pollchk(this)">
<table width="178" border="0" align="center" cellpadding="0" cellspacing="0" class="tb_b">
	<tr>
		<td>
<input type="hidden" name="vtype" value="<%=vtype%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="pg" value="<%=pg%>">
<table width="178" border="0" align="center" cellpadding="4" cellspacing="1">
<tr>
<td colspan="2" class="td_c"><b>Q:<%=question%></b>
</td>
</tr>
<tr>
<td colspan="2" class="td_w">
<%
		query = "select * from pollitem where seq = ? and itemseq >= 0 ";
		int itemseq=0;
		String item = "";
		String type = "radio";
		if(vtype>1) type="checkbox";

		pstmt = pconn.prepareStatement(query);
		pstmt.setString(1,seq);
		rs = pstmt.executeQuery();

		while(rs.next()) {
			itemseq = rs.getInt("itemseq");
			item    = CommonUtil.k2a(rs.getString("item"));
%>
<input type="<%=type%>" name="item" value="<%=itemseq%>" class="chk">
<%=item%>
<br>
<%
		} // end while

		pstmt.close();
%>
</td>
</tr>
<tr align="center">
<td width="50%" class="td_w">
<% if (!CommonUtil.getCookie(request, "okpoll"+seq).equals("ok")) { %>
<input type="submit" value="투표" class="ipt2">
<%}else{%>
투표
<%}%>
</td>
<td width="50%" class="td_w">
<input type="button" value="결과" onClick="window.open('/poll/poll_view.jsp?seq=<%=seq%>','poll','height=400,width=380,resizable=yes,scrollbars=yes')" class="ipt2">
</td>
</tr>
</table>
</td></tr></table>
</form>
<script>
function pollchk(n) {
	for(i=0;i<n.item.length;i++) {
		if(n.item[i].checked) return confirm("투표하시겠습니까?");
	}
	return false;
}
</script>
<%
		} // end if item 출력

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
		if (rs != null ) {
			rs.close();
		}
		} catch (SQLException e) {
			while((e=e.getNextException())!=null) {
				out.println(" rs next : "+e.getMessage());
			}
		}
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
%>
