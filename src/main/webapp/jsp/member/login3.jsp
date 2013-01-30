<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=euc-kr"
    import="kr.pe.okjsp.util.CommonUtil"
%><c:out value="${member.id}"/> ´Ô ¹Ý°©½À´Ï´Ù.<br>
<%
    CommonUtil.getCookie(request, "okid");
%>