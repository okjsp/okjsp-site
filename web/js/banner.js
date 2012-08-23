var Banner = {
main : [
{
	"expire": '2012-08-31',
	"tag": '<a href="/f.jsp?http://www.devlec.com/?_pageVariable=OKJSP" target="_blank">' +
	'<img src="http://www.devlec.com/images/devlec_okjsp.gif" ' +
	'alt="▒▒▒ 데브렉 ▒▒▒ 개발자를 위한 국내 최고 프로그래밍 전문 동영상강좌 사이트"></a>'
},
{
	"expire": '2012-08-31',
	"tag": '<a href="/f.jsp?http://goo.gl/nZA0C" target="_blank">' +
	'<img src="/images/banner/kpc_smart_473x98.jpg" ' +
	'alt="2012 스마트콘텐츠센터 전문교육 프로그램"></a>'
},
{
	"expire": '2012-09-21',
	"tag": '<a href="/f.jsp?http://www.econovation.co.kr/School/web/SS0104.asp?tcode=8&mn_id=010608" target="_blank">' +
	'<img src="/images/banner/kpc_smart_5th_473x98.jpg" ' +
	'alt="상용화를 위한 App 개발 전문가과정 5기 Android/Hybrid App 교육생 모집안내 (야간 주말)"></a>'
}
],

contentRight : [
],

content : [
{
	tag: '<a href="/f.jsp?http://olc.oss.kr/offlec/list.jsp#okjsp">' +
	'<img src="/images/banner/olc_model_468x60.gif" alt="Spring 3.1/Script Language 과정 OLC"></a>'
}
],

left : [
{
	"expire" : "2013-06-01",
	"tag": '<li><A href="/f.jsp?http://www.innorix.com/DS/" title="대용량 파일/폴더 업로드 컴포넌트" target="innorix">업로드는 InnoDS</A></li>'
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
	"expire": "2012-08-31",
	tag: '<a href="/f.jsp?http://olc.oss.kr/offlec/list.jsp">' +
	'<img src="/images/banner/olc_model_150x67.gif" alt="Spring 3.1/Script Language 과정 OLC"></a>'
}
],

asideApp : [
{
	tag : '<a href="/f.jsp?http://itunes.apple.com/kr/app/quick-note-lite-nog-eum-noteu/id458620350?mt=8" target="_blank"><img class="adapp" '+
	'src="http://a1.mzstatic.com/us/r1000/061/Purple/v4/bc/b4/5a/bcb45adc-053f-128e-8708-2534010228e4/mza_582683320425701895.175x175-75.jpg" alt="QuickNote Lite"></a>'
},
{
	tag : '<a href="/f.jsp?http://itunes.apple.com/app/id439910698?mt=8" target="_blank"><img class="adapp" '+
	'src="/images/app/clien_150x150.png" alt="Hi Clien by iiixzu"></a>'
},
{
	tag : '<a href="/f.jsp?http://itunes.apple.com/kr/app/oghyi/id515739111?mt=8" target="_blank"><img class="adapp" '+
	'src="http://a4.mzstatic.com/us/r1000/096/Purple/v4/5d/d2/48/5dd24835-243d-9ec9-f6b1-c78691abc75b/V9809ELtPnNVvmabDtq5aw-temp-upload.siryfcqr.175x175-75.jpg" alt="옥희, 아이폰/아이패드앱"></a>'
}
],
show : function() {
    var idx = Math.floor(Math.random() * this.main.length);
    document.write(this.main[idx].tag);
},

showAside : function() {
	document.writeln('<a href="/f.jsp?http://www.eclipse.org/donate/" target="_blank"><img src="http://eclipse.org/donate/images/friendslogo200.jpg" style="width:150px"></a>');
    document.writeln("<ul>");
    for(var i = 0; i < this.aside.length; i++) {
        document.writeln("<li>"+this.aside[i].tag+"</li>");
    }
    document.writeln("</ul>");

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

showLeftSideImg : function() {
    for(var i = 0; i < this.leftimg.length; i++) {
        document.writeln(this.leftimg[i].tag);
    }
},

showContentRight : function() {
    if (this.contentRight.length > 0) {
        var idx = Math.floor(Math.random() * this.contentRight.length);
        document.write(this.contentRight[idx].tag);
    }
},

showContentSection : function() {
    if (this.content.length > 0) {
        var idx = Math.floor(Math.random() * this.content.length);
        document.write(this.content[idx].tag);
    }
},

showFooter : function() {
    var idx = Math.floor(Math.random() * this.footer.length);
    document.write(this.footer[idx].tag)
}


};

