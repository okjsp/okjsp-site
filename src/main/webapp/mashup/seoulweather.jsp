<%@page pageEncoding="utf-8" %>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/js/jquery/jquery.tinysort.min.js"></script>
<script type="text/javascript">
$(function(){
var rand = "#" + (new Date().getTime() / 100000);
var jq = $.get("/rss/p.jsp?http://openapi.seoul.go.kr:8088/xml/sample/서울시 강우량 정보/1/45"+rand)
  .success(list)
  .error(function(){$("#error").val(jq.responseText);})
  .complete(function(){$("#result").val(jq.responseText);})
;

$("time").html(new Date().toString());
$("button#sort").on("click", function(){ $("ul#list li").tsort(); });
});

var list = function(data) {
	var xml = $.parseXML(data);
	var rows = $(xml).children().children();
	
	var tag = "";
	rows.each(function() {
		var row = $(this);
		tag += "<li>"+row.find("GU_NAME").text()+
		 ":"+row.find("RAINFALLHOUR").text()+
		 " ("+row.find("STORED_TIME").text()+")"+"</li>"
	});
	$("#list").html(tag);
}
</script>
</head>
<body>
<h1>서울 강우량 정보</h1>
<time></time>
<br />
<button id="sort">정렬</button>
<ul id="list"></ul>
<hr>
result:
<textarea id="result"></textarea>
<br />
error:
<textarea id="error"></textarea>
<br />
<hr>
data from: <a href="http://openapi.seoul.go.kr:8088/xml/sample/서울시 강우량 정보/1/45" target="_blank">http://openapi.seoul.go.kr:8088/xml/sample/서울시 강우량 정보/1/50</a>
<br />
hosted in: <a href="http://www.okjsp.pe.kr/">http://www.okjsp.pe.kr/</a>
<jsp:include page="/googleAnalytics.jsp" />
</body>
</html>