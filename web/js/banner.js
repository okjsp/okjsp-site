var Banner = {
main : {
	url:'http://www.devmento.co.kr/devmain/seminar/edumento_detail.jsp?dataSeq=89',
	src:'/images/banner/devmento_banner_468x60.gif',
	alt:'데브멘토 세미나 모바일 서비스 디자인 & 개발, 구글 앱 엔진과 모바일 개발'
		},
show : function() {
	document.write(
'<img src="' + this.main.src +'" usemap="#seminar_banner_Map">' +
'<map name="seminar_banner_Map">' +
'<area shape="rect" alt="데브멘토 세미나 모바일 서비스 디자인 & 개발" coords="0,0,233,60" href="/f.jsp?http://www.devmento.co.kr/devmain/seminar/edumento_detail.jsp?dataSeq=89" target="_new">' +
'<area shape="rect" alt="데브멘토 세미나 구글 앱 엔진과 모바일 개발" coords="233,0,468,60" href="/f.jsp?http://www.devmento.co.kr/devmain/seminar/edumento_detail.jsp?dataSeq=90" target="_new">' +
'</map>'
	);
}
};
