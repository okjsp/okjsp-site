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

aside : [
{
	'expire': "2013-05-06",
	'tag': '<a href="/f.jsp?http://pushtk.com/D?l=6" target="_blank">' +
	'<img src="/images/banner/cena_150x67.gif" alt="푸시삼국지 시즌2"></a>'
}
],

asideApp : [
{
	tag : '<a href="/f.jsp?http://itunes.apple.com/kr/app/oghyi/id515739111?mt=8" target="_blank"><img class="adapp" '+
	'src="http://a4.mzstatic.com/us/r1000/096/Purple/v4/5d/d2/48/5dd24835-243d-9ec9-f6b1-c78691abc75b/V9809ELtPnNVvmabDtq5aw-temp-upload.siryfcqr.175x175-75.jpg" alt="옥희, 아이폰/아이패드앱"></a>'
}
],
show : function() {
	this.showOne(this.main);
},

showAside : function() {
	//document.writeln('<a href="/f.jsp?http://www.eclipse.org/donate/" target="_blank"><img src="http://eclipse.org/donate/images/friendslogo200.jpg" style="width:150px"></a>');
	//document.writeln('<a href="/f.jsp?http://olc.oss.kr/offlec/list.jsp" target="olc"><img src="/images/bnr_olc_rollingbanner-130604.gif" style="width:150px"></a>');
	document.writeln('<a href="/f.jsp?http://www.econovation.co.kr/@page/fair/fa_intro.asp" target="kteco"><img src="/images/banner/kt_battle_180x85.jpg" style="width:150px"></a>');
    document.writeln("<ul>");
    for(var i = 0; i < this.aside.length; i++) {
        document.writeln("<li>"+this.aside[i].tag+"</li>");
    }
    document.writeln("</ul>");

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
	this.showOne(this.footer);
},

showOne: function(list) {
    if (list.length > 0) {
        var idx = Math.floor(Math.random() * list.length);
        document.write(list[idx].tag);
    }
}


};

