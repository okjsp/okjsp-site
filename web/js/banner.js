var Banner = {
main : [
{
tag: '<a href="/f.jsp?http://www.choongang.co.kr/html/m0_s1_4_s1.asp?id=26200" target="_blank">' +
'<img src="/images/banner/choongang_473x98.gif" ' +
'alt="국비지원 IT 취업연수생 모집"></a>'
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
    tag: '<a href="/f.jsp?http://www.gsion.com/?okjsp" target="_blank">' +
    '<img src="http://www.GSION.com/Files/NIF/201107/jsp배너.JPG" ' +
    'alt="정보처리기술사의 모든 것 지아이에스에서 확인하세요!"></a>'
}
           
],

left : [
{
    tag: '<li><A href="/f.jsp?http://www.innorix.com/DS/" title="대용량 파일/폴더 업로드 컴포넌트" target="innorix">업로드는 InnoDS</A></li>'
},
{
    tag: '<li><A href="/f.jsp?http://okmindmap.com/" title="웹기반 협업 마인드맵, OKJSP 유저 박기원님이 참여한 서비스" target="imaso">okmindmap</A></li>'
},
{
    tag: '<li><A href="/f.jsp?http://bit.ly/cIQ7fA" title="안드로이드 개발환경 구축" target="android">[유료]안드로이드 개발매뉴얼1</A></li>'
}
],
footer : [
{
    tag: '<a href="/f.jsp?http://raction.tistory.com/">' +
    '<img src="/images/banner/raction_468x60.png" alt="공짜 가라사대 랙션하라"></a>'
}
],

aside : [
 {
tag : "<li>"+
"<a href=\"/f.jsp?http://www.devmento.co.kr\" target=\"_blank\" >"+
"<img src=\"/images/banner/devmento_134x60.gif\" "+
"   alt=\"개발자들의 지식공유 쉼터 데브멘토\">"+
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
