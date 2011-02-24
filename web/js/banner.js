var Banner = {
main : [
{
tag: '<a href="/f.jsp?http://www.devmento.co.kr/devmain/shop/shop_list.jsp" target="_blank">' +
'<img src="/images/banner/devmento_duoback_478x93.gif" ' +
'alt="어린이 공학 가방 듀오백 세트">' +
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
	document.write(this.main[1].tag);
	document.write('</li><li>');
	document.write(this.main[0].tag);
}
};
