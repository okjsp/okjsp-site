<%---------------------------------------------------------------------------------------------------------    
  FileName    : recentDetail.jsp
  Author      : BLUEPOET
  Regdate     : 2010-03-19
  Lastdate 	  : 
  Description : OKJSP 최신글 상세페이지  
  ver         : 1.0
-----------------------------------------------------------------------------------------------------------%>
<%@ page import="java.util.*, kr.pe.okjsp.*, kr.pe.okjsp.util.*, kr.pe.okjsp.Article" contentType='text/html;charset=euc-kr'%>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />

<!-- 화면 겹침 방지 위해 id="stats3" 추가  -->
<ul id="stats3"  title="최신글 보기" >
<%
	Iterator iter = list.getAllRecentList(48).iterator();
	HashMap bbsInfoMap = (HashMap)application.getAttribute("bbsInfoMap");
	Article one = null;
	int i = 0;
	
	while (iter.hasNext() && i < 40) 
	{
	    one = (Article) iter.next();
	    BbsInfoBean bbsInfo = ((BbsInfoBean)(bbsInfoMap.get(one.getBbs())));
	    if (bbsInfo == null) {
	    	bbsInfo = new BbsInfoBean();
	    }
	    
	    if (bbsInfo.getCseq() == null || "".equals(bbsInfo.getCseq()) || "twitter".equals(bbsInfo.getBbs())) {
    		continue;
    	}
    	
	    if ("2".equals(bbsInfo.getCseq())) {
	    	continue;
	    }
	    
	%>
	        <li><!-- ############ IUI List ########### -->
	        	<!-- 번호 클릭하면 에러나는거 수정:a를 div로 변경 -->
	        	<%--
	            <div class="digg-count"><%=(i+1)%></div>
	             --%>
				<img src="/iui/iui/icon_list.png" style="	float: left; height: 35px; width: 46px;	margin: -8px 0 -7px -10px" />	             
	            <a href="/bbs?seq=<%= one.getSeq() %>&viewMode=IUI" target="_iui"><%= one.getSubject() %></a>
	        </li>
	<%
		i++;
	} // end ifwhile 
	%>
</ul>

