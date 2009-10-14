<%@ page import="kr.pe.okjsp.util.*,java.sql.*,java.text.*" contentType="text/html;charset=euc-kr" errorPage="error.jsp"%>
<%@ include file="pollcfg.jsp" %>
<%
String seq = CommonUtil.nchk(request.getParameter("seq"));
String pg  = CommonUtil.nchk(request.getParameter("pg"));
pg = pg.equals("")?"0":pg;

Connection pconn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String question = "";
int vtype=1, imax=0, isum=0;

try {
	pconn = DbCon.getConnection();
	String query="";
	if (seq.equals("")) {
		query = "select max(seq) seq from "+tableName;
		pstmt = pconn.prepareStatement(query);

		rs = pstmt.executeQuery();
		if (rs.next()) {
			seq      = CommonUtil.nchk(rs.getString("seq"));
		}

		rs.close();
		pstmt.close();
	}

	query = "select max(question) question, max(vtype) vtype, max(hit) imax, sum(hit) isum from "+tableName+ " a , "+itemTableName+ " b where a.seq = ? and a.seq=b.seq";

	pstmt = pconn.prepareStatement(query);

		pstmt.setString(1,seq);

	rs = pstmt.executeQuery();
	if (rs.next()) {
		question = CommonUtil.nchk(rs.getString("question"));
		vtype    = rs.getInt("vtype");
		imax     = rs.getInt("imax");
		isum     = rs.getInt("isum");
	}

	rs.close();
	pstmt.close();

	// item 출력
	if (!seq.equals("")) {
%>
<link rel="stylesheet" href="poll.css" type="text/css">
<table border="0" width="90%" align="center" cellpadding="0" cellspacing="0" class="tb_b">
	<tr>
		<td>
<table border="0" width="100%" align="center" cellpadding="4" cellspacing="1">
    <tr>
			<td colspan="2" class="td_c">
			<b>Q:<%=question%></b>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" class="td_c">
			총투표수 : <b><%=isum%><b>
			</td>
		</tr>
<%
		query = "select * from "+itemTableName+" where seq = ? order by itemseq";

		int itemseq=0, hit=0;
		int xx=90;
		double ratio = 0;
		String item = "";
		String type = "radio";
		NumberFormat nf = NumberFormat.getPercentInstance();

		pstmt = pconn.prepareStatement(query);
		pstmt.setString(1,seq);
		rs = pstmt.executeQuery();

		while(rs.next()) {
			itemseq = rs.getInt("itemseq");
			item    = rs.getString("item");
			hit     = rs.getInt("hit");
			ratio   = hit / (double)imax;
%><tr>
<td class="td_w">
<%=item %>
</td>
<td class="td_w">
<img src="images/poll1.gif" height="10" width="1"><img
src="images/poll2.gif" height="10" width="<%=ratio * xx %>"><img
src="images/poll3.gif" height="10" width="1">
[ <%=hit %> ] <%= (int)(hit * 1000/isum) / 10.0 %>%
</td>
<%
		} // end while

		pstmt.close();
%>
</tr>
</table>

</td></tr></table>
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
<table border="0" align="center" cellpadding="4" cellspacing="0">
    <tr>
    	<td class="tb_w">
    	<br><br>
    	<a href="#" onClick="javascript:window.close();">닫기</a>
    	</td>
    </tr>
</table>
