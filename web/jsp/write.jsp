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
    <script src="/js/okjsp.js"></script>
    <script src='/js/okboard.js'></script>
    <script src='/js/ban.js'></script>
    <script src='/js/edit.js'></script>
    <script src="/js/bannerData.js"></script>
    <link rel="stylesheet" href="/css/style.css" type="text/css">
    <link rel="stylesheet" href="/css/okjsp2007.css.jsp" type="text/css">
    <title>okjsp write</title>
</head>
<body class="body" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="/top.jsp" />
<table class="bbsTable">
  <tr>
    <td width='120' valign='top'>
      <jsp:include page="/menu.jsp" />
    </td>
    <td valign='top'>
<%
String adBanner= (String)request.getAttribute("AdBanner");
if (adBanner != null) {
%>
<table width="650" border="0" cellpadding="3" cellspacing="0">
    <tr>
        <td class="td" align="center"><script>bannerShuffle(<%= adBanner %>, 1, 1);</script></td>
    </tr>
</table>
<%
} // end if (bannerName != null)
%>

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
<form name="f1" method="post" ENCTYPE="multipart/form-data" onSubmit="return check()">
<table border="0" cellspacing="0" cellpadding="0">
<input type="hidden" name="bbs" value="<c:out value="${param.bbs}"/>">
<input type="hidden" name="pg" value="<c:out value="${param.pg}"/>">
<input type="hidden" name="act" value="<c:out value="${requestScope.pact}"/>">
<input type="hidden" name="seq" value="<c:out value="${article.seq}"/>">
<input type="hidden" name="ref" value="<c:out value="${article.ref}"/>">
<input type="hidden" name="lev" value="<c:out value="${article.lev}"/>">
<input type="hidden" name="step" value="<c:out value="${article.step}"/>">
  <tr>
    <td>닉네임</td>
    <td>
      <input type="text" name="writer" 
      	value="<%= article.getWriter() %>" size="15"> ;실명쓰지마세요!
<%
    if ("Y".equals(member.getProfile())) {
        %><img src="http://www.okjsp.pe.kr/profile/<%= member.getId() %>.jpg"
        	alt="<%= member.getId() %>"
        	style="width:16px"> <span class="tiny">logged in</span><%
    }
%>
    </td>
    <td>비밀번호</td>
    <td>
      <input type="password" name="password" 
		value="<%= CommonUtil.nchk(request.getParameter("password")) %>" size="15">
    </td>
  </tr>
  <tr>
    <td>Email</td>
    <td colspan="3">이름+Email=개인식별가능정보; 그래서 안 받습니다.</td>
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
    <td>제목</td>
    <td colspan="3">
      <input type="text" name="subject" value="<c:out value="${article.subject}" />" size="66">
<% if (isMSIE) { %>
      <input type="checkbox" name="html" value="2" checked onClick="changeToSource()"> 웹보기
<% } else { %>
      <input type="hidden" name="html" value="0">
<% } %>
    </td>
  </tr>
  <tr>
    <td valign="top" height="163">내용</td>
    <td colspan="3" valign="top" height="163">
<% if (isMSIE) { %>
<font id='TextMode' style='display:inline'>
<fieldset class='SelectBar'>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'Cut');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconCut.gif'border='0' alt='잘라내기(Ctrl + X)'></button>
<button OnClick="SelectionCommand(this,'Copy');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconCopy.gif'border='0' alt='복사(Ctrl + C)'></button>
<button OnClick="SelectionCommand(this,'Paste');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconPaste.gif'border='0' alt='붙여넣기(Ctrl + V)'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'Bold');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconBold.gif'border='0' alt='볼드체(Ctrl + B)'></button>
<button OnClick="SelectionCommand(this,'Italic');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconItalic.gif'border='0' alt='이탤릭체(Ctrl + I)'></button>
<button OnClick="SelectionCommand(this,'Underline');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconUnderline.gif'border='0' alt='밑줄(Ctrl + U)'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'JustifyLeft');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconLeft.gif'border='0' alt='좌측정렬'></button>
<button OnClick="SelectionCommand(this,'JustifyCenter');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconCenter.gif'border='0' alt='가운데정렬'></button>
<button OnClick="SelectionCommand(this,'JustifyRight');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconRight.gif'border='0' alt='우측정렬'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'Indent');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconIndent.gif'border='0' alt='들여쓰기 늘임'></button>
<button OnClick="SelectionCommand(this,'Outdent');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconOutdent.gif'border='0' alt='들여쓰기 줄임'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'InsertOrderedList');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconOrdered.gif'border='0' alt='번호있는 목록'></button>
<button OnClick="SelectionCommand(this,'InsertUnOrderedList');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconUnOrdered.gif'border='0' alt='번호없는 목록'></button>
<img src='/images/edit/MenuIcon/distinct.gif' border='0' align='absmiddle' WIDTH='2' HEIGHT='18'>&nbsp;
<button OnClick="SelectionCommand(this,'CreateLink');" class='BtnImg' OnMouseOver='ButtonUp(this);' OnMouseOut='ButtonOut(this);'>
<img src='/images/edit/MenuIcon/IconRelate.gif'border='0' alt='HyperLink'></button>
</fieldset></font>

