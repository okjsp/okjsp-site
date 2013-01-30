<%@ page pageEncoding="MS949"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<c:if test="${empty member.id}">
  <c:redirect url="login.jsp"/>
</c:if>
<html>
<head>
    <META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
    <title>JSTL: OKJSP members</title>
    <LINK rel="STYLESHEET" type="TEXT/CSS" HREF="/css/okjsp2007.css.jsp">
</head>
<body class="body">
<fmt:bundle basename="kr.pe.okjsp.DB">
<c:set var="DRIVER"><fmt:message key="DRIVER"/></c:set>
<c:set var="DBURL"><fmt:message key="DBURL"/></c:set>
<c:set var="DBUSER"><fmt:message key="DBUSER"/></c:set>
<c:set var="DBPASS"><fmt:message key="DBPASS"/></c:set>
</fmt:bundle>
<sql:setDataSource
  var="okds"
  driver="${DRIVER}"
  url="${DBURL}"
  user="${DBUSER}"
  password="${DBPASS}"
/>

<sql:transaction dataSource="${okds}">

  <sql:query var="okmember">
    SELECT id, name, joindate, homepage
    FROM okmember
    order by joindate desc
  </sql:query>

</sql:transaction>

<hr>


<h2>okjsp members</h2>

<%-- Easiest example showing how to populate a table --%>
<table class="tablestyle">
  <tr>
  <%-- Get the column names for the header of the table --%>
    <th>no</th>
  <c:forEach var="columnName" items="${okmember.columnNames}">
    <th><c:out value="${columnName}"/></th>
  </c:forEach>

  <%-- Get the value of each column while iterating over rows --%>
  <c:forEach var="row" items="${okmember.rowsByIndex}" varStatus="i">
    <tr>
      <td><c:out value="${i.index+1}"/></td>
      <c:forEach var="column" items="${row}" varStatus="j">
          <c:choose>
            <c:when test="${j.index==2}">
        <td><fmt:formatDate value="${column}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
            </c:when>
            <c:otherwise>
        <td><c:out value="${column}"/></td>
            </c:otherwise>
          </c:choose>
      </c:forEach>
  </c:forEach>
</table>


</body>
</html>
