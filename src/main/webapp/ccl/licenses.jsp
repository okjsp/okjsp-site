<%@page contentType="text/html;charset=utf-8"%>
<%
	String[] ccDesc = {
		"by,저작자표시",
		"by-sa,저작자표시-동일조건변경허락",
		"by-nd,저작자표시-변경금지",
		"by-nc,저작자표시-비영리",
		"by-nc-sa,저작자표시-비영리-동일조건변경허락",
		"by-nc-nd,저작자표시-비영리-변경금지"
		};
%>
<form name="form1">
<select name="cc" onchange="document.form1.submit()">
<%
	for (int i = 0; i < ccDesc.length; i++) {
		String[] cc = ccDesc[i].split(",");
%><option value="<%= cc[0] %>"><%= cc[1] %></option>
<%
	} // end for
%>
</select>
</form>
<script type="text/javascript">
	document.form1.cc.value = "<%= request.getParameter("cc") %>";
</script>
<%	
	if (request.getParameter("cc") != null) {
%><jsp:include flush="true" page="licenses_skin.jsp"></jsp:include>
<%
	} // end for
%>
