<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ok-taglib.tld" prefix="okbbs" %>
<%@ page import="java.util.*,kr.pe.okjsp.util.CommonUtil,kr.pe.okjsp.*"
	pageEncoding="euc-kr" %>
<jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="session"/>
<jsp:useBean id="one"  class="kr.pe.okjsp.Article" scope="request"/>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler" />
    
<div data-role="page">

	<div data-role="header">
		<h1>Introduction</h1>
	</div><!-- /header -->

	<div data-role="content" role="main">

		
		<p>jQuery¡¯s mobile strategy can be summarized simply: Delivering top-of-the-line JavaScript in a unified User Interface that works across the most-used smartphone web browsers and tablet form factors.</p>

		<p>The critical difference with our approach is the <a href="platforms.html" class="ui-link">wide variety of mobile platforms we¡¯re targeting</a> with jQuery Mobile. We¡¯ve been working hard at bringing jQuery support to all mobile browsers that are sufficiently-capable and have at least a nominal amount of market share. In this way, we¡¯re treating mobile web browsers exactly how we treat desktop web browsers.</p>
		
		<p>To make this broad support possible, all pages in jQuery Mobile are built on a foundation of <strong>clean, semantic HTML</strong> to ensure compatibility with pretty much any web-enabled device. In devices that interpret CSS and JavaScript, jQuery Mobile applies <strong>progressive enhancement techniques</strong> to unobtrusively transform the semantic page into a rich, interactive experience that leverages the power of jQuery and CSS. <strong>Accessibility features</strong> such as WAI-ARIA are tightly integrated throughout the framework to provide support for screen readers and other assistive technologies.</p>
			
			
		<img src="../_assets/images/ipad-palm.png" alt="Smartphone and tablet designs" style="max-width:100%; margin-top:20px;">

						

	<div class="jqm-themeswitcher"><a href="#" data-theme="d" class="ui-btn ui-btn-up-d ui-btn-inline ui-btn-icon-left ui-btn-corner-all"><span class="ui-btn-inner ui-btn-corner-all"><span class="ui-btn-text">Switch theme</span><span class="ui-icon ui-icon-gear"></span></span></a></div></div><!-- /content -->
</div>