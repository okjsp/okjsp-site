<%
    String url = request.getRequestURL().toString();
    if (url.contains("okjsp.pe.kr")) {
        String path = url.replaceAll("okjsp.pe.kr", "okjsp.net");
%><script>
document.location.href='<%= path%>#'+(new Date).getTime();
</script>
<%
        return;
    }
%>