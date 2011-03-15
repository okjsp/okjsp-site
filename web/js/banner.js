var Banner = {
main : [
{
tag: '<a href="/f.jsp?http://www.devmento.co.kr/devmain/seminar/edumento_detail.jsp?main_id=MSEM00000&dataSeq=93" target="_blank">' +
'<img src="/images/banner/devmento_googleappengine_473x98.gif" ' +
'alt="구글 앱 엔진과 모바일 개발">' +
'</a>'
},
{
tag: '<a href="/f.jsp?http://www.devlec.com/?_pageVariable=OKJSP" target="_blank">' +
'<img src="http://www.devlec.com/images/devlec_okjsp.gif" ' +
'alt="▒▒▒ 데브렉 ▒▒▒ 개발자를 위한 국내 최고 프로그래밍 전문 동영상강좌 사이트">' +
'</a>'
}
],
show : function() {
	var idx = Math.floor(Math.random() * Banner.main.length);
	document.write(this.main[idx].tag);
}
};
