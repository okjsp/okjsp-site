<%@page pageEncoding="MS949" %>
<%
	
	String bbs = request.getParameter("bbs");	// mobile에서는 Script로 Selected 해주기 어렵다. bbs 변수로  Selected 처리한다.
%>
<option value="techtrend"		<%=   "techtrend".equals(bbs)?"SELECTED":"" %>	>TECH TREND</option>
<option value="lecture"			<%=     "lecture".equals(bbs)?"SELECTED":"" %>	>강좌</option>
<option value="TOOL"			<%=        "TOOL".equals(bbs)?"SELECTED":"" %>	>개발툴</option>
<option value="TOOLqna"			<%=     "TOOLqna".equals(bbs)?"SELECTED":"" %>	>개발툴 QnA</option>
<option value="ajax"			<%=        "ajax".equals(bbs)?"SELECTED":"" %>	>Ajax</option>
<option value="ajaxqna"			<%=     "ajaxqna".equals(bbs)?"SELECTED":"" %>	>Ajax QnA</option>
<option value="bbs2"			<%=        "bbs2".equals(bbs)?"SELECTED":"" %>	>DB Tips</option>
<option value="bbs1"			<%=        "bbs1".equals(bbs)?"SELECTED":"" %>	>DB QnA</option>
<option value="bbs4"			<%=        "bbs4".equals(bbs)?"SELECTED":"" %>	>JSP Tips</option>
<option value="bbs3"			<%=        "bbs3".equals(bbs)?"SELECTED":"" %>	>JSP QnA</option>
<option value="weblogic"		<%=    "weblogic".equals(bbs)?"SELECTED":"" %>	>j2ee Tips</option>
<option value="weblgqna"		<%=    "weblgqna".equals(bbs)?"SELECTED":"" %>	>j2ee QnA</option>
<option value="xmltip"			<%=      "xmltip".equals(bbs)?"SELECTED":"" %>	>XML Tips</option>
<option value="xmlqna"			<%=      "xmlqna".equals(bbs)?"SELECTED":"" %>	>XML QnA</option>
<option value="ruby"			<%=        "ruby".equals(bbs)?"SELECTED":"" %>	>Ruby on Rails</option>
<option value="rubyqna"			<%=     "rubyqna".equals(bbs)?"SELECTED":"" %>	>Ruby on Rails QnA</option>
<option value="flex"			<%=        "flex".equals(bbs)?"SELECTED":"" %>	>Flex</option>
<option value="flexqna"			<%=     "flexqna".equals(bbs)?"SELECTED":"" %>	>Flex QnA</option>
<option value="bbs7"			<%=        "bbs7".equals(bbs)?"SELECTED":"" %>	>소스자료실</option>
<option value="docs"			<%=        "docs".equals(bbs)?"SELECTED":"" %>	>문서자료실</option>
<option value="etc"				<%=         "etc".equals(bbs)?"SELECTED":"" %>	>기타자료실</option>
<option value="bbs6"			<%=        "bbs6".equals(bbs)?"SELECTED":"" %>	>사는 얘기</option>
<option value="japanlife"		<%=   "japanlife".equals(bbs)?"SELECTED":"" %>	>일본사는얘기</option>
<option value="bbs5"			<%=        "bbs5".equals(bbs)?"SELECTED":"" %>	>머리식히는 곳</option>
<option value="movie"			<%=       "movie".equals(bbs)?"SELECTED":"" %>	>movie story</option>
<option value="howmuch"			<%=     "howmuch".equals(bbs)?"SELECTED":"" %>	>얼마면돼</option>
<option value="lifeqna"			<%=     "lifeqna".equals(bbs)?"SELECTED":"" %>	>의견좀...</option>
<option value="news"			<%=        "news".equals(bbs)?"SELECTED":"" %>	>뉴스따라잡기</option>
<option value="solo"			<%=        "solo".equals(bbs)?"SELECTED":"" %>	>싱글의 미학</option>
<option value="recruit"			<%=     "recruit".equals(bbs)?"SELECTED":"" %>	>구인/구직/홍보</option>
<option value="engdocs"			<%=     "engdocs".equals(bbs)?"SELECTED":"" %>	>english bbs</option>
<option value="krtomcat"		<%=    "krtomcat".equals(bbs)?"SELECTED":"" %>	>번역</option>
<option value="link"			<%=        "link".equals(bbs)?"SELECTED":"" %>	>추천사이트</option>
<option value="goodjob"			<%=     "goodjob".equals(bbs)?"SELECTED":"" %>	>좋은회사</option>
<option value="market"			<%=      "market".equals(bbs)?"SELECTED":"" %>	>장터</option>
<option value="model2jsp"		<%=   "model2jsp".equals(bbs)?"SELECTED":"" %>	>모델2JSP책관련</option>
<option value="notice"			<%=      "notice".equals(bbs)?"SELECTED":"" %>	>공지사항</option>
<option value="okboard"			<%=     "okboard".equals(bbs)?"SELECTED":"" %>	>자료실문답</option>
<option value="useful"			<%=      "useful".equals(bbs)?"SELECTED":"" %>	>유용한 정보</option>
<option value="mac"				<%=         "mac".equals(bbs)?"SELECTED":"" %>	>맥 정보</option>
<option value="ihaveadream"		<%= "ihaveadream".equals(bbs)?"SELECTED":"" %>	>정부는 개발자를 위해</option>
<option value="javastudy"		<%=   "javastudy".equals(bbs)?"SELECTED":"" %>	>프로그램기초스터디</option>
<option value="ns"				<%=          "ns".equals(bbs)?"SELECTED":"" %>	>자바패턴1기</option>
<option value="dbstudy"			<%=     "dbstudy".equals(bbs)?"SELECTED":"" %>	>DB스터디</option>
<option value="springstudy"		<%= "springstudy".equals(bbs)?"SELECTED":"" %>	>스프링 스터디</option>
<option value="xf"				<%=          "xf".equals(bbs)?"SELECTED":"" %>	>SLF</option>
<option value="twitter"			<%=     "twitter".equals(bbs)?"SELECTED":"" %>	>트위터</option>
<option value="trash"			<%=       "trash".equals(bbs)?"SELECTED":"" %>	>짬통</option>
