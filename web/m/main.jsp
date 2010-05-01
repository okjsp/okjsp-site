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
    
    listMap.put(0,"techtrend");
    listMap.put(1,"lecture");
    listMap.put(2,"TOOL");
    listMap.put(3,"TOOLqna");
    listMap.put(4,"ajax");
    listMap.put(5,"ajaxqna");
    listMap.put(6,"bbs2");
    listMap.put(7,"bbs1");
    listMap.put(8,"bbs4");
    listMap.put(9,"bbs3");
    listMap.put(10,"weblogic");
    listMap.put(11,"weblgqna");
    listMap.put(12,"xmltip");
    listMap.put(13,"xmlqna");
    listMap.put(14,"ruby");
    listMap.put(15,"rubyqna");
    listMap.put(16,"flex");
    listMap.put(17,"flexqna");
    listMap.put(18,"bbs7");
    listMap.put(19,"docs");
    listMap.put(20,"etc");
    listMap.put(21,"bbs6");
    listMap.put(22,"japanlife");
    listMap.put(23,"bbs5");
    listMap.put(24,"movie");
    listMap.put(25,"howmuch");
    listMap.put(26,"lifeqna");
    listMap.put(27,"news");
    listMap.put(28,"solo");
    listMap.put(29,"recruit");
    listMap.put(30,"engdocs");
    listMap.put(31,"krtomcat");
    listMap.put(32,"link");
    listMap.put(33,"goodjob");
    listMap.put(34,"market");
    listMap.put(35,"model2jsp");
    listMap.put(36,"notice");
    listMap.put(37,"okboard");
    listMap.put(38,"useful");
    listMap.put(39,"mac");
    listMap.put(40,"ihaveadream");
    listMap.put(41,"javastudy");
    listMap.put(42,"ns");
    listMap.put(43,"dbstudy");
    listMap.put(44,"springstudy");
    listMap.put(45,"xf");
    listMap.put(46,"trash");    
    listMap.put(47,"twitter");
    
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
			<img src="/m/iui/icon_bbs.png" style="	float: left; height: 35px; width: 46px;	margin: -8px 0 -7px -10px" />          
          	<a href="/bbs?act=MLIST&bbs=<%=bbsInfo.getBbs()%>" target="_iui"><%=bbsInfo.getName()%></a>
		</li>
<%
	}
%>			
  </ul>