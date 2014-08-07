<%
    String url = request.getRequestURL().toString();
    if (url.contains("okjsp.pe.kr")) {
%><script>
var url = document.location.href;
url = url.replace(/okjsp.pe.kr/i,"okjsp.net")
document.location.href= url + "#" + (new Date).getTime();
</script><%
        return;
    }
%>