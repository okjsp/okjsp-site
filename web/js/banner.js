var Banner = {
main : [
{
	tag: '<a href="/f.jsp?http://www.devmento.co.kr/" target="_blank">' +
	'<img src="/images/banner/devmento_okjsp_473x98.gif" ' +
	'alt="개발 & 기술 동영상 콘텐츠가 가장 많은 곳"></a>'
},
{
	tag: '<a href="/f.jsp?http://www.devlec.com/?_pageVariable=OKJSP" target="_blank">' +
	'<img src="http://www.devlec.com/images/devlec_okjsp.gif" ' +
	'alt="▒▒▒ 데브렉 ▒▒▒ 개발자를 위한 국내 최고 프로그래밍 전문 동영상강좌 사이트"></a>'
}
],

contentRight : [
],

content : [
{
	tag: '<a href="/f.jsp?http://olc.oss.kr/">' +
	'<img src="/images/banner/olc_468x60.gif" alt="오픈소스 SW프로그래머를 위한 넉넉한 그늘"></a>'
}
],

left : [
{
	tag: '<li><A href="/f.jsp?http://www.innorix.com/DS/" title="대용량 파일/폴더 업로드 컴포넌트" target="innorix">업로드는 InnoDS</A></li>'
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
	tag: '<a href="/f.jsp?http://project.oss.kr/">' +
	'<img src="/images/banner/oss_project_150x67.gif" alt="OSS World Challenge 2012, 6th 공개소프트웨어 개발자 대회"></a>'
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

