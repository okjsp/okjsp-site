var Banner = {
main : [
{
tag: '<a href="/f.jsp?http://www.devmento.co.kr/devmain/seminar/edumento_detail.jsp?dataSeq=95" target="_blank">' +
'<img src="/images/banner/devmento_smart_marketing_473x98.gif" ' +
'alt="모바일 비즈니스 수익모델을 찾아라">' +
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
},

showAside : function() {
	document.write("<ul><li>"+
			"<a href=\"/f.jsp?http://uengine.org/web/guest/home\" target=\"_blank\">"+
			"<img src=\"http://www.uengine.org/html/images/banner/uengine_banner.gif\" "+
			"	alt=\"유엔진\" ></a>"+
			"</li>"+
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
}

};
