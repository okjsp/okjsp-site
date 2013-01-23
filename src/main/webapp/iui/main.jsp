<%---------------------------------------------------------------------------------------------------------    
  FileName    : main.jsp
  Author      : BLUEPOET
  Regdate     : 2010-03-19
  Lastdate 	  : 
  Description : 전체게시판 보기 페이지  
  ver         : 1.0
-----------------------------------------------------------------------------------------------------------%>
<%@ page pageEncoding="euc-kr" import="java.util.*,kr.pe.okjsp.BbsInfoBean" %>
<%!
public HashMap<Integer,String> getListMap()
{
    HashMap<Integer,String> listMap = new HashMap<Integer,String>();
 
    int i = 0;
    listMap.put(i++,"html5");
    listMap.put(i++,"techtrend");
    listMap.put(i++,"lecture");
    listMap.put(i++,"TOOL");
    listMap.put(i++,"TOOLqna");
    listMap.put(i++,"ajax");
    listMap.put(i++,"ajaxqna");
    listMap.put(i++,"bbs2");
    listMap.put(i++,"bbs1");
    listMap.put(i++,"bbs4");
    listMap.put(i++,"bbs3");
    listMap.put(i++,"weblogic");
    listMap.put(i++,"weblgqna");
    listMap.put(i++,"xmltip");
    listMap.put(i++,"xmlqna");
    listMap.put(i++,"ruby");
    listMap.put(i++,"rubyqna");
    listMap.put(i++,"flex");
    listMap.put(i++,"flexqna");
    listMap.put(i++,"bbs7");
    listMap.put(i++,"docs");
    listMap.put(i++,"etc");
    listMap.put(i++,"bbs6");
    listMap.put(i++,"japanlife");
    listMap.put(i++,"bbs5");
    listMap.put(i++,"movie");
    listMap.put(i++,"howmuch");
    listMap.put(i++,"lifeqna");
    listMap.put(i++,"news");
    listMap.put(i++,"solo");
    listMap.put(i++,"recruit");
    listMap.put(i++,"engdocs");
    listMap.put(i++,"krtomcat");
    listMap.put(i++,"link");
    listMap.put(i++,"goodjob");
    listMap.put(i++,"market");
    listMap.put(i++,"model2jsp");
    listMap.put(i++,"notice");
    listMap.put(i++,"okboard");
    listMap.put(i++,"useful");
    listMap.put(i++,"mac");
    listMap.put(i++,"ihaveadream");
    listMap.put(i++,"javastudy");
    listMap.put(i++,"ns");
    listMap.put(i++,"dbstudy");
    listMap.put(i++,"springstudy");
    listMap.put(i++,"xf");
    listMap.put(i++,"trash");    
    listMap.put(i++,"twitter");
    
    return listMap;
}
%>

<!-- 화면 겹침 방지 위해 id="stats" 추가  -->
<ul id="stats" title="전체게시판">
<%
	HashMap map = (HashMap)application.getAttribute("bbsInfoMap");
	int listSize = getListMap().size();
	
	for(int i=0; i<listSize; i++)
	{
	    BbsInfoBean bbsInfo = (BbsInfoBean)map.get(getListMap().get(i));			    
%>
		<li>
      	  <%-- 
          <div class="digg-count"><%=(i+1)%></div>
          --%>
			<img src="/iui/iui/icon_bbs.png" style="	float: left; height: 35px; width: 46px;	margin: -8px 0 -7px -10px" />          
          	<a href="/bbs?act=IUILIST&bbs=<%=bbsInfo.getBbs()%>" target="_iui"><%=bbsInfo.getName()%></a>
		</li>
<%
	}
%>			
  </ul>