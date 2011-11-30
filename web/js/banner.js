var Banner = {
main : [
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
	tag: '<a href="/f.jsp?http://80port.com/">' +
	'<img src="/images/banner/80port_banner_468x60.jpg" alt="OKJSP를 후원하는 호스팅 회사 80port닷컴"></a>'
}
],

left : [
{
	tag: '<li><A href="/f.jsp?http://www.innorix.com/DS/" title="대용량 파일/폴더 업로드 컴포넌트" target="innorix">업로드는 InnoDS</A></li>'
},
{
    tag: '<li><A href="/f.jsp?http://okmindmap.com/" title="웹기반 협업 마인드맵, OKJSP 회원 박기원님이 참여한 서비스" target="imaso">okmindmap</A></li>'
},
{
    tag: '<li><A href="/f.jsp?http://bit.ly/cIQ7fA" title="안드로이드 개발환경 구축" target="android">[유료]안드로이드 개발매뉴얼1</A></li>'
}
],
footer : [
{
    tag: '<a href="/f.jsp?https://www.adobe.com/cfusion/tdrc/index.cfm?product=flash_builder&loc=ko&promoid=JEKVX">' +
    '<img src="/images/banner/adobe_flex45_468x60.jpg" alt="안드로이드부터 아이패드까지 모든 앱 개발 지원 Flash Builder 4.5 체험판을 경험해 보세요!"></a>'
},
{
	tag: '<a href="/f.jsp?http://80port.com/">' +
	'<img src="/images/banner/80port_banner_468x60.jpg" alt="OKJSP를 후원하는 호스팅 회사 80port닷컴"></a>'
}
],

aside : [
 {
 tag : "<li>"+
 "<a href=\"/f.jsp?http://academy.w3labs.kr/?page_id=518\" target=\"_blank\" >"+
 "<img src=\"/images/banner/w3labs_134x60.jpg\" "+
 "  alt=\"HTML5 모바일앱 Developer 과정; 미래웹기술연구소 아카데미\">"+
 "</a>"+
 "</li>"
},
{
	tag : "<li>"+
	"<a href=\"/f.jsp?http://project.oss.kr/?okjsp\" target=\"_blank\" >"+
	"<img src=\"/images/banner/opensw_134x40.gif\" "+
	"  alt=\"2011 공개SW개발자대회\">"+
	"</a>"+
	"</li>"
},
 {
tag : "<li>"+
 "<a href=\"/f.jsp?http://cs.ucloud.com\" target=\"_blank\" >"+
 "<img src=\"/images/banner/ucloud_134x40.gif\" "+
 "  alt=\"KT Ucloud\" ></a>"+
 "</li>"
 }
],
show : function() {
    var idx = Math.floor(Math.random() * this.main.length);
    document.write(this.main[idx].tag);
},

showAside : function() {
    document.writeln("<ul>");
    for(var i = 0; i < this.aside.length; i++) {
        document.writeln(this.aside[i].tag);
    }
    document.writeln("</ul>");
    document.writeln('<p id="adinfo"><a href="/seq/163503">광고문의</a></p>'+
    		'<a href="http://itunes.apple.com/app/id439910698?mt=8" target="_blank">'+
    		'<img class="adapp" src="http://a5.mzstatic.com/us/r1000/097/Purple/e0/96/dd/mzl.rlflfibg.175x175-75.jpg" alt="Hi Clien by iiixzu"></a>');
},

showLeftSide : function() {
    for(var i = 0; i < this.left.length; i++) {
        document.writeln(this.left[i].tag);
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
