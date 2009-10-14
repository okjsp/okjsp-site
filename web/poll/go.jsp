<%
        String goURI = (String)session.getAttribute("goURI");
        session.removeAttribute("goURI");
        goURI=(goURI==null)?"poll_list.jsp?":goURI;
        goURI+="&fake="+System.currentTimeMillis();
        response.sendRedirect(goURI);
%>
<script> 
document.location.replace("<%=goURI%>"); 
</script> 
