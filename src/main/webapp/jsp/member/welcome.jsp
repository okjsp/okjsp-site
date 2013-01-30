<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<c:out value="${member.id}"/>
1<c:out value="${member.id == ''}"/>
2<c:out value="${member.id == null}"/>
3<c:out value="${member.id != ''}"/>
4<c:out value="${member.id != null}"/>
5<c:out value="${member.id == 'kenu'}"/>
6<c:out value="${member.id != 'kenu'}"/>
<c:if test="${member.id != null}">
    <c:out value="${member.id}"/> logged<br>
</c:if>
<jsp:include page="/googleAnalytics.jsp" />
