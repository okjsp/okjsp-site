<script type="text/javascript" src="/js/prototype.js"></script>
<script type="text/javascript">
var getXmlObject = function(text) {
	if (window.ActiveXObject) {
	  var doc=new ActiveXObject("Microsoft.XMLDOM");
	  doc.async="false";
	  doc.loadXML(text);
	} else {
	  // code for Mozilla, Firefox, Opera, etc.
	  var parser=new DOMParser();
	  var doc=parser.parseFromString(text,"text/xml");
	}
	return doc;
}
var process = function(text, targetId){
       var xmlobject = getXmlObject(text);
       var title = xmlobject.getElementsByTagName('title')[0].childNodes[0].nodeValue;
       var link = xmlobject.getElementsByTagName('link')[0].childNodes[0].nodeValue;

       var tmps = xmlobject.getElementsByTagName('item');
       var output = '';
       for (var i = 0; i < tmps.length && i < 5; i++) {
           var item = tmps[i];
           var l = item.getElementsByTagName('link')[0].childNodes[0].nodeValue;
           var t = item.getElementsByTagName('title')[0].childNodes[0].nodeValue;
           output += ('<tr><td style="padding-left:30px">&middot; <a href="'+l+'">'+t+'<\/a><\/td><\/tr>');
       }
       output = 
			'<table class="tablestyle">'+
			'<tr><td class="th"><a href="'+link+'" style="font-weight:bold;">'+title+
			'<\/a> :rss<\/td><\/tr>'+
			output+'<\/table>';
       $(targetId).innerHTML = $(targetId).innerHTML + output;
     };

var loadRss = function(feed, charset, refresh) {
	var url = '/rss/rssProxy.jsp?feed='+encodeURIComponent(feed);
	if (charset == "euc-kr") {
		url += '&c='+charset;
	}
	if (refresh == "1") {
		url += '&r='+refresh;
	}
	new Ajax.Request(url,
	   {
	     method:'get',
	     onSuccess: function(transport) { 
	     				process(transport.responseText, 'rssDiv'); 
	     			},
	     onFailure: function() { alert('Something went wrong...') }
	   });
}
<%
	String refresh = request.getParameter("refresh");
%>
loadRss("http://okjsp.tistory.com/rss","utf-8","<%= refresh %>");
loadRss("http://www.ibm.com/developerworks/kr/views/rss/customrssatom.jsp?zone_by=Open+source&type_by=Articles&type_by=Tutorials&search_by=&day=1&month=01&year=2004&max_entries=10&feed_by=rss&isGUI=true&Submit.x=44&Submit.y=6","utf-8","<%= refresh %>");
loadRss("http://feeds.feedburner.com/techtarget/tsscom/home","<%= refresh %>");
loadRss("http://sdnkorea.com/blog/rss","utf-8","<%= refresh %>");
loadRss("http://www.acornpub.co.kr/blog/rss","utf-8","<%= refresh %>");
loadRss("http://me2day.net/kenu/rss","utf-8","<%= refresh %>");
</script>
<div id="rssDiv" class="rss" style="margin-left:10px"></div>