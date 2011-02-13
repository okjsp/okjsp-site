var Banner = {
main : [
{
tag:'<img src="/images/banner/devmento_banner_468x60.gif" usemap="#seminar_banner_Map">' +
	'<map name="seminar_banner_Map">' +
	'<area shape="rect" alt="데브멘토 세미나 모바일 서비스 디자인 & 개발" coords="0,0,233,60" href="/f.jsp?http://www.devmento.co.kr/devmain/seminar/edumento_detail.jsp?dataSeq=89" target="_new">' +
	'<area shape="rect" alt="데브멘토 세미나 구글 앱 엔진과 모바일 개발" coords="233,0,468,60" href="/f.jsp?http://www.devmento.co.kr/devmain/seminar/edumento_detail.jsp?dataSeq=90" target="_new">' +
	'</map>'
},
{
tag: '<a href="/f.jsp?http://www.devlec.com/?_pageVariable=OKJSP" target="_blank">' +
'<img src="http://www.devlec.com/images/devlec_okjsp.gif" ' +
'alt="▒▒▒ 데브렉 ▒▒▒ 개발자를 위한 국내 최고 프로그래밍 전문 동영상강좌 사이트">' +
'</a>'
}
],
show : function() {
	var index = Math.floor(Math.random() * 2);
	document.write(this.main[index].tag);
}
};
