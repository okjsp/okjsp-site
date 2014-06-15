  <%@ page import="java.util.*, java.io.*, java.net.*, java.security.*, java.math.*, java.text.*" %>
<%
// AdMob Publisher Code
// Language: JSP (JavaSE 1.5 required)
// Version: 20081105
// Copyright AdMob, Inc., All rights reserved
// Documentation at http://developer.admob.com/wiki/Main_Page

Map<String,String> admobRequiredParams = new HashMap<String,String>();
Map<String,Boolean> admobControlParams = new HashMap<String,Boolean>();
Map admobOptionalParams = new HashMap<String,String>();

admobRequiredParams.put("PUBLISHER_ID", "a14bb575d66d673"); // Required to request ads. To find your Publisher ID, log in to your AdMob account and click on the "Sites & Apps" tab.
admobRequiredParams.put("ANALYTICS_ID", "your_analytics_site_id"); // Required to collect Analytics data. To find your Analytics ID, log in to your Analytics account and click on the "Edit" link next to the name of your site.
admobRequiredParams.put("COOKIE_DOMAIN", null); // If your mobile site uses multiple subdomains, replace "null" with your root domain (e.g. "example.com") to make the AdMob cookie visible across subdomains.
admobControlParams.put("AD_REQUEST", true);  // To request an ad, set to true.
admobControlParams.put("ANALYTICS_REQUEST", false); // To enable the collection of analytics data, set to true.
admobControlParams.put("TEST_MODE", false);  // While testing, set to true. When you are ready to make live requests, set to false.
// Additional optional parameters are available at: http://developer.admob.com/wiki/AdCodeDocumentation    
// admobOptionalParams.put("title", "Enter Page Title Here"); // Analytics allows you to track site usage based on custom page titles. Enter custom title in this parameter.
// admobOptionalParams.put("event", "Enter Event Name here"); // To learn more about events, log in to your Analytics account and visit this page: http://analytics.admob.com/reports/events/add

// Send request to AdMob. To make additional ad requests per page, copy and paste this function call elsewhere on your page.
out.print(admobRequest(request, response, pageContext, admobRequiredParams, admobControlParams, admobOptionalParams));
%>

<%!
/////////////////////////////////
// Do not edit below this line //
/////////////////////////////////

// This section defines AdMob functions and should be used AS IS.
// We recommend placing the following code in a separate file that is imported where needed. 

