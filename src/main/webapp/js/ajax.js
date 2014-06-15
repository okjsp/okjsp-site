function processAjax(url, params, callback) {
	var req = getXMLHttpRequest();
	req.onreadystatechange = function() {
		if (req.readyState == 4) {
			if(req.status == 200) {
				eval(callback+"(req)");
			}
		}
	}
	url = url + params + "&t=" + new Date().getTime();
	req.open("GET", url, true);
	req.send("");

}
// function from http://www-128.ibm.com/developerworks/kr/library/j-ajax1/index.html
function getXMLHttpRequest() {

  var xmlreq = false;

  if (window.XMLHttpRequest) {
    // Create XMLHttpRequest object in non-Microsoft browsers
    xmlreq = new XMLHttpRequest();
  } else if (window.ActiveXObject) {
    // Create XMLHttpRequest via MS ActiveX
    try {
      // Try to create XMLHttpRequest in later versions
      // of Internet Explorer
      xmlreq = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e1) {
      // Failed to create required ActiveXObject
      try {
        // Try version supported by older versions
        // of Internet Explorer
        xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (e2) {
        // Unable to create an XMLHttpRequest with ActiveX
      }
    }
  }

  return xmlreq;
}