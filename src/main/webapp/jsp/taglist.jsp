<%@ page pageEncoding="euc-kr"
import="kr.pe.okjsp.*,
kr.pe.okjsp.util.*,java.util.*" %><%
  int tagseq = Integer.parseInt(request.getParameter("tagseq"));
  TagHandler tagHandler = new TagHandler();
  Tag tag = tagHandler.getTag(tagseq);
  ArrayList list = tagHandler.getArticlesByTagseq(tagseq);

  HashMap bbsInfoMap = (HashMap)getServletContext().getAttribute("bbsInfoMap");
%>
<html>
<head>
<link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
<META HTTP-EQUIV="Content-type" CONTENT="text/html;charset=ksc5601">
<script src="/js/okjsp.js"></script>
<script type="text/javascript" src="/js/banner.js" charset="utf-8"></script>
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div id="bodySect" style="position:absolute;top:120px;left:120px">
  <div id="taglist" style="background-color:#fff; border: 1 solid #666;" class="tablestyle">
  <div><strong>Tag: <%= CommonUtil.k2a(tag.getTag()) %> (<%= tag.getCnt() %>)</strong></div>
<%
  if (list.size() > 0) {
	  String bbsName = null;
	  for(int i = 0; i < list.size(); i++) {
		  Article one = (Article)list.get(i);
		  BbsInfoBean info = (BbsInfoBean)bbsInfoMap.get(one.getBbs());
		  if (info !=null) {
			  bbsName = info.getName();
		  } else {
			  bbsName = "";
		  }

%><div class="row"><div class="bbs"><%= bbsName %></div> 
<a href="/bbs?seq=<%= one.getSeq() %>"><%= CommonUtil.k2a(one.getSubject()).replaceAll("<","&lt;") %>
(<%= CommonUtil.k2a(one.getWriter()) %>) <%= one.getWhen("yyyy-MM-dd HH:mm:ss") %></a></div><%
	  }
  }
%>
  </div>
  <div style="text-align:right;width:600px"><a href="javascript:history.back()">back</a></div>
<jsp:include page="/jsp/tagCloud.jsp"/>
</div>
<div id="topSect" style="float:top">
<jsp:include page="/top.jsp" />
</div>
<div id="leftMenu" style="float:left">
<jsp:include page="/menu.jsp" />
</div>

<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>
