<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page pageEncoding="euc-kr"
    import="java.util.*,kr.pe.okjsp.*,kr.pe.okjsp.util.CommonUtil" errorPage="/jsp/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:useBean id="article" class="kr.pe.okjsp.Article" scope="request"/>
<%
	boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE") > -1; 
	
	boolean isLogin = CommonUtil.getCookieLong(request, "sid") > 0;
	if (!isLogin) {
		response.sendRedirect(Navigation.getPath("LOGFORM"));
		return;
	}
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=KSC5601">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script src="/js/okjsp.js"></script>
    <script src='/js/okboard.js'></script>
    <script src='/js/ban.js'></script>
    <script src='/js/edit.js'></script>
    <script src="/js/banner.js" charset="utf-8"></script>
    <link rel="stylesheet" href="/css/style.css" type="text/css">
    <link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
    <title>okjsp write</title>
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="/top.jsp" />
<jsp:include page="/menu.jsp" />
<table class="bbsTable">
  <tr>
    <td valign='top'>
<form name="f1" method="post" ENCTYPE="multipart/form-data" onSubmit="return check()">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3">
      <c:out value="${requestScope.header}" escapeXml="false" />
    </td>
  </tr>
  <tr>
    <td colspan="3">
        <b><c:out value="${bbsInfoMap[param.bbs].name}" /></b>
    </td>
  </tr>
</table>
<input type="hidden" name="bbs" value="<c:out value="${param.bbs}"/>">
<input type="hidden" name="pg" value="<c:out value="${param.pg}"/>">
<input type="hidden" name="act" value="<c:out value="${requestScope.pact}"/>">
<input type="hidden" name="seq" value="<c:out value="${article.seq}"/>">
<input type="hidden" name="ref" value="<c:out value="${article.ref}"/>">
<input type="hidden" name="lev" value="<c:out value="${article.lev}"/>">
<input type="hidden" name="step" value="<c:out value="${article.step}"/>">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>�г���</td>
    <td>
      <input type="text" name="writer" 
      	value="<%= article.getWriter() %>" size="15"> ;�Ǹ���������!
<%
    if ("Y".equals(member.getProfile())) {
        %><img src="http://www.okjsp.pe.kr/profile/<%= member.getId() %>.jpg"
        	alt="<%= member.getId() %>"
        	style="width:16px"> <span class="tiny">logged in</span><%
    }
%>
    </td>
    <td>��й�ȣ</td>
    <td>
      <input type="password" name="password" 
		value="<%= CommonUtil.nchk(request.getParameter("password")) %>" size="15">
    </td>
  </tr>
  <tr>
    <td>Email</td>
    <td colspan="3">�̸�+Email=���νĺ���������; �׷��� �� �޽��ϴ�.</td>
  </tr>
  <tr>
    <td>Homepage</td>
    <td colspan="3">
      <input type="text" name="homepage"
        onChange="this.value=getRightURL(this.value)"
        value="<jsp:getProperty name="article"
          property="homepage"/>" size="50">
    </td>
  </tr>
  <tr>
    <td>����</td>
    <td colspan="3">
      <input type="text" name="subject" value="<c:out value="${article.subject}" />" size="66">
<% if (isMSIE) { %>
      <input type="checkbox" name="html" value="2" checked onClick="changeToSource()"> ������
<% } else { %>
      <input type="hidden" name="html" value="<%= article.getHtml() %>">
<% } %>
    </td>
  </tr>
  <tr>
    <td valign="top" height="163">����</td>
    <td colspan="3" valign="top" height="163">