public String admobRequest(HttpServletRequest request, HttpServletResponse response, PageContext pageContext, 
                           Map<String,String> requiredParams, Map<String,Boolean> controlParams, Map<String,String> optionalParams) {
  if (requiredParams == null || controlParams == null)
    return "";

  StringBuilder admobReturn = new StringBuilder();
  try {
    Boolean adMode = false;
    if (requiredParams.get("PUBLISHER_ID") != null && controlParams.get("AD_REQUEST") != null)
      adMode = controlParams.get("AD_REQUEST");
      
    Boolean analyticsMode = false;
    Boolean pixelSent = (pageContext.getAttribute("admobPixelSent") == "true") ? true : false;
    if (requiredParams.get("ANALYTICS_ID") != null && controlParams.get("ANALYTICS_REQUEST") != null && !pixelSent)
      analyticsMode = controlParams.get("ANALYTICS_REQUEST");
      
    String rt = adMode ? (analyticsMode ? "2" : "0") : (analyticsMode ? "1" : "-1");
    if (rt == "-1") return "";
    
    double now = System.currentTimeMillis()/(double)1000;
    DecimalFormat df = new DecimalFormat("0.000");
    String z = df.format(now);
    String p = request.getRequestURL().toString() + (request.getQueryString() == null ? "" : "?" + request.getQueryString().toString());
    String o = admobGetCookieValue(request, response, pageContext, requiredParams.get("COOKIE_DOMAIN"));
    
    StringBuilder admobContents = new StringBuilder();
    admobAppendParams(admobContents, "rt", rt);
    admobAppendParams(admobContents, "z", z);
    admobAppendParams(admobContents, "u", request.getHeader("User-Agent"));
    admobAppendParams(admobContents, "i", request.getRemoteAddr());
    admobAppendParams(admobContents, "p", p);
    admobAppendParams(admobContents, "t", admobMd5(request.getSession() == null ? null : request.getSession().getId()));
    admobAppendParams(admobContents, "v", "20081105-JAVA15-b9c74666c607fc70");
    admobAppendParams(admobContents, "o", o);
    if (adMode) admobAppendParams(admobContents, "s", requiredParams.get("PUBLISHER_ID"));
    if (analyticsMode) admobAppendParams(admobContents, "a", requiredParams.get("ANALYTICS_ID"));
    
    if (optionalParams != null) {
      for (Map.Entry<String, String> entry : optionalParams.entrySet()) {
        admobAppendParams(admobContents, entry.getKey(), entry.getValue());
      }
    }
    
    List<String> ignoreHeaders = Arrays.asList(new String[]{"PRAGMA", "CACHE-CONTROL", "CONNECTION", "USER-AGENT", "COOKIE"});
    for (Enumeration<String> names = request.getHeaderNames(); names.hasMoreElements();) {
      String name = names.nextElement();
      if (!ignoreHeaders.contains(name.toUpperCase()))
        admobAppendParams(admobContents, "h["+name+"]", request.getHeader(name));
    }

    if (controlParams.get("TEST_MODE") != null && controlParams.get("TEST_MODE")) admobContents.append("&m=test");
    
    BufferedReader admobReader = null;
    int ADMOB_TIMEOUT = 1000; // 1 second timeout
    long start = System.currentTimeMillis();
    try {
      URL admob_url = new URL("http://r.admob.com/ad_source.php");
      HttpURLConnection admobConnection = (HttpURLConnection)admob_url.openConnection();
      admobConnection.setRequestMethod("POST");
      admobConnection.setDoOutput(true);
      admobConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
      admobConnection.setRequestProperty("Content-Length", Integer.toString(admobContents.length()));
      admobConnection.setConnectTimeout(ADMOB_TIMEOUT);
      admobConnection.setReadTimeout(ADMOB_TIMEOUT);
      BufferedWriter admobWriter = new BufferedWriter(new OutputStreamWriter(admobConnection.getOutputStream()));
      admobWriter.write(admobContents.toString());
      admobWriter.close();
      admobReader = new BufferedReader(new InputStreamReader(admobConnection.getInputStream()));
      
      for (String line; (line = admobReader.readLine()) != null;)
        admobReturn.append(line);
    }
    catch (Exception e) {admobReturn.setLength(0);}
    finally {if (admobReader != null) admobReader.close();} 
    long stop = System.currentTimeMillis();
    
    if (!pixelSent) {
      pageContext.setAttribute("admobPixelSent", "true");
      admobReturn.append("<img src=\"http").append(request.isSecure() ? "s" : "").append("://p.admob.com/e0?")
        .append("a=").append(analyticsMode ? requiredParams.get("ANALYTICS_ID") : "")
        .append("&amp;s=").append(adMode ? requiredParams.get("PUBLISHER_ID") : "")
        .append("&amp;z=").append(z)
        .append("&amp;o=").append(o)
        .append("&amp;lt=").append((stop - start)/(double)1000)
        .append("&amp;rt=").append(rt).append("\" alt=\"\" width=\"1\" height=\"1\"/>");
    }
  }
  catch (Exception e) {}
  return admobReturn.toString();
}

private String admobGetCookieValue(HttpServletRequest request, HttpServletResponse response, PageContext pageContext, String cookieDomain) {
  try {
    Cookie cookies[] = request.getCookies();
    if (cookies != null) {
      for (int i = 0; i < cookies.length; i++) {
        if (cookies[i].getName().equals("admobuu")) return cookies[i].getValue();
      }
    }
    
    // Set a cookie if one has not already been set
    if (pageContext.getAttribute("admobCookie") == null) {
      String value = UUID.randomUUID().toString().replace("-","");
      Cookie c = new Cookie("admobuu", value);
      c.setMaxAge(60*60*24*365*20);
      c.setPath("/");
      if (cookieDomain != null) {
        if (cookieDomain.charAt(0) != '.') cookieDomain = "." + cookieDomain;
        c.setDomain(cookieDomain);
      }
      response.addCookie(c);
      pageContext.setAttribute("admobCookie", value);
    }
    return (String)pageContext.getAttribute("admobCookie");
  }
  catch (Exception e) {
    return "";
  }
}

private String admobMd5(String val) throws Exception {
  if (val == null || val.length() == 0) return null;
  MessageDigest md5 = MessageDigest.getInstance("MD5");
  md5.update(val.getBytes(),0,val.length());
  return String.format("%032X", new BigInteger(1,md5.digest()));
}

private void admobAppendParams(StringBuilder contents, String key, String val) throws UnsupportedEncodingException {
  if (val != null && val.length() > 0) {
    if (contents.length() > 0) contents.append("&");
    contents.append(URLEncoder.encode(key, "UTF-8")).append("=").append(URLEncoder.encode(val, "UTF-8"));
  }
}
%>
  