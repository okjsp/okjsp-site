<%@ page pageEncoding="utf-8" %>
This is a test page for jmeter of http://jakarta.apache.org/jmeter
<br />
param: p=<%= request.getParameter("p") %>
<br />
param: q=<%= request.getParameter("q") %>
<br />
nanotime: <%= System.nanoTime() %>