<% if (isMSIE) { %>
<font id='TextMode' style='display:inline'>
<fieldset class='SelectBar'>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'Cut');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconCut.gif'border='0' alt='�߶󳻱�(Ctrl + X)'></button>
<button OnClick="SelectionCommand(this,'Copy');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconCopy.gif'border='0' alt='����(Ctrl + C)'></button>
<button OnClick="SelectionCommand(this,'Paste');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconPaste.gif'border='0' alt='�ٿ��ֱ�(Ctrl + V)'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'Bold');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconBold.gif'border='0' alt='����ü(Ctrl + B)'></button>
<button OnClick="SelectionCommand(this,'Italic');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconItalic.gif'border='0' alt='���Ÿ�ü(Ctrl + I)'></button>
<button OnClick="SelectionCommand(this,'Underline');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconUnderline.gif'border='0' alt='����(Ctrl + U)'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'JustifyLeft');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconLeft.gif'border='0' alt='��������'></button>
<button OnClick="SelectionCommand(this,'JustifyCenter');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconCenter.gif'border='0' alt='�������'></button>
<button OnClick="SelectionCommand(this,'JustifyRight');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconRight.gif'border='0' alt='��������'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'Indent');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconIndent.gif'border='0' alt='�鿩���� ����'></button>
<button OnClick="SelectionCommand(this,'Outdent');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconOutdent.gif'border='0' alt='�鿩���� ����'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'InsertOrderedList');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconOrdered.gif'border='0' alt='��ȣ�ִ� ���'></button>
<button OnClick="SelectionCommand(this,'InsertUnOrderedList');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconUnOrdered.gif'border='0' alt='��ȣ���� ���'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'CreateLink');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconRelate.gif'border='0' alt='HyperLink'></button>
</fieldset></font>

<font id='TextMenuView' oncontextmenu='return false' onselectstart='return false'>

<fieldset class='TextMenuBar'>
<table cellpadding='3' cellspacing='0' border='0'><tr><td>
<select class='solid' onchange="block_style(this, 'fontName')" onblur='this.selectedIndex=0;TextEditor.focus();'>
<option value>�۲�
<option value>------------
<option value='����'>����
<option value='�ü�'>�ü�
<option value='����'>����
<option value='����'>����
<option value='Arial'>Arial
<option value='Arial Black'>Arial Black
<option value='Courier New'>Courier New
<option value='Impact'>Impact
<option value='Verdana'>Verdana
<option value='Webdings'>Webdings
<option value='Wingdings'>Wingdings
</select>&nbsp;&nbsp;
<select class='solid' onchange="block_style(this, 'FontSize')" onblur='this.selectedIndex=0;'>
<option value>ũ��
<option value='1'>1
<option value='2'>2
<option value='3'>3
<option value='4'>4
<option value='5'>5
<option value='6'>6
<option value='7'>7
</select>&nbsp;&nbsp;
<img src='/images/edit/MenuIcon/IconFontColor.gif' border='0' align='absmiddle'>
<select class='solid' onchange="ChFontColor(this.value,'ForeColor')" onblur='this.selectedIndex=0;'>
<option value>���ڻ�
<option value>�⺻��
<option value='white'>���
<option value='gray'>ȸ��
<option value='#ffff90'>���ѳ��
<option value='#ffffcf'>������
<option value='#cf9000'>Ȳ���
<option value='maroon'>������
<option value='#ff9000'>��Ȳ��
<option value='red'>������
<option value='#9090ff'>�������
<option value='#902fcf'>�����
<option value='#cfffff'>�����ϴû�
<option value='0099cc'>�����Ķ���
<option value='#6666FF'>�Ķ���
<option value='#2fff2f'>���λ�
<option value='green'>���
<option value='black'>������
</select>&nbsp;&nbsp;
<img src='/images/edit/MenuIcon/IconFontBG.gif' border='0' align='absmiddle'>
<select class='solid' onchange="ChFontColor(this.value,'BackColor')" onblur='this.selectedIndex=0;'>
<option value>���ڹ���
<option value>�⺻��
<option value='black'>������
<option value='green'>���
<option value='#2fff2f'>���λ�
<option value='#6666FF'>�Ķ���
<option value='0099cc'>�����Ķ���
<option value='#cfffff'>�����ϴû�
<option value='#902fcf'>�����
<option value='#9090ff'>�������
<option value='red'>������
<option value='#ff9000'>��Ȳ��
<option value='maroon'>������
<option value='#cf9000'>Ȳ���
<option value='#ffffcf'>������
<option value='#ffff90'>���ѳ��
<option value='gray'>ȸ��
<option value='white'>���
</select>&nbsp;&nbsp;
</td>
<td>
</td></tr>
</table>
</fieldset></font>

