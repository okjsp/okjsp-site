var Banner = {
main : [
{   "expire": '2012-11-06',
	"tag": '<a href="/f.jsp?http://goo.gl/nZA0C" target="_blank">' +
	'<img src="/images/banner/kpc_smart_473x98.jpg" ' +
	'alt="2012 스마트콘텐츠센터 전문교육 프로그램"></a>'
},
{   "expire": '2012-11-24',
	"tag": '<a href="/f.jsp?https://econovation.co.kr/@page/camp/ca_summary.asp" target="_blank">' +
	'<img src="/images/banner/econovation_camp_473x98.jpg" ' +
	'alt="2012 에코노베이션 개발자 캠프"></a>'
}
],

contentRight : [
{   "expire": '2012-11-04',
	"tag": '<a href="/f.jsp?http://www.codesprint.kr" target="_blank" style="float:right; margin:8px; margin-right: 0">' +
	'<img src="/images/banner/skp_codesprint_210x210.gif" ' +
	'alt="개발자를 위한 코드 경진 대회 SK planet Code Sprint 2012"></a>'
}
],

content : [
{
	'expire': '2012-12-31',
	'tag': '<a href="/f.jsp?http://olc.oss.kr/offlec/list.jsp#okjsp">' +
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
{	'expire': '2012-11-20',
	'tag': '<a href="/f.jsp?http://www.venster.co.kr/#ok">' +
	'<img src="/images/banner/venster_150x67.gif" alt="벤처 전문 리크루팅 서비스 벤스터"></a>'
},
{
	'expire': "2012-12-31",
	'tag': '<a href="/f.jsp?http://olc.oss.kr/offlec/list.jsp">' +
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
	this.showOne(this.main);
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

