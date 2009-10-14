<%@ page pageEncoding="euc-kr" %>
<div id="footer" class="tablestyle">
java/jsp/eclipse
<a href="/" style="font-size:11px">http://www.okjsp.pe.kr</a>
<%
	String bannerPath = "/images/banner/oss182x80.gif";
	String bannerTitle = "오픈소스소프트웨어 경진대회 공식 홈페이지";
	String bannerLink = "/f.jsp?http://oss.or.kr/ossproject/";
%>
<div style="text-align:center">
 <a href="<%= bannerLink %>"
 title="<%= bannerTitle %>" target="_blank">
 <img src="<%= bannerPath %>" border="0"></a>
</div>
<div>
<ul>
<li><a href="/jsp/member/agreement.jsp" target="privacy">개인정보취급방침</a>
</li>
<li>hosted by <a href="http://www.80port.com/">80port.com</a><br />
 <a href="http://www.80port.com/community"
 title="www.80port.com
 okjsp 서버 호스팅 지원, 서비스 좋습니다.">
 <img src="/images/bnr_80port.gif" border="0"></a>
</li>
</ul>
</div>
</div>
<script type="text/javascript" src="http://log.inside.daum.net/dwi_log/js/dwi.js"></script>
<script type="text/javascript" >
	_dwiPID="d-9jj-269";
	if(typeof(_dwiCatch) == "function") { _dwiCatch();}
</script>
