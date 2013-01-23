<% response.setContentType("text/html"); %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ page import="kr.pe.okjsp.util.CommonUtil,kr.pe.okjsp.Article"  %>
<jsp:useBean id="one"  class="kr.pe.okjsp.Article" scope="request"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler" />
<html>
<head>
    <META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
    <link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
    <title>OKJSP: <c:out value="${one.subject}"/></title>
    <script src='/js/ban.js'></script>
    <script src="/js/okjsp.js"></script>
    <script src="/js/okboard_view.js"></script>
    <script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
 onload="javascript:print()">
<table width="882" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign='top'>
    <img src="/images/okjsp_top.gif" width=119 height=48 border=0>
    </td>
  </tr>
  <tr>
    <td valign='top'>

<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3">
        <b><c:out value="${bbsInfoMap[param.bbs].name}" /></b>
    </td>
  </tr>
</table>
<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
    <tr>
        <td class="td">
            <table style="width:100%;font:10pt 굴림체" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
<c:out value="${one.writer}"/>
                    </td>
                    <td>
<c:out value="${one.when}" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="td">
<c:out value="${one.email}" escapeXml="false" />
<a href="<c:out value="${one.homepage}"/>" target="_blank"><c:out value="${one.homepage}"/></a>
        </td>
    </tr>
    <tr>
        <td class="td" class="wrap">
        <b><okbbs:mark word='<%=  request.getParameter("keyword")  %>'>
        <c:out value="${one.subject}"/>
        </okbbs:mark></b>
        </td>
    </tr>
    <tr>
        <td class="td" class="wrap" height="80" valign="top">
<%-- 이미지 보이기 --%>
<c:forEach items="${arrdf}" var="df">
  <c:if test="${df.imageFile}">
<img src="/upload/<c:out value="${df.maskName}"/>">
  </c:if>
</c:forEach>
        <div id="centent" class="wrap">
        <okbbs:mark word='<%=  request.getParameter("keyword")  %>'>
        <%=  one.getContentView()  %>
        </okbbs:mark></div>
        </td>
    </tr>
<%-- 다운로드 파일 목록 --%>
    <tr>
        <td class="td">
<c:forEach items="${arrdf}" var="df">
<img src="/images/edit/MenuIcon/IconSave.gif" valign="absmiddle">
<a href="/bbs?act=DOWN<c:out value='&maskname=${df.maskName}&fileName=${df.fileName}'/>" target="_top">
    <c:out value="${df.fileName} ${df.fileSize} Bytes (${df.download})"/>
</a><br>
</c:forEach>
        </td>
    </tr>
</table>

<table class="tablestyle" border="0" cellpadding="3" cellspacing="0">
<c:forEach items="${memo}" var="mb">
    <tr>
    <td width="15%" class="td">
        <okbbs:html><c:out value="${mb.writer}" escapeXml="false"/>
        </okbbs:html>
        <br/>
        <sup><c:out value="${mb.ip}" escapeXml="true"/></sup>
    </td>
    <td width="85%" class="td">
        <div class="wrap">
        <okbbs:html br="true"><c:out value="${mb.bcomment}" escapeXml="false"/>
        </okbbs:html>
        <c:out value="${mb.wtime}"/></div>
    </td>
    </tr>
</c:forEach>
</table>
    </td>
  </tr>
</table>
<%@ include file="/footer.jsp" %>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>