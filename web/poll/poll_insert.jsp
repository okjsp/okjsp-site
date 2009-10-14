<%@ page contentType="text/html;charset=euc-kr"
	import="kr.pe.okjsp.util.*, java.util.Date" errorPage="error.jsp"
%><%
	String pg = CommonUtil.nchk(request.getParameter("pg"));
	String polladm = CommonUtil.nchk((String)session.getAttribute("polladm"));

	if (polladm.equals("ok")) {
%><script src="js/poll.js"></script>
<jsp:include page="header.jsp" flush="true"/>
<form name="f1" method="post" action="poll_insert2.jsp">
			<input type="hidden" name="pg" value="<%= pg %>">
<table border="0" width="100%" align="center" cellpadding="0" cellspacing="0" class="tb_w">
	<tr>
		<td>
<br><br>

<table border="0" width="80%" align="center" cellpadding="0" cellspacing="0" class="tb_b">
	<tr>
		<td>

<table border="0" width="100%" align="center" cellpadding="4" cellspacing="1">
    <tr>
      <td width="69" align="right" class="td_c">질문</td>
      <td width="531" class="td_w">
        <input type="text" name="question" size="80" class="ipt1">
      </td>
    </tr>
    <tr>
      <td align="right" class="td_c">항목</td>
      <td class="td_w">
        <table border="0" width="100%" align="center" cellpadding="0" cellspacing="0">
<% for (int i=0;i<10;i++) { %>          <tr>
            <td>
              <input type="text" name="item" size="30" class="ipt1">
            </td>
            <td align="left" width="5%">&nbsp;<%=i*2+1%></td>
            <td align="right" width="5%"><%=i*2+2%>&nbsp;</td>
            <td>
              <input type="text" name="item" size="30" class="ipt1">
            </td>
          </tr>
<% }
%>        </table>
      </td>
    </tr>
    <tr>
      <td align="right" width="69" class="td_c">시작일</td>
      <td width="531" class="td_w">
<select name="s_year" class="slt">
<%
	Date today = new Date();
	int itmp = today.getYear()+1900;
	for (int i=itmp;i<itmp+20;i++) { %><option><%=i%></option>
<% } %></select>년<select name="s_month" class="slt">
<% itmp = today.getMonth()+1;
	for (int i=1;i<=12;i++) { %><option value="<%if(i<10) out.print(0);%><%=i%>"><%=i%></option>
<% } %></select>월<script>
opt(f1.s_month,"<%if(itmp<10) out.print(0);%><%=itmp%>");
</script><select name="s_day" class="slt">
<% itmp = today.getDate();
for (int i=1;i<=31;i++) { %><option value="<%if(i<10) out.print(0);%><%=i%>"><%=i%></option>
<% } %></select>일<script>
opt(f1.s_day,"<%if(itmp<10) out.print(0);%><%=itmp%>");
</script>
	</td>
    </tr>
    <tr>
      <td align="right" width="69" class="td_c">종료일</td>
      <td width="531" class="td_w">
<select name="e_year" class="slt">
<%
today = new Date(today.getTime()+1000*60*60*24*15); // +15일
itmp = today.getYear()+1900;
for (int i=itmp;i<itmp+20;i++) { %><option><%=i%></option>
<% } %></select>년<select name="e_month" class="slt">
<% itmp = today.getMonth()+1;
for (int i=1;i<=12;i++) { %><option value="<%if(i<10) out.print(0);%><%=i%>"><%=i%></option>
<% } %></select>월<script>
opt(f1.e_month,"<%if(itmp<10) out.print(0);%><%=itmp%>");
</script><select name="e_day" class="slt">
<% itmp = today.getDate();
for (int i=1;i<=31;i++) { %><option value="<%if(i<10) out.print(0);%><%=i%>"><%=i%></option>
<% } %></select>일<script>
opt(f1.e_day,"<%if(itmp<10) out.print(0);%><%=itmp%>");
</script>
	</td>
    </tr>
    <tr>
      <td align="right" width="69" class="td_c">다중답변</td>
      <td width="531" class="td_w">
        <input type="radio" name="vtype" checked value="1" class="chk">
        No
        <input type="radio" name="vtype" value="99" class="chk">
        Yes </td>
    </tr>
    <tr>
      <td align="center" colspan="2" class="td_w">
        <input type="submit" name="Submit" value="확인" class="ipt2">
        <input type="button" name="back" value="취소" onClick="history.back()" class="ipt2">
      </td>
    </tr>
  </table>

</td></tr></table>

<br><br>
</td></tr></table>
</form>
<%}else{%>
<script>
top.document.location="/";
</script>
<%}%>
<jsp:include page="bottom.jsp" flush="true"/>
<jsp:include page="tail.jsp" flush="true"/>
