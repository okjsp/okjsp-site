<%---------------------------------------------------------------------------------------------------------    
  FileName    : recentDetail.jsp
  Author      : BLUEPOET
  Regdate     : 2010-03-19
  Lastdate 	  : 
  Description : OKJSP �ֽű� ��������  
  ver         : 1.0
-----------------------------------------------------------------------------------------------------------%>
<%@ page import="java.util.*, kr.pe.okjsp.*, kr.pe.okjsp.util.*, kr.pe.okjsp.Article" contentType='text/html;charset=euc-kr'%>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />

<!-- ȭ�� ��ħ ���� ���� id="stats3" �߰�  -->
<ul id="stats3"  title="�ֽű� ����" >
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
	        	<!-- ��ȣ Ŭ���ϸ� �������°� ����:a�� div�� ���� -->
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

