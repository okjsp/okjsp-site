<%@ page pageEncoding="euc-kr"
    import="kr.pe.okjsp.util.CommonUtil, java.util.Iterator,
            kr.pe.okjsp.Article,kr.pe.okjsp.util.DateLabel" %>
<%@ taglib uri="/WEB-INF/tld/taglibs-string.tld" prefix="str" %>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />

<div data-role="page">

	<div data-role="header" data-theme="b" >
		<h1>Board Lists</h1>
		<a href="/jqm/index.jsp" data-icon="home" data-iconpos="notext" data-direction="reverse" class="ui-btn-right" title="Home" data-theme="b">Home</a>
	</div><!-- /header -->

	<div data-role="content" role="main">
		<ul data-role="listview" data-theme="c" id="listview_<%=request.getParameter("bbs")%>">
			<jsp:include page="/jqm/listDetail.jsp"/>
		</ul>
	</div>
</div>	 