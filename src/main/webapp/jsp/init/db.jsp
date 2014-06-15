<%@ page import="java.sql.*" %>

<%
String DB_URL = "jdbc:mysql://localhost/test";
String DB_USER = "";
String DB_PASSWORD= "";

Connection conn;
Statement stmt;
ResultSet rs;

String query = "select 1";

// try {
Class.forName("org.gjt.mm.mysql.Driver");

conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

stmt = conn.createStatement();

rs = stmt.executeQuery(query);

if (rs.next()) {
	out.println(rs.getInt(1));
}

out.println("get one!!");

rs.close();

stmt.close();

conn.close();

// } catch(Exception e){out.println(e.getMessage());}
%>
