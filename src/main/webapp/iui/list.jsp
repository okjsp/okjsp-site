<%@ page pageEncoding="euc-kr"
    import="kr.pe.okjsp.util.CommonUtil, java.util.Iterator,
            kr.pe.okjsp.Article,kr.pe.okjsp.util.DateLabel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:setProperty name="list" property="*" />
<ul id="stats2"  title="<c:out value="${bbsInfoMap[list.bbs].name}" escapeXml="false" />">
<jsp:include page="listDetail.jsp"></jsp:include>
</ul>