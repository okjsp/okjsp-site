<%@page pageEncoding="euc-kr" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%!
//	Map<String, String> ccMap = new HashMap<String, String>();
	Map ccMap = new HashMap();
	{
		ccMap.put("by","저작자표시");
		ccMap.put("by-sa","저작자표시-동일조건변경허락");
		ccMap.put("by-nd","저작자표시-변경금지");
		ccMap.put("by-nc","저작자표시-비영리");
		ccMap.put("by-nc-sa","저작자표시-비영리-동일조건변경허락");
		ccMap.put("by-nc-nd","저작자표시-비영리-변경금지");
	}
	String[] keys = {"copyright",
			"by",
			"by-sa",
			"by-nd",
			"by-nc",
			"by-nc-sa",
			"by-nc-nd"};
%>
<%
	String idx = CommonUtil.nchk(request.getParameter("c"));
	String key = request.getParameter("cc");
	int i = 0;
	try {
		i = Integer.parseInt(idx);
		if (i>0 && i<=6) {
			key = keys[i];
		}
	}catch(Exception e) {}
	String cc = null;
	try {
		cc = (String)ccMap.get(key);
		if (cc == null) throw new Exception(cc);
	} catch (Exception e) {
		//System.out.println("e:"+e);
		return;
	}
	String ccLink = "http://creativecommons.org/licenses/"+ key +"/2.0/kr/";
%>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<div class="ccl">
<%
	if ( i > 0 && i <= 6) {
%>
<a rel="license" href="<%= ccLink %>" target="cclwin">
<img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/<%= key %>/2.0/kr/88x31.png" /></a>
<br />이 저작물은
<a rel="license" href="<%= ccLink %>" target="cclwin">크리에이티브 커먼즈 코리아 <%= cc %> 2.0 대한민국 라이센스</a>에
따라 이용하실 수 있습니다.
<%
	}
%>
</div>
