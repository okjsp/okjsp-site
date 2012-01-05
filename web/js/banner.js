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
	tag: '<a href="/f.jsp?http://olc.oss.kr/">' +
	'<img src="/images/banner/olc_468x60.gif" alt="오픈소스 SW프로그래머를 위한 넉넉한 그늘"></a>'
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
    tag: '<li><A href="/f.jsp?http://bit.ly/cIQ7fA" title="안드로이드 개발환경 구축" target="android">[유료]개발매뉴얼 안드로이드 개발환경 구축</A></li>'
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
	tag: '<a href="/f.jsp?http://olc.oss.kr/">' +
	'<img src="/images/banner/olc_134x60.gif" alt="오픈소스 SW프로그래머를 위한 넉넉한 그늘"></a>'
},
 {
tag : "<li>"+
 "<a href=\"/f.jsp?http://ucloudbiz.olleh.com\" target=\"_blank\" >"+
 "<img src=\"/images/banner/ucloud_134x40.gif\" style=\"width:134px\""+
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
    		'<img class="adapp" src="/images/app/clien_150x150.png" alt="Hi Clien by iiixzu"></a>');
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

//배열선언 type, image, url
//가족 배너
var banner = new Array(
"0,,/images/bnr_koug.gif,,http://www.koug.net/,,88,,31"
);

//상업용 배너 , 친구네 배너
var bannerSponsored = new Array(
//"0,,http://whiteto.img.or.kr/images/banner/banner_05.gif,,/f.jsp?http://www.jineejinee.com/,,468,,60,,처음 okjsp를 같이 운영했던 친구네 옷가게입니다."
);

//일반 배너
var banner2 = new Array(
"0,,/images/doubleiqlogo.gif,,http://doubleiq.pe.kr/,,88,,31",
"0,,/images/bnr_javaclub.gif,,http://cafe.naver.com/javacircle.cafe,,88,,31",
"0,,/images/bnr_javajigi.gif,,http://www.javajigi.net/,,88,,31",
"1,,/images/bnr_javacafe.swf,,http://www.javacafe.or.kr/,,88,,31"
);

//고정 배너
var bannerDb = new Array(
"0,,/images/bnr_simples.png,,/f.jsp?http://simples.kr/,,88,,31",
"0,,/images/bnr_itnodong.png,,/f.jsp?http://it.nodong.net/,,88,,31",
"0,,/images/bnr_acornpub_88x31.gif,,/f.jsp?http://www.acornpub.co.kr/blog/,,88,,31",
"0,,/images/bnr_oracleclub.gif,,http://www.oracleclub.com/,,88,,31",
"0,,http://apmtip.com/images/banner/apmtip.gif,,http://apmtip.com/,,88,,31",
"0,,http://www.kkaok.pe.kr/images/kkaokon.gif,,http://www.kkaok.pe.kr/,,88,,31",
"0,,/images/hanajava.gif,,http://www.hanajava.net/,,88,,31",
"0,,http://angel.sarang.net/images/angel.gif,,http://angel.sarang.net/,,88,,31",
"0,,http://www.jazzvm.net/banners/jazzvm.gif,,http://www.jazzvm.net/,,88,,31"
);

//나만 보는 배너
var bannerHidden = new Array(
"0,,/images/bnr_nettop.gif,,http://www.nettop.pe.kr/,,88,,31",
"0,,http://www.j2eestudy.co.kr/banner/J2ee_logo_small.jpg,,http://www.j2eestudy.co.kr/,,88,,31",
"0,,/images/bnr_openaudio_small.gif,,/f.jsp?http://www.openaudio.co.kr/,,88,,31",
"0,,/images/bnr_jongsclub.gif,,http://www.jongsclub.com/,,88,,31",
"0,,/images/bnr_theserverside.gif,,http://www.theserverside.com/,,88,,31",
"0,,http://www.javaservice.net/~java/bbs/images/banner/jsn88x31.gif,,http://www.javaservice.net/,,88,,31",
"0,,/images/bnr_openseed.gif,,http://openseed.net/,,88,,31",
"0,,/images/jspinsider.gif,,http://www.jspinsider.com/,,88,,31",
"0,,/images/bnr_sfnet.gif,,http://sf.net/,,88,,31",


"0,,/images/bnr_bizcom.gif,,http://bizcom.kookmin.ac.kr/",
"0,,http://www.jspschool.com/images/logos.gif,,http://www.jspschool.com/",
"0,,http://www.javasun.net/img/javasun.gif,,http://www.javasun.net/",
"0,,/images/bnr_jspnet.gif,,http://www.neoburi.com/",

"0,,/images/HIMTON_BANNER2.jpg,,http://www.himton.com/,,88,,31",
"0,,http://www.flex.or.kr/images/banner/bnr_flexorkr_8831.gif,,http://www.flex.or.kr/,,88,,31",
"0,,http://aboutjsp.com/image/banner.gif,,http://www.aboutjsp.com/",
"0,,/images/bnr_salthome.gif,,http://www.salthome.com/,,jboss정보",
"0,,/images/bnr_javapattern.gif,,http://www.javapattern.info/",
"0,,/images/4OffLine.gif,,http://www.4offline.org/",
"0,,/images/bnr_javastudy.gif,,http://www.javastudy.co.kr/",
"0,,/images/bnr_jlab.gif,,http://www.jlab.net/",
"1,,http://www.kimho.pe.kr/khbanner/kimhologo.swf,,http://www.kimho.pe.kr/,,88,,31",
"0,,/images/bnr_iasandcb.gif,,http://www.iasandcb.pe.kr/",
"0,,/images/bnr_bawoo.gif,,http://www.bawoo.pe.kr/",
"0,,/images/bnr_50001.gif,,http://www.50001.com/",
"0,,/images/konanlogo.jpg,,http://www.sqler.pe.kr/",

"1,,http://www.taeyo.pe.kr/main/youngji/taeyo_newwin.swf,,88,,31",
"0,,http://www.superuser.co.kr/main/rogo.gif,,http://www.superuser.co.kr/",
"0,,/images/kldp.gif,,http://www.kldp.org/",

"0,,/images/bnr_kmoon.gif,,http://www.kmoon.co.kr"
);
/*
보류중인 배너
"0,,http://whiteto.img.or.kr/images/banner/banner_06.gif,,/f.jsp?http://www.jineejinee.com/,,88,,32",
"0,,/images/jspmaster.gif,,http://www.jspmaster.com/",
"0,,/images/fontpiabn3.gif,,http://www.fontpia.co.kr/",
"0,,/images/bnr_suribada.gif,,http://www.suribada.com/",
"0,,/images/bnr_ehanbit.gif,,http://www.ehanbit.net/",
"0,,/images/bnr_pohangsi.gif,,http://www.pohangsi.com/",
"0,,http://steelheart.pe.kr/image/banner/steelheart.pe.kr.gif,,http://steelheart.pe.kr/",
"0,,/images/bnr_developerclub.gif,,http://www.developerclub.com/"
"0,,http://javacool.net/image/banner/javacool1.gif,,http://javacool.net/",
"0,,/images/bnr_javacraft.gif,,http://www.freechal.com/ejbstudy/"
"0,,/images/bnr_javacan.gif,,http://javateam.korea.ac.kr/javacan/",
"1,,http://doubleiq.pe.kr/img/lastcom_banner.swf",
"0,,http://www.java2java.com/images/banner/java2java.gif,,http://www.java2java.com/",
"0,,http://211.187.137.221:9999/images/oracleib.gif,,http://www.oraclei.net/",
"0,,/images/bnr_mute.gif,,http://www.mutecast.net/"
*/