<textarea style='display:none' name=content><%=CommonUtil.rplc(article.getContent(), "&", "&amp;")%></textarea>
<input type=hidden name=bg_color value=white>
<font id='TextEditView' style='width:480px; height:310px;display: inline;'>
<iframe id='TextEditor' marginwidth='2' marginheight='1' style='width:480px; height:310px;'>
</iframe>
</font>
<textarea id='TextView'
style='border:1 solid; border-color:#D4D4D4; width:480px; height:310px;display: none;'></textarea>
<% } else { %>
<textarea style="width:480px; height:310px" name=content><%= CommonUtil.rplc(article.getContent(), "&", "&amp;") %></textarea>
<% } // end if %>
    </td>
  </tr>
  <tr>
    <td></td>
    <td colspan="3">
<%
	String bbs = request.getParameter("bbs");
	if ("bbs2".equals(bbs) ||
		"bbs4".equals(bbs) ||
		"TOOL".equals(bbs) ||
		"weblogic".equals(bbs) ||
		"xmltip".equals(bbs) ||
		"bbs7".equals(bbs) ||
		"bbs6".equals(bbs) ||
		"test".equals(bbs) ||
		"docs".equals(bbs)
		) {
%>
    <div>
<select name="ccl_id">
	<option value="0">Copyright-������(email������)���� ���۱�</option>
	<option value="1">CCL-������ǥ��</option>
	<option value="2">CCL-������ǥ��-�������Ǻ������</option>
	<option value="3">CCL-������ǥ��-�������</option>
	<option value="4">CCL-������ǥ��-�񿵸�</option>
	<option value="5">CCL-������ǥ��-�񿵸�-�������Ǻ������</option>
	<option value="6">CCL-������ǥ��-�񿵸�-�������</option>
</select>
	</div>
<%
	} else {
%><input type="hidden" name="ccl_id" value="0">
<%
	} //end ccl
%><script type="text/javascript">
	document.f1.ccl_id.value = "<%= article.getCcl_id() %>";
</script>
<%
	ArrayList fileList = (ArrayList)request.getAttribute("arrdf");
	Iterator file = null;
	if (fileList != null) {
		file = fileList.iterator();
		while (file.hasNext()) {
			DownFile df = (DownFile)file.next();
			if (df.isImageFile()) {
%>&lt;img src="/upload/<%= df.getMaskName() %>"&gt;<br>
<%
			}
%><input type="checkbox" name="delFile" value="<%= df.getFseq() %>">����
<%= df.getFileName() %> <%= df.getFileSize() %> Bytes<br>
<%
		}
	}
%>
      <input type="file" name="filename4"><br>
      <input type="file" name="filename3"><br>
      <input type="file" name="filename2"><br>
      <input type="file" name="filename1"><br>
      <input type="file" name="filename0"><br>
    </td>
  </tr>
  <tr>
    <td colspan="6"></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" height="21" width="600">
  <tr>
    <td colspan="3" height="5"></td>
  </tr>
  <tr>
    <td align="center">
    <input type="submit" value="������" name="send" style="width:50">
    &nbsp;
    <input type="button" value="���" onClick="history.back()" style="width:50">
  </td></tr>
</table>
</form>
    </td>
  </tr>
</table>
<jsp:include page="/footer.jsp" />
<script>
  init();
  document.f1.password.focus();
</script>
</body>
</html>
