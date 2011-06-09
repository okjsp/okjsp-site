var Banner = {
main : [
{
tag: '<a href="/f.jsp?http://www.choongang.co.kr/html/m0_s1_4_s1.asp?id=25205&r=okjsp" target="_blank">' +
'<img src="/images/banner/choongang_473x98.gif" ' +
'alt="[전액국비무료]2011년 IT취업연수생 모집(자바,닷넷과정)">' +
'</a>'
},
{
tag: '<a href="/f.jsp?http://www.devmento.co.kr/devmain/seminar/edumento_detail.jsp?dataSeq=101" target="_blank">' +
'<img src="/images/banner/devmento_MS2_473x98.gif" ' +
'alt="실전 윈도우폰 망고 앱 디자인 & 개발">' +
'</a>'
},
{
tag: '<a href="/f.jsp?http://www.devlec.com/?_pageVariable=OKJSP" target="_blank">' +
'<img src="http://www.devlec.com/images/devlec_okjsp.gif" ' +
'alt="▒▒▒ 데브렉 ▒▒▒ 개발자를 위한 국내 최고 프로그래밍 전문 동영상강좌 사이트">' +
'</a>'
}
],

content : [
{
tag: '<a href="/f.jsp?http://raction.tistory.com/">' +
'<img src="/images/banner/raction_468x60.png" alt="공짜 가라사대 랙션하라"></a>'
},
{
tag: '<a href="/f.jsp?http://www.dbguide.net/offline.db">' +
'<img src="/images/banner/kdb_468x60.jpg" alt="한국데이터베이스진흥원"></a>'
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
show : function() {
	var idx = Math.floor(Math.random() * this.main.length);
	document.write(this.main[idx].tag);
},

showAside : function() {
	document.write("<ul>" +
			"<li>"+
			"<a href=\"/f.jsp?http://www.apptalk.tv\" target=\"_blank\" >"+
			"<img src=\"/images/banner/apptalk_134x60.jpg\" "+
			"	alt=\"세상의 모든 앱을 영상으로. 앱의 모든 것, 앱톡\">"+
			"</a>"+
			"</li>"+
			"<li>"+
			"<a href=\"/f.jsp?http://cs.ucloud.com\" target=\"_blank\" >"+
			"<img src=\"/images/banner/ucloud_134x40.gif\" "+
			"	alt=\"KT Ucloud\" ></a>"+
			"</li></ul>");
},

showLeftSide : function() {
	for(var i = 0; i < this.left.length; i++) {
		document.writeln(this.left[i].tag);
	}
},

showContentRight : function() {
	var tag = '<a href="/f.jsp?http://www.kjdc.org/?okjsp"><img src="/images/banner/JCO_250x250.gif" id="contentBanner" '+
		'style="float: right; margin-left: 10px; margin-bottom: 10px;"></a>';
	document.write(tag);
},

showContentSection : function() {
	var idx = Math.floor(Math.random() * this.content.length);
	document.write(this.content[idx].tag);
},

showFooter : function() {
	var idx = Math.floor(Math.random() * this.footer.length);
	document.write(this.footer[idx].tag)
}


};
