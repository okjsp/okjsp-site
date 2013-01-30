<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/xml" prefix="x" %>
<% 
	response.setContentType("text/html;"); 
%>
<%-- recommend.xml ������ �ҷ��� xdata ������ �Ҵ� --%>
<c:import url="/WEB-INF/xml/recommend.xml" var="xmldata" />
<x:parse xml="${xmldata}" var="xdata"/>
<%-- book ������ ���� ��� --%>
<x:forEach select="$xdata//recommend/book[4]" >
    <a href="<x:out select="link"/>">
	    <x:out select="title"/>
	    <div align="center">
		    <img src=<x:out select="image"/> border="0" height="196">
	    </div>
	    <div style="font-size:11px">
		    <x:out select="description"/>
	    </div>
    </a>
    <br>
</x:forEach>
