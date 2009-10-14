<%@ page import="java.sql.*" contentType="text/html; charset=euc-kr" errorPage="error.jsp"%>
<%@ include file="pollcfg.jsp" %>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); 
response.setHeader ("Cache-Control", "no-cache");  

Connection pconn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String sql0 = " CREATE TABLE "+tableName+" ( ";
sql0 += " seq                        NUMBER NOT NULL, ";
sql0 += " question                   VARCHAR2(1000) NOT NULL, ";
sql0 += " sdate                      DATE, ";
sql0 += " edate                      DATE, ";
sql0 += " active                     CHAR(1) DEFAULT 1, ";
sql0 += " vtype                      NUMBER DEFAULT 1 NOT NULL, ";
sql0 += " wtime                      DATE) ";

String sql1 = " CREATE TABLE "+itemTableName+" ( ";
sql1 += " seq                        NUMBER NOT NULL, ";
sql1 += " itemseq                    NUMBER, ";
sql1 += " item                       VARCHAR2(200), ";
sql1 += " hit                        NUMBER DEFAULT 0) ";

// 시간순 index 생성
String  query_idx = "CREATE INDEX IDX_"+tableName+" on "+tableName+" (seq)";

try {
pconn = kr.pe.okjsp.util.DbCon.getConnection();

pstmt = pconn.prepareStatement(sql0);
pstmt.executeUpdate();

pstmt.close();

pstmt = pconn.prepareStatement(sql1);
pstmt.executeUpdate();

pstmt.close();

pstmt = pconn.prepareStatement(query_idx);
pstmt.executeQuery();

pstmt.close();

pconn.close();
%>
<br><br><br>
<center>
POLL 게시판이 생성되었습니다.<br><br>
polllist table : <%=tableName%><br>
pollitem table : <%=itemTableName%><br><br>
<a href="poll_list.jsp">polllist</a><br>
</center>
<%} catch(Exception e){
out.println(e.getMessage());
} finally {
if (pstmt!=null) pstmt.close();
if (pconn!=null) pconn.close();
}%>
