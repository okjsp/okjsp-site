var Banner = {
main : [
	{
		"expire": '2013-04-30',
		"tag": '<a href="/f.jsp?http://www.devlec.com/?_pageVariable=OKJSP" target="_blank">' +
		'<img src="http://www.devlec.com/images/devlec_okjsp.gif" ' +
		'alt="▒▒▒ 데브렉 ▒▒▒ 개발자를 위한 국내 최고 프로그래밍 전문 동영상강좌 사이트"></a>'
	}
],
contentRight : [
],

content : [
],

left : [
{
	"expire" : "2013-06-01",
	"tag": '<li><A href="/f.jsp?http://www.innorix.com/DS/" title="대용량 파일/폴더 업로드 컴포넌트" target="innorix">업로드는 InnoDS</A></li>'
}
],
left_bnr : [
{
	"expire" : "2013-07-31",
	"tag": '<li></li>'
}
],

leftimg : [
],

footer : [
{
	tag: '<a href="/f.jsp?http://80port.com/">' +
	'<img src="/images/banner/80port_banner_468x60.jpg" alt="OKJSP를 후원하는 호스팅 회사 80port닷컴"></a>'
}
],

asideApp : [
{
	tag : '<a href="/f.jsp?https://itunes.apple.com/us/app/art-everyday-painting-gallery/id821350005?mt=8" target="_blank"><img class="adapp" '+
	'src="/upload/1394461194950.jpg" alt="예술같은 오늘"></a>'
}
],
show : function() {
	this.showOne(this.main);
},

showAside : function() {
	//document.writeln('<a href="/f.jsp?http://www.eclipse.org/donate/" target="_blank"><img src="http://eclipse.org/donate/images/friendslogo200.jpg" style="width:150px"></a>');
	//document.writeln('<a href="/f.jsp?http://www.econovation.co.kr/@page/fair/fa_intro.asp" target="kteco"><img src="/images/banner/kt_battle_180x85.jpg" style="width:150px"></a>');
	//document.writeln('<a href="/f.jsp?http://www.okjsp.net/seq/228162" target="ebu"><img src="/images/ebrainus/banner_cp_130807(180).jpg" style="width:150px"></a>');
	//document.writeln('<a href="/f.jsp?http://www.hanb.co.kr/events/funnytest/" target="ebu"><img src="/images/banner/banner_hb_130923(160).jpg" style="width:160px"></a>');
	//document.writeln('<a href="/f.jsp?http://techplanet.skplanet.com" target="skp"><img src="/images/banner/banner_skp_131025.gif" style="width:160px"></a>');
	//document.writeln('<a href="/f.jsp?http://open.egovframe.go.kr/projects/notices/event/8496" target="ebu"><img src="/images/banner/banner_superk_131001(150).jpg" style="width:150px"></a>');
	//document.writeln('<a href="/f.jsp?http://www.hanb.co.kr/events/eventview.html?event_id=cleaninfo" target="hb"><img src="/images/banner/banner_hb_131021(175).jpg" style="width:160px"></a>');
	//document.writeln('<a href="/f.jsp?https://www.facebook.com/dailymaso?ref=ts&fref=ts" target="maso"><img src="/images/banner/banner_maso_131129(160).jpg" style="width:160px"></a>');
	//document.writeln('<a href="/f.jsp?http://www.yes24.com/Event/01_Book/2014/OT0228Java.aspx?CategoryNumber=001" target="hanbit"><img src="/images/banner/banner_hb_140305_160x160_no02.jpg" style="width:160px"></a>');
	//document.writeln('<a href="/f.jsp?http://codesprint.skplanet.com/" target="skp"><img src="/images/banner/banner_skp_codesprint_140515(160).jpg" style="width:160px"></a>');
	//document.writeln('<a href="/f.jsp?http://www.acheck.co.kr/" target="cidow"><img src="/images/banner/banner_acheck_140217(160).jpg" style="width:160px"></a>');
	//document.writeln('<a href="/f.jsp?http://www.tobashop.co.kr/" target="cidow"><img src="/images/banner/banner_cidow_140716(160).gif" style="width:160px"></a>');
	//document.writeln('<a href="/f.jsp?http://www.yes24.com/24/goods/13987902?scode=032&OzSrank=17" target="yeam"><img src="/images/banner/banner_book_jsp_160x320(140812).jpg" style="width:160px"></a>');
	document.writeln('<a href="/f.jsp?http://ciscocodefest.com/" target="cisco"><img src="/images/banner/banner_cisco_140918_160x160.jpg" style="width:160px"></a>');
},

showAsideBottom : function() {
	
	var html = '<p id="adinfo"><a href="/seq/181976">광고안내</a></p>'+
	'<p class="adapp_title">&middot; app ad</p>';
	if (this.asideApp.length > 0) {
		var idx = Math.floor(Math.random() * this.asideApp.length);
		html +=	this.asideApp[idx].tag;
	}
	document.writeln(html);
},

showLeftSide : function() {
    for(var i = 0; i < this.left.length; i++) {
        document.writeln(this.left[i].tag);
    }
},

showLeftSide_bnr : function() {
    for(var i = 0; i < this.left_bnr.length; i++) {
        document.writeln(this.left_bnr[i].tag);
    }
},

showLeftSideImg : function() {
    for(var i = 0; i < this.leftimg.length; i++) {
        document.writeln(this.leftimg[i].tag);
    }
},

showContentRight : function() {
	this.showOne(this.contentRight);
},

showContentSection : function() {
	this.showOne(this.content);
},

showFooter : function() {
	//this.showOne(this.footer);
},

showOne: function(list) {
    if (list.length > 0) {
        var idx = Math.floor(Math.random() * list.length);
        document.write(list[idx].tag);
    }
}


};

