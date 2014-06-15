<%@page pageEncoding="euc-kr" %>
<%@page import="kr.pe.okjsp.util.CommonUtil"%>
<jsp:useBean id="list" class="kr.pe.okjsp.ListHandler"/>
<jsp:setProperty name="list" property="*" />

<link rel="stylesheet" href="/css/mashup.css" type="text/css">
<h2>Daum 검색 결과 찾기</h2>

<input id="q" value="<%= list.getKeyword() %>"/>
<button id="b">검색</button>

<h3>블로그 검색 결과를 표시 합니다</h3>
<ul id="r" /></ul>

<script type="text/javascript">
var obj = {
  init : function()
  {
    obj.q = document.getElementById('q');
    obj.b = document.getElementById('b');
    obj.r = document.getElementById('r');
    obj.b.onclick = obj.pingSearch;
  },
  pingSearch : function()
  {
    if (obj.q.value)
    {
      obj.s = document.createElement('script');
      obj.s.type ='text/javascript';
      obj.s.charset ='utf-8';
      var apikey = '3803541fce89370275fcefe628ed9f9acafe223e';
      obj.s.src = 'http://apis.daum.net/search/blog?apikey='+apikey
				+'&output=json&callback=obj.pongSearch&q=' + encodeURI(obj.q.value);
      document.getElementsByTagName('head')[0].appendChild(obj.s);
    }
  },
  pongSearch : function(z)
  {
    obj.r.innerHTML = '';
    for (var i = 0; i < z.channel.item.length; i++)
    {
      var li = document.createElement('li');
      var a = document.createElement('a');
      var p = document.createElement('p');
      a.href = obj.escapeHtml(z.channel.item[i].link);
      a.target = "_daum";
      a.innerHTML = obj.escapeHtml(z.channel.item[i].title);
      p.innerHTML =  obj.escapeHtml(z.channel.item[i].description);

      li.appendChild(a);
      li.appendChild(p);
      obj.r.appendChild(li);
    }
  },
  escapeHtml : function(str)
  {
    str = str.replace(/&amp;/g, "&");
    str = str.replace(/&lt;/g, "<");
    str = str.replace(/&gt;/g, ">");
    return str;
  }
};
window.onload = function()
{
	obj.init();
	obj.pingSearch();
};
</script>