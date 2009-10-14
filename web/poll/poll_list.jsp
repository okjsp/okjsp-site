<%@ page import="java.sql.*,java.text.*, kr.pe.okjsp.util.*, java.util.Date"
pageEncoding="euc-kr"
errorPage="error.jsp"%>
<% long sTime= System.currentTimeMillis(); %>
<%@ include file="pollcfg.jsp" %>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0);
response.setHeader("cache-control","no-cache"); //HTTP 1.1

Connection pconn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

int total=0, start=0, end=0;
int pageSize=15;
int pageTotal=0;
int cpage = 0;

String polladm = CommonUtil.nchk((String)session.getAttribute("polladm"));
String pg  = CommonUtil.nchk(request.getParameter("pg"));
pg = pg.equals("")?"0":pg;
cpage = Integer.parseInt(pg);

String querytotal = "select count(*) from polllist";

String query = "select seq, question, sdate, edate, active, vtype, wtime from polllist order by seq desc limit ?, ?";

try {
	pconn = kr.pe.okjsp.util.DbCon.getConnection();

	pstmt = pconn.prepareStatement(querytotal);
	rs = pstmt.executeQuery();

	if(rs.next())
		total = rs.getInt(1);
	rs.close();
	pstmt.close();

	pageTotal = (total-1)/pageSize;
	if (cpage<0) cpage=0;
	if (cpage>pageTotal) cpage=pageTotal;

	start = cpage * pageSize;
	end = start + pageSize;
%>
<jsp:include page="header.jsp" flush="true"/>
<!---------------- 게시판 안쪽 테두리 테이블 --------------------->
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tb_w">
<tr><td>
<br>
<jsp:include page="/poll/poll_form.jsp" flush="true"/>

<!---------------- 총 글수 테이블 --------------------->
<table border="0" width="90%" align="center" cellpadding="4" cellspacing="0" class="tb_w">
	<tr>
		<td>
		<a href="admin.jsp?pg=<%=pg%>">
		<% if (!polladm.equals("ok")) { %><font class="en2">Admin<% } else {%><font class="en1">Logout<%}%></font>
		</a>
		</td>
		<td align="right" class="tb_w">
		총 <%=total %> 개의 폴 ( 현재 <%= cpage+1%>  / 전체 <%=pageTotal+1%> )
		</td>
	</tr>
</table>
<!---------------- 총 글수 테이블 --------------------->

<!---------------- 게시판 메인 테두리 테이블 --------------------->
<table border="0" width="90%" align="center" cellpadding="0" cellspacing="0" class="tb_b">
	<tr>
		<td>

<!---------------- 게시판 메인 테이블 --------------------->
		<table border="0" width="100%" align="center" cellpadding="4" cellspacing="1">
<tr>
<td width="10%" align="center" class="td_c">번호</td>
<td align="center" class="td_c">제목</td>
<td width="10%" align="center" class="td_c">종료</td>
<%if (polladm.equals("ok")){%>
<td width="5%" align="center" class="td_c">삭제</td>
<%}%>
</tr>
<%
	// 날짜 표기 형식
	Date today = new Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yy/MM/dd");
	SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss");

	// 목록 DB에서 가져오기
	pstmt = pconn.prepareStatement(query);
	pstmt.setInt(1,start);
	pstmt.setInt(2,end);

	rs = pstmt.executeQuery();

	Timestamp t=null;
	String question="", seq="";
	int cnt = total - cpage*pageSize;
	int lev = 0;

	while (rs.next()) {
		t = rs.getTimestamp("edate");
		seq = CommonUtil.nchk(rs.getString("seq"));
		question = CommonUtil.k2a(rs.getString("question"));
		question = CommonUtil.cropByte(question, 40, "...");
		question = CommonUtil.rplc(question, "<", "&lt;");
%>
<tr>
<td align="center" class="td_w">
<%=seq%>
</td>
<td align="left" class="td_w">
<a href="poll_list.jsp?pg=<%=cpage%>&seq=<%=seq%>"><%=question%></a>
</td>
<td align="center" class="td_w">
<%=(formatter.format(today).equals(formatter.format(t)))?formatter2.format(t):formatter.format(t)%>
</td>
<%if (polladm.equals("ok")){%>
<td align="center" class="td_w">
<form name="f1" method="post" action="poll_delete.jsp?pg=<%=cpage%>&seq=<%=seq%>" onSubmit="return confirm('폴을 삭제하시겠습니까?');">
<input type="submit" value="삭제" class="ipt2">
</form>
</td>
<%}%>
</tr>
<%
	}  // end of while

	pstmt.close();

	// page list
	int psize = 10;
	int pageGroupStart = (int)(cpage/psize) * psize;
	int pageGroupEnd = pageGroupStart + psize;
	if (pageGroupEnd>pageTotal) pageGroupEnd = pageTotal + 1;
%>
</table>
<!---------------- 게시판 메인 테이블 --------------------->

<!---------------- 게시판 페이지 테이블 --------------------->
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tb_w">
<tr>
<td align="right">
<%=(System.currentTimeMillis()-sTime)/1000.0 %> secs
</td>
</tr>
<tr>
<td align="center"><br>
&nbsp;|&nbsp;<a href="/">홈</a>
<%if(polladm.equals("ok")){%>|&nbsp;<a href="poll_insert.jsp">작성하기</a>
<%}%>
|&nbsp;<a href="poll_list.jsp?pg=0">맨처음</a>
<% if (cpage-psize>=0){%><a href="poll_list.jsp?pg=<%=pageGroupStart-1%>">[이전 10개]</a>
<%}

for(int i=pageGroupStart; i<pageGroupEnd ;i++){
	if (i==cpage) {%> <b>[<%=i+1%>]</b> <%} else {
%> <a href="poll_list.jsp?pg=<%=i%>"><%=i+1%></a> <%} // end if
} // end for
%>
<% if (pageGroupStart+psize<pageTotal+1){%><a href="poll_list.jsp?pg=<%=pageGroupStart+psize%>">[다음 10개]</a><%}%>
<a href="poll_list.jsp?pg=<%=pageTotal%>">마지막</a>
<br><br>
</td></tr>
</table>
<!---------------- 게시판 페이지 테이블 --------------------->
<%
	} catch(Exception e){
		out.println(e.getMessage());
	} finally {
		if (pstmt!=null) pstmt.close();
		if (pconn!=null) pconn.close();
	}
%>
</td></tr></table>
<!---------------- 게시판 메인 테두리 테이블 --------------------->

</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
</table>
<!---------------- 게시판 안쪽 테두리 테이블 --------------------->
<jsp:include page="bottom.jsp" flush="true"/>
<jsp:include page="tail.jsp" flush="true"/>