<font id='TextMenuView' oncontextmenu='return false' onselectstart='return false'>

<fieldset class='TextMenuBar'>
<table cellpadding='3' cellspacing='0' border='0'><tr><td>
<select class='solid' onchange="block_style(this, 'fontName')" onblur='this.selectedIndex=0;TextEditor.focus();'>
<option value>글꼴
<option value>------------
<option value='굴림'>굴림
<option value='궁서'>궁서
<option value='돋움'>돋움
<option value='바탕'>바탕
<option value='Arial'>Arial
<option value='Arial Black'>Arial Black
<option value='Courier New'>Courier New
<option value='Impact'>Impact
<option value='Verdana'>Verdana
<option value='Webdings'>Webdings
<option value='Wingdings'>Wingdings
</select>&nbsp;&nbsp;
<select class='solid' onchange="block_style(this, 'FontSize')" onblur='this.selectedIndex=0;'>
<option value>크기
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
<option value>글자색
<option value>기본색
<option value='white'>흰색
<option value='gray'>회색
<option value='#ffff90'>연한노랑
<option value='#ffffcf'>베이지
<option value='#cf9000'>황토색
<option value='maroon'>적갈색
<option value='#ff9000'>주황색
<option value='red'>빨간색
<option value='#9090ff'>연보라색
<option value='#902fcf'>보라색
<option value='#cfffff'>옅은하늘색
<option value='0099cc'>옅은파란색
<option value='#6666FF'>파란색
<option value='#2fff2f'>연두색
<option value='green'>녹색
<option value='black'>검정색
</select>&nbsp;&nbsp;
<img src='/images/edit/MenuIcon/IconFontBG.gif' border='0' align='absmiddle'>
<select class='solid' onchange="ChFontColor(this.value,'BackColor')" onblur='this.selectedIndex=0;'>
<option value>글자배경색
<option value>기본색
<option value='black'>검정색
<option value='green'>녹색
<option value='#2fff2f'>연두색
<option value='#6666FF'>파란색
<option value='0099cc'>옅은파란색
<option value='#cfffff'>옅은하늘색
<option value='#902fcf'>보라색
<option value='#9090ff'>연보라색
<option value='red'>빨간색
<option value='#ff9000'>주황색
<option value='maroon'>적갈색
<option value='#cf9000'>황토색
<option value='#ffffcf'>베이지
<option value='#ffff90'>연한노랑
<option value='gray'>회색
<option value='white'>흰색
</select>&nbsp;&nbsp;
</td>
<td>
</td></tr>
</table>
</fieldset></font>

<textarea style='display:none' name=content><%=CommonUtil.rplc(article.getContent(), "&lt;", "&amp;lt;")%></textarea>
<input type=hidden name=bg_color value=white>
<font id='TextEditView' style='width:480px; height:310px;display: inline;'>
<iframe id='TextEditor' marginwidth='2' marginheight='1' style='width:480px; height:310px;'>
</iframe>
</font>
<textarea id='TextView'
style='border:1 solid; border-color:#D4D4D4; width:480px; height:310px;display: none;'></textarea>
<% } else { %>
<textarea style="width:480px; height:310px" name=content><%= article.getContent() %></textarea>
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
	<option value="0">Copyright-저작자(email소유자)에게 저작권</option>
	<option value="1">CCL-저작자표시</option>
	<option value="2">CCL-저작자표시-동일조건변경허락</option>
	<option value="3">CCL-저작자표시-변경금지</option>
	<option value="4">CCL-저작자표시-비영리</option>
	<option value="5">CCL-저작자표시-비영리-동일조건변경허락</option>
	<option value="6">CCL-저작자표시-비영리-변경금지</option>
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
%><input type="checkbox" name="delFile" value="<%= df.getFseq() %>">삭제
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
    <input type="submit" value="보내기" name="send" style="width:50">
    &nbsp;
    <input type="button" value="취소" onClick="history.back()" style="width:50">
  </td></tr>
</table>

</form>
<jsp:include page="/footer.jsp" />

    </td>
  </tr>
</table>
<script>
  init();
  document.f1.password.focus();
</script>
</body>
</html>
