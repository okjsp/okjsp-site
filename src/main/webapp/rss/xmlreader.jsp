<%@page pageEncoding="utf-8" %>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
var jq = $.get("/rss/proxy.jsp?feed=http://openapi.seoul.go.kr:8088/xml/sample/서울시 강우량 정보/1/50&c=utf-8&r=1")
.success(function(){$("#result").val("a"+jq.responseText);})
.error(function(){$("#result").val("e"+jq.responseText);})
;
});
</script>
</head>
<body>
<textarea id="result"></textarea>
</body>
</html>