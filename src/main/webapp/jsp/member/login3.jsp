<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=euc-kr"
    import="kr.pe.okjsp.util.CommonUtil"
%><c:out value="${member.id}"/> �� �ݰ����ϴ�.<br>
<%
    CommonUtil.getCookie(request, "okid");
%>