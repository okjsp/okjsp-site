// code from superboard.com
var nCornerWidth = 75;
var nCornerHeight = 130;
var nCornerMarginX = 2;
var nCornerMarginY = 4;
var nScrollBarWidth	= 16;
var nScrollBarHeight = 16;
var isMSIE = 0;
var Version = 3;
var nInterval = 200;
var isLoaded = 0;

function topbutton()
{
	nVersion = parseInt (navigator.appVersion);
	if (navigator.appName == "Microsoft Internet Explorer") {
		isMSIE = 1;
		if (navigator.userAgent.indexOf ("MSIE 5") != -1) { nVersion = 5; }
	} else {
		isMSIE = 0;
		if (nVersion >= 4) { window.captureEvents (Event.MOUSEMOVE); }
	}

	if (nVersion >= 4) { window.setInterval ("CornerMove();", nInterval); }
}

function CornerMove()
{
	if (isMSIE) {
		nCornerOriginX = document.body.clientWidth - idCorner.width - nCornerMarginX;
		nCornerOriginY = document.body.clientHeight - idCorner.height - nCornerMarginY;

		nCornerOriginX += document.body.scrollLeft;
		nCornerOriginY += document.body.scrollTop;

		idCorner.style.pixelLeft = 0; //nCornerOriginX;
		idCorner.style.pixelTop = nCornerOriginY;
	} else {
		nCornerOriginX = window.innerWidth + window.pageXOffset - nCornerWidth - nCornerMarginX;
		nCornerOriginY = window.innerHeight + window.pageYOffset - nCornerHeight - nCornerMarginY;

		if (window.scrollbars.visible == true) {
			nCornerOriginX -= nScrollBarWidth;
			nCornerOriginY -= nScrollBarHeight;
		}
		document.layers["idCorner"].pageX	= 0; //nCornerOriginX;
		document.layers["idCorner"].pageY	= nCornerOriginY;
	}
}

window.onload=topbutton;