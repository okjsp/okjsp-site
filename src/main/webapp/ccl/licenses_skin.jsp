<%@page pageEncoding="euc-kr" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%!
//	Map<String, String> ccMap = new HashMap<String, String>();
	Map ccMap = new HashMap();
	{
		ccMap.put("by","������ǥ��");
		ccMap.put("by-sa","������ǥ��-�������Ǻ������");
		ccMap.put("by-nd","������ǥ��-�������");
		ccMap.put("by-nc","������ǥ��-�񿵸�");
		ccMap.put("by-nc-sa","������ǥ��-�񿵸�-�������Ǻ������");
		ccMap.put("by-nc-nd","������ǥ��-�񿵸�-�������");
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
<br />�� ���۹���
<a rel="license" href="<%= ccLink %>" target="cclwin">ũ������Ƽ�� Ŀ���� �ڸ��� <%= cc %> 2.0 ���ѹα� ���̼���</a>��
���� �̿��Ͻ� �� �ֽ��ϴ�.
<%
	}
%>
</div>